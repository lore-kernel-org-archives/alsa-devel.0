From: Stephen Warren <swarren@nvidia.com>
Subject: purify_inactive_streams and Azalia controllers with >1
	codec
Date: Thu, 19 Aug 2010 12:08:59 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF02FE3765BF@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id C246B1037F2
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 21:09:03 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

NVIDIA GPUs that contain Azalia controllers currently all have 1 controller,
each having 4 codecs, each having 1 converter.

I think there's a logic bug in hda_codec.c:purify_inactive_streams();
streams are controller-wide, but purify_inactive_streams() only cleans up the
converters a single codec as far as I can tell.

I think the solution is to rewrite purify_inactive_streams() as follows:

static void purify_inactive_streams(struct hda_codec *codec)
{
	struct hda_codec *itercodec;
	int i;

	list_for_each_entry(itercodec, &codec->bus->codec_list, list) {
		for (i = 0; i < itercodec->cvt_setups.used; i++) {
			struct hda_cvt_setup *p = snd_array_elem(&itercodec->cvt_setups, i);
			if (p->dirty)
				really_cleanup_stream(itercodec, p);
		}
	}
}

This alone doesn't work; had_codec.c:snd_hda_codec_setup_stream() also needs
a similar loop when setting the dirty flag.

However, this still doesn't work; as best I can tell,
patch_nvhdmi.c:nvhdmi_dig_playback_pcm_prepare_8ch_89() never calls
snd_hda_codec_setup_stream(). This is where I need help.

patch_nvhdmi.c:nvhdmi_dig_playback_pcm_prepare_8ch_89() and
patch_intelhdmi.c:nvhdmi_dig_playback_pcm_prepare_8ch_89() are identical;
both call patch_hdmi.c:hdmi_setup_stream() to do the bulk of the work, which
doesn't ever call snd_hda_codec_setup_stream().

However, patch_atihdmi.c:atihdmi_dig_playback_pcm_prepare() does call
snd_hda_multi_out_dig_prepare which eventually calls
snd_hda_codec_setup_stream().

I'm not sure what the correct fix is here; shouldn't all 3 patch_*hdmi.c work
in the same way, and also call snd_hda_codec_setup_stream()?

The end-result of this is that once an audio stream has been played on the
correct converter, any subsequent streams played on any converter will also
be sent out the original converter. This is somewhat confusing!

Thanks for any pointers.

-- 
nvpublic
