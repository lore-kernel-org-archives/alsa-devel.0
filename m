From: gianluca a <gianagl@outlook.com>
Subject: Question: alsa-lib snd_pcm_htimestamp inner working
	and precision
Date: Tue, 12 Sep 2017 12:00:23 +0000
Message-ID: <AM4PR0301MB19549D13427B387747556E0AAC690@AM4PR0301MB1954.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-oln040092066041.outbound.protection.outlook.com [40.92.66.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 48A96266D07
 for <alsa-devel@alsa-project.org>; Tue, 12 Sep 2017 14:00:24 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi all,

I am trying to understand the precision of htimestamp for sample captured and I am not sure if I understood well, because I have found old informations togheter with new informations and I've the doubt that something changed. I am interested in this because of a project for my degree thesis.

snd_pcm_hw_params_supports_audio_wallclock_ts returns 0 on capture, so my hardware doesn't support wallclock timestamps on capture.

I've understood that SND_PCM_TSTAMP_ENABLE is equivalent to SND_PCM_TSTAMP_MMAP, so it updates timestamp at every position update on DMA from the driver. I've read elsewhere that this timestamp is updated every period-size ( equal interrupt), is it correct?

I've digged in the code to understand well inner working of htimestamp, but I've found that snd_pcm_htimestamp in pcm.c calls:

err = pcm->fast_ops->htimestamp(pcm->fast_op_arg, avail, tstamp);

And I have not found where fast_ops is initialized, maybe in the driver? Anyway I thougth that maybe in my case the called function is snd_pcm_hw_htimestamp in pcm_hw.c :

"while (1) {
		avail1 = snd_pcm_hw_avail_update(pcm);
		if (avail1 < 0)
			return avail1;
		if (ok && (snd_pcm_uframes_t)avail1 == *avail)
			break;
		*avail = avail1;
		*tstamp = snd_pcm_hw_fast_tstamp(pcm);
		ok = 1;
	}"

that calls snd_pcm_hw_fast_tstamp, that calls finally:

"#define FAST_PCM_TSTAMP(hw) \
	((hw)->mmap_status->tstamp)
"
And finally is this the timestamp that is updated every period-size? Am I correct that in the case that hardware doesn't support wallclock timestamp is snd_pcm_hw_htimestamp in pcm_hw.c the called function?

Thanks in advance
