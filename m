From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: [alsa-devel] PulseAudio and softvol
Date: Wed, 26 Jun 2013 12:29:31 +0530
Message-ID: <1372229971.4981.21.camel@localhost>
References: <1368611744.6590.8.camel@localhost> <519362EB.7050603@perex.cz>
	<s5hd2ssmsd2.wl%tiwai@suse.de> <5193692A.4060007@perex.cz>
	<51936B74.6080105@canonical.com> <51936FDB.2050407@perex.cz>
	<s5h1u98mn2y.wl%tiwai@suse.de> <519383D3.3000303@canonical.com>
	<51938525.4090208@perex.cz> <s5hr4h8l7fx.wl%tiwai@suse.de>
	<519389B1.6080400@perex.cz> <s5hli7gl6hf.wl%tiwai@suse.de>
	<5193A1C9.9010108@perex.cz> <s5ha9nwl1ut.wl%tiwai@suse.de>
	<5193A8D4.4090008@perex.cz> <s5h4ne4ky13.wl%tiwai@suse.de>
	<51947D45.1040003@canonical.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <51947D45.1040003@canonical.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

On Thu, 2013-05-16 at 08:31 +0200, David Henningsson wrote:
> On 05/15/2013 06:28 PM, Takashi Iwai wrote:
[...]
> > Yes, but the invocation of PCM softvol isn't guaranteed to be first
> > before the reference to the already existing user ctl element.
> > snd_mixer_open() can be called before that.
> 
> So this is a transient problem, right? As soon as the first PCM is 
> opened, the TLV would be corrected, and then stay corrected for all 
> times to come.
> 
> And looking at the current PulseAudio code, it does open the pcm device 
> before it opens the mixer/ctl device.
> So, if this isn't possible to solve in a better way, maybe we need to be 
> pragmatic about it - PulseAudio is the only application we know that 
> would care, and it opens the pcm device first. So in practice, it looks 
> like the TLV approach would work.
> 
[...]
> > The very reason we'd like to filter out the mixer control created by
> > softvol is that this mixer element confuses PA as if it actually
> > changes the volume (e.g. "PCM") although PA ignores the softvol.  If

Actually, we don't currently ignore softvol. I guess we could add the
no-softvol flag once we're able to make sure we don't have any softvol
controls.

> > user creates PCM volume in alsaloop in a different fashion as PA
> > expected, the similar problem may happen.  How can we detect this
> > logically...?  In other words, how can PA adjust the mixer elements
> > for alsaloop properly?
> 
> So if alsaloop is run, only once, that could cause a control to be added 
> for all future, due to alsactl saving and restoring it?
> 
> If so, that looks like a problem with alsaloop. If it adds controls, it 
> should also remove them.
> 
> If no, I don't think we need to worry. Alsaloop is probably mostly used 
> on non-PA systems (as PA has module-loopback which does the same thing).

Seems this thread died out. I didn't quite understand the
alsaloop/alsactl-specific concerns, tbh. What do we need to do to take
this forwards?

Cheers,
Arun
