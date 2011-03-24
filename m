From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: Loud pops from Intel HDA onboard sound,
 may damage speakers (fwd)
Date: Thu, 24 Mar 2011 09:43:50 +0800
Message-ID: <20110324014350.GA8029@localhost>
References: <alpine.DEB.2.00.1103240135291.1780@chris-desktop.fen.aptivate.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id D9B1924179
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 02:43:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1103240135291.1780@chris-desktop.fen.aptivate.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chris Wilson <chris@qwirx.com>
Cc: alsa-devel@alsa-project.org, matt.jared@intel.com, andy.kopp@intel.com, Takashi Iwai <tiwai@suse.de>, dan.d.kogan@intel.com, PeiSen Hou <pshou@realtek.com.tw>
List-Id: alsa-devel@alsa-project.org

Hi Chris,

Would you run http://www.alsa-project.org/alsa-info.sh and email the
results?

Thanks,
Fengguang

On Thu, Mar 24, 2011 at 01:35:54AM +0000, Chris Wilson wrote:
> ---------- Forwarded message ----------
> Date: Thu, 24 Mar 2011 00:49:55 +0000 (GMT)
> From: Chris Wilson <chris@qwirx.com>
> To: Takashi Iwai <tiwai@suse.de>, PeiSen Hou <pshou@realtek.com.tw>,
>     matt.jared@intel.com, andy.kopp@intel.com, dan.d.kogan@intel.com
> Subject: Loud pops from Intel HDA onboard sound, may damage speakers
> 
> Dear sirs,
> 
> I'm writing to you as the named contacts in hda_intel.c in the Linux
> kernel. Please let me know if I should contact someone else instead.
> 
> I refer to this downstream bug on Ubuntu Launchpad, which I am
> hereby taking upstream:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/184632
> 
> I have a desktop system (Fujitsu P9900) with the onboard sound
> connected to my hi-fi amplifier, driven by snd_hda_intel. The audio
> chipset is:
> 
>   00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset
>   High Definition Audio (rev 05)
> 
> The sound card outputs loud popping sounds whenever I suspend and
> resume it. One of them is loud or severe enough to cause my hi-fi
> amplifier to go into automatic shutdown mode, and I'm worried that
> it may damage my speakers.
> 
> If I enable power_save=1, as suggested by powertop, then this
> happens about 2 seconds after any audio finishes playing as well, so
> I suspect it's related to putting the sound card in or out of
> suspend mode.
> 
> The pops seem to be happening to others who have this chipset as
> well, as seen on the bug report, but they seem mostly to be using
> laptops or otherwise not bothered by potential damage to their
> speakers.
> 
> I would really appreciate it if you could help me to find a way to
> avoid these pops, for example by muting the audio output before
> shutting down the DAC? I think it would be great if this could make
> it into the standard kernel driver.
> 
> Many thanks in advance,
> 
> Chris Wilson.
> -- 
> _____ __     _
> \  __/ / ,__(_)_  | Chris Wilson <chris+sig@qwirx.com> Cambs UK |
> / (_/ ,\/ _/ /_ \ | Security/C/C++/Java/Ruby/Perl/SQL Developer |
> \__/_/_/_//_/___/ | We are GNU : free your mind & your software |
