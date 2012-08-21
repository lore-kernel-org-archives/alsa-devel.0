From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [RFC PATCH] ALSA: hda - add support for runtime
	power management
Date: Tue, 21 Aug 2012 06:35:06 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F819177F@SHSMSX101.ccr.corp.intel.com>
References: <1345195814-2287-1-git-send-email-mengdong.lin@intel.com>
 <s5hsjblvo9s.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F818B4E4@SHSMSX101.ccr.corp.intel.com>
 <s5hd32psbqb.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F818C27C@SHSMSX101.ccr.corp.intel.com>
 <s5hlihaq68y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id CEA45260311
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 08:35:43 +0200 (CEST)
In-Reply-To: <s5hlihaq68y.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > > - Are snd_power_change_state() calls needed for runtime PM?
> > I think this is needed. It's because HW is actually in D3 when it's runtime
> suspended and need a delay for transition back to D0. And there are
> operations that need HW in D0, such as snd_pcm_prepare().
> 
> Well, first off, PCM prepare will be never reached during runtime PM
> suspend.
> 
> Secondly, you seem to misunderstand the concept of
> snd_power_change_state().  It's for blocking the whole operations until the
> resume finished.  In the case of runtime PM, the resume itself is triggered
> by the operation.  Thus if you call
> snd_power_change_state(D3) in the runtime suspend, it'd deadlock, since
> the wake-up operation itself is blocked by that.


Hi Takashi,

You're right. snd_power_change_state() calls should be removed before runtime suspend/resume.
I've not met deadlock before just because I used aplay so PCM open triggers resume at first without waiting the sound card back to D0.

Please if ignore my patch v2 because snd_power_change_state() has not been removed.  Sorry, I missed your mail yesterday.

Thanks
Mengdong
