From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH v2] ALSA: hda - verify pin:cvt connection
 on preparing a stream for Intel HDMI codec
Date: Fri, 28 Mar 2014 09:24:53 +0100
Message-ID: <533531D5.3000504@canonical.com>
References: <c8336299f64f1fda9e0d0488fbef5e90a67e287b.1395135128.git.mengdong.lin@intel.com>
 <ae7e1c58c756e7149bc8b93f648bc56fd7af73d1.1395291484.git.mengdong.lin@intel.com>
 <s5hzjklbckf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D9A026549F
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 09:24:54 +0100 (CET)
In-Reply-To: <s5hzjklbckf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, mengdong.lin@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/20/2014 07:37 AM, Takashi Iwai wrote:
> At Thu, 20 Mar 2014 13:01:06 +0800,
> mengdong.lin@intel.com wrote:
>>
>> From: Mengdong Lin <mengdong.lin@intel.com>
>>
>> This is a temporary fix for some Intel HDMI codecs to avoid no sound output for
>> a resuming playback after S3.
>>
>> After S3, the audio driver restores pin:cvt connection selections by
>> snd_hda_codec_resume_cache(). However this can happen before the gfx side is
>> ready and such connect selection is overlooked by HW. After gfx is ready, the
>> pins make the default selection again. And this will cause multiple pins share
>> a same convertor and mute control will affect each other. Thus a resumed audio
>> playback become silent after S3.
>>
>> This patch verifies pin:cvt connection on preparing a stream, to assure the pin
>> selects the right convetor and an assigned convertor is not shared by other
>> unused pins. Apply this fix-up on Haswell, Broadwell and Valleyview (Baytrail).
>>
>> We need this temporary fix before a reliable software communication channel is
>> established between audio and gfx, to sync audio/gfx operations.
>>
>> Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
> 
> Thanks, applied.

Hi,

Any reason this commit isn't sent to stable? Looks like a candidate.

> 
> 
> Takashi
> 
>>
>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>> index 3ab7063..585c271 100644
>> --- a/sound/pci/hda/patch_hdmi.c
>> +++ b/sound/pci/hda/patch_hdmi.c
>> @@ -68,6 +68,7 @@ struct hdmi_spec_per_pin {
>>  	hda_nid_t pin_nid;
>>  	int num_mux_nids;
>>  	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
>> +	int mux_idx;
>>  	hda_nid_t cvt_nid;
>>  
>>  	struct hda_codec *codec;
>> @@ -1342,6 +1343,8 @@ static int hdmi_choose_cvt(struct hda_codec *codec,
>>  	if (cvt_idx == spec->num_cvts)
>>  		return -ENODEV;
>>  
>> +	per_pin->mux_idx = mux_idx;
>> +
>>  	if (cvt_id)
>>  		*cvt_id = cvt_idx;
>>  	if (mux_id)
>> @@ -1350,6 +1353,22 @@ static int hdmi_choose_cvt(struct hda_codec *codec,
>>  	return 0;
>>  }
>>  
>> +/* Assure the pin select the right convetor */
>> +static void intel_verify_pin_cvt_connect(struct hda_codec *codec,
>> +			struct hdmi_spec_per_pin *per_pin)
>> +{
>> +	hda_nid_t pin_nid = per_pin->pin_nid;
>> +	int mux_idx, curr;
>> +
>> +	mux_idx = per_pin->mux_idx;
>> +	curr = snd_hda_codec_read(codec, pin_nid, 0,
>> +					  AC_VERB_GET_CONNECT_SEL, 0);
>> +	if (curr != mux_idx)
>> +		snd_hda_codec_write_cache(codec, pin_nid, 0,
>> +					    AC_VERB_SET_CONNECT_SEL,
>> +					    mux_idx);
>> +}
>> +
>>  /* Intel HDMI workaround to fix audio routing issue:
>>   * For some Intel display codecs, pins share the same connection list.
>>   * So a conveter can be selected by multiple pins and playback on any of these
>> @@ -1751,6 +1770,19 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
>>  	bool non_pcm;
>>  	int pinctl;
>>  
>> +	if (is_haswell_plus(codec) || is_valleyview(codec)) {
>> +		/* Verify pin:cvt selections to avoid silent audio after S3.
>> +		 * After S3, the audio driver restores pin:cvt selections
>> +		 * but this can happen before gfx is ready and such selection
>> +		 * is overlooked by HW. Thus multiple pins can share a same
>> +		 * default convertor and mute control will affect each other,
>> +		 * which can cause a resumed audio playback become silent
>> +		 * after S3.
>> +		 */
>> +		intel_verify_pin_cvt_connect(codec, per_pin);
>> +		intel_not_share_assigned_cvt(codec, pin_nid, per_pin->mux_idx);
>> +	}
>> +
>>  	non_pcm = check_non_pcm_per_cvt(codec, cvt_nid);
>>  	mutex_lock(&per_pin->lock);
>>  	per_pin->channels = substream->runtime->channels;
>> -- 
>> 1.8.1.2
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
