From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - delay resume haswell hdmi
 codec in system resume
Date: Wed, 27 Mar 2013 10:01:43 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8365EC0@SHSMSX101.ccr.corp.intel.com>
References: <1364321572-2634-1-git-send-email-mengdong.lin@intel.com>
 <51517F53.7070608@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F8363D66@SHSMSX101.ccr.corp.intel.com>
 <5152AB91.4050501@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C39D26506D
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 11:01:48 +0100 (CET)
In-Reply-To: <5152AB91.4050501@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Wednesday, March 27, 2013 4:19 PM

> > The Haswell codec set_power_state ops (intel_haswell_set_power_state) will
> only wait if this is a delayed resume and clear this flag after waiting. And
> actually, there is no waiting even in this case. Because when 1st user operation
> after system resume happens, Gfx already finishes resuming and audio
> initialization, so as long as intel_haswell_wait_ready_to_resume() enable the
> unsol event, the unsol event comes and so so waiting finishes. The 300ms time
> out is set for safety consideration in case unsol event is lost. I've not observed
> any unsol event lost till now.
> 
> As for the timeout, I suggest you use the codec->bus->workq instead of
> creating a new workq. I think that will also give us some serialisation, i e,
> protection against race conditions if the timeout happen at the same time as
> the unsol event.

Hi David,

The new added "resume_wq" for hdmi codec is a wait queue, not a work queue like codec->bus->workq.
It's expected to wake up as soon as the unsol event is got.

And I think there will not be race between unsol event and idle time out. 
Because until the first user operation trigger the delayed resume, the codec keeps in D3.
And only until intel_haswell_set_power_state(), which is called by hda_call_codec_resume(), finishes waiting and programing the codec to D0,
__snd_hda_power_up() will keep 'codec->power_transition' to '1'. Thus __snd_hda_power_down() will not schedule idle time out.


> > BTW, would you please tell us how Ubuntu decides whether to enable the
> normal idle power down (parameter "power_save")?
> > We found this bug on a Haswell mobile machine with "power_save" disabled,
> which means only system resume will program the codec back to D0. But on a
> another machine with "power_save" enabled, this bug is not visible because
> later runtime codec power up can program the codec to D0 and unmute the pin
> again.
> 
> Hmm. I don't think there is any difference between the upstream default and
> Ubuntu in this case. I remember we had to turn off power_save for
> Pantherpoint once, before keep_power_link_on for PantherPoint was
> discovered and upstreamed. But that was quite a while ago.
> 
> Then there is of course people playing with powertop and other tools, to
> override the defaults.

The default power_value is 0 in Kconfig, which means off.
But on some HSW machines with ALC889 codec and Haswell display codec, both with EPSS support, I found that power_save is 1 after boot.
On another HSW machine with ALC262, no EPSS, power_save is 0.

So I suspect the rule is that if all codecs support EPSS, power_save will be enabled. But who enables this?

Thanks
Mengdong
