From: "Rene Dohmen" <acidjunk@gmail.com>
Subject: Re: HDA: no sound in headphone-out caused by commit
	f889fa91ad47e (2.6.25-rc1 regression)
Date: Fri, 22 Feb 2008 13:09:12 +0100
Message-ID: <165af2360802220409i3aa72e25j185738bb71dfdd3b@mail.gmail.com>
References: <9VNV5-2gs-7@gated-at.bofh.it> <9WoBm-3kd-19@gated-at.bofh.it>
	<9Wpxf-4RC-7@gated-at.bofh.it> <9Wrpz-7TF-37@gated-at.bofh.it>
	<9WrIU-8jq-7@gated-at.bofh.it>
	<315ef407-080c-4d84-9e04-fa3de970fc3c@n77g2000hse.googlegroups.com>
	<s5hve4hpivn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id B7492245CB
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 13:09:13 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so287267fgb.44
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 04:09:13 -0800 (PST)
In-Reply-To: <s5hve4hpivn.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thnx for you quick reply

De sound of the line out is working but quality is poor and the volume is
very low.

I didn't have it working with other versions of ALSA.  Tested with 1.0.14,
then started reading, lots of suggestions stated that the problem would be
solved in 1.0.15, so i compiled 1.0.16.

De device i 'm using is supplied by tangent (
http://www.tangent.com/t_all_in_one_LCDPC/vita_8000s.htm) its an all in one
solution with touchscreen and speakers integrated in one small cabinet.

alsa-info.sh script output uploaded: http://pastebin.ca/913865

I wasn't aware of the fact that I communicated directly: I found the
discussion in google groups: and just hitted reply :-)
So sorry for that. I now subscribed myself to the ML

Regards,
Rene




On Fri, Feb 22, 2008 at 8:09 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 21 Feb 2008 18:56:30 -0800 (PST),
> acidjunk@gmail.com wrote:
> >
> > Hi,
> > I have exactly the same problem with my sound device:
> >  hda_codec: Unknown model for ALC262:  trying auto-probe
> > lspci output: 00:1b.0 Audio device: Intel Corporation 82801G (ICH7
> > Family) High Definition Audio Controller (rev 01) from BIOS.
> >
> > I'm using alsa 1.0.16 compiled form source under ubuntu gutsy. I tried
> > hardy but is has the same results
> >
> > The headphone output is working (not very loud, but usable), but the
> > front speakers are not working. Did the patches solve the speaker
> > issue? and how do I apply them (I am new to the patching technique).
>
> Please don't mix up.  It is a totally different problem since your
> machine has another codec (and even 1.0.16 doesn't work).  The patch
> cannot solve your problem.  Save your time.
>
> Has any version of ALSA driver ever worked properly?  If yes, we can
> check the difference.
>
> If not, we need to track down the problem more deeply.  First of all,
> give more detailed hardware information: what is your laptop (or
> desktop) vendor, model, etc.  Try different model options.  And the
> output of alsa-info.sh -- it's vital information.
>
> Last but not least, don't forget to add alsa-devel ML to Cc in your
> next reply.  This isn't a kind of thing to be communicated privately
> at all.
>
>
> thanks,
>
> Takashi
>
