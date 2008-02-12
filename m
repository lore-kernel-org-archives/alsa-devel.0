From: Matej Laitl <strohel@gmail.com>
Subject: Re: [ALSA] HDA: no sound in headphone-out caused by
	commit f889fa91ad47e (2.6.25-rc1 regression)
Date: Tue, 12 Feb 2008 19:24:35 +0100
Message-ID: <200802121924.35232.strohel@gmail.com>
References: <200802112158.41989.strohel@gmail.com>
	<200802121627.44422.strohel@gmail.com>
	<s5hmyq6t7u5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by alsa0.perex.cz (Postfix) with ESMTP id DDFC8244A2
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 19:24:43 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so1356255nfd.32
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 10:24:40 -0800 (PST)
In-Reply-To: <s5hmyq6t7u5.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Matej Laitl wrote:
> > Yes, this "slightly better" patch applied on top of your first patch
> > against hda_codec.c did the trick, but with some side-effects:
> > * the "Speaker" switch now mutes/unmutes speakers
> > * muting/unmuting "Front" channel now has zero effect (in 2.6.24 it had
> > the same effect as the "Speaker" switch now has)
> > * changing volume on "Front" channel now affects volume in headphones
> > (was not so in 2.6.24)
>
> This is what your BIOS sets up.  The main output is connected to the
> docking station.  That's why "Front" (a silly name for ALC262; it
> should read "Line Out", maybe will be renamed in later versions)
> switch doesn't work.
> OTOH, all outputs (speaker, headphone and line-outs) use the same DAC,
> and this is controlled via line-out volume, i.e. "Front" volume.

I was actually wrong when saying the "Front" channel did not influence HP-out 
in 2.6.24 - it did, so no regressions here.

> > So there are now 3 vol controls that affect both speakers and headphones:
> > * Master (which appeared somewhere between 2.6.24 and .25-rc1), when set
> > to zero, the sound is still audible in speakers and headphones
>
> This must be the behavior of the codec chip...  Did "Front" volume 0
> mute in the earlier version?  If not, it actually doesn't mute with
> the lowest volume.  Use the master switch to mute.
>
> Anyway, attach the alsa-info.sh output at the moment Master volume is
> zero.

No, setting Master and/or Front channel to 0% did not mute audio in any 
version I used.

I'm now listening to music with Master=0% and Front=0%, the sound is at well 
audible volume. Pastebin for this configuraion is here:
http://pastebin.ca/901459

However I don't consider it a problem, it's mutable by PCM and HP/Speaker 
switches. Funny thing is that resulting volume of those 3 setting is equal:
* Master=0, Front=0
* Master=100%, Front=0
* Master=0, Front=100%
But when both set to let's say 50, changing one of these audibly affects 
resulting volume.

> > * PCM, working as expected (0 volume = no sound)
> > * Front (0 volume = still audible sound)
> >
> > So it is usable now (and those Speaker and Headphones on/off switches
> > make sense), but kinda suboptimal. (is it my BIOS who is to blame?)
>
> Yep.  For the perfect solution, you'd need to create a static "patch"
> for this particular model instead of auto-configuration.  Then you can
> adjust everything as you like.

Would it be easy to do this in a robust way? If not, it's not worth it.

On a side note, I experience increased noise when not playing anything during 
2.6.24 -> .25-rc1 upgrade, but this is probably completly unrelated to 
today's problem.

Anyways, thanks for your effort and patches, Takashi.

Matej Laitl
