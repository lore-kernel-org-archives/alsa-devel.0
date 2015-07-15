From: Istvan Sandor <stevie_30@hotmail.com>
Subject: Re: Intel SST on a Bay Trail tablet
Date: Wed, 15 Jul 2015 10:11:43 +0000 (UTC)
Message-ID: <loom.20150715T121020-315@post.gmane.org>
References: <54F5CB3D.7020100@linux.intel.com>
 <20150304170218.7b397993ce670902800109f1@ao2.it>
 <20150403153414.b8de8df914664d7d7967120c@ao2.it>
 <20150414150236.3e8288307124a43941ab94f7@ao2.it>
 <552D1EE3.6090707@linux.intel.com> <20150624101613.GK19530@localhost>
 <20150625055046.GT19530@localhost>
 <20150625122125.72a1d72b4d3aa886d68fa3eb@ao2.it>
 <20150625164717.GU19530@localhost>
 <20150626150528.f9fdee3942f7e975d23dd701@ao2.it>
 <20150627144745.GX19530@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id BD26C265A28
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 12:15:07 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1ZFJiS-0003gc-7M
 for alsa-devel@alsa-project.org; Wed, 15 Jul 2015 12:15:04 +0200
Received: from ipb21a65bb.dynamic.kabel-deutschland.de ([178.26.101.187])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 12:15:04 +0200
Received: from stevie_30 by ipb21a65bb.dynamic.kabel-deutschland.de with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 12:15:04 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Vinod Koul <vinod.koul <at> intel.com> writes:

> > The sound is a bit distorted tho, I can alleviate this effect by
> > lowering the values of these controls:
> >   - codec_out0 Gain0
> >   - media1_in Gain0
> >   - pcm0_in Gain0
> > 
> > but the distortions do not go completely away, and they are not present
> > in Android even at the highest volume.
> I dont think the gain is causing the distortion. It can be SSP settings
> DO you see distortion in one channel or both (try with headset)

Hi Vinod,

I've been following this thread since a while and trying out the various things
suggested. I have an Acer Aspire Switch 10 which seems to have the same audio
chip like the Teclast and the other tablets mentioned in the bugzilla thread. I
also had to change the interrupt index and tried the other driver with the
fw_sst_0f28.bin-48kHz_i2s_master firmware, got overheating etc. etc. Finally
following the advice in this thread I got to the same point, mfld driver with
ssp0 firmware and applying the alsa settings as in

http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/094080.html

I get the distorted sound. I've been playing around with the mixer controls and
wanted to report back my findings, maybe it can help. What I've found:

1) Sound seems only to be coming from the right speaker. If I turn off
"Speaker R"
   there's no sound. Turning off "Speaker L" doesn't seem to do anything. If I
   turn off both playback stalls. Generally If I turn off any of the setting
   suggested in your mail playback stalls (mplayer).

2) By turning on "HPO MIX DAC1" "HPO MIX DAC2" "HP L" and "HP R" I get sound
   from the headset. Here also the sound is distorted and is only coming
from the
   right channel.

3) Volume controls "Headphone" "Speaker" have no effect (I can't turn off
the volume).

My kernel is: 4.1.0

Modules:

	$ lsmod | grep snd

	snd_soc_sst_bytcr_rt5640    16384  0 
	snd_soc_rt5640         86016  1 
	snd_soc_rl6231         16384  1 snd_soc_rt5640
	regmap_i2c             16384  1 snd_soc_rt5640
	snd_intel_sst_acpi     16384  1 
	snd_intel_sst_core     69632  1 snd_intel_sst_acpi
	snd_soc_sst_mfld_platform    69632  3 snd_intel_sst_core
	snd_soc_core          155648  4
snd_soc_rt5640,snd_soc_sst_mfld_platform,snd_soc_sst_bytcr_rt5640
	snd_compress           20480  1 snd_soc_core
	snd_pcm               106496  4
snd_soc_rt5640,snd_soc_core,snd_soc_sst_mfld_platform,snd_soc_sst_bytcr_rt5640
	snd_timer              28672  1 snd_pcm
	snd                    69632  7
snd_soc_core,snd_timer,snd_pcm,snd_soc_sst_mfld_platform,snd_compress
	soundcore              16384  1 snd

alsa.state is "baytrailcraudio" with the setting suggested in your mail.

I hope this info will be helpful!

regards
Istvan
