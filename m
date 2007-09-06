From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: How to name controls
Date: Thu, 6 Sep 2007 09:42:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709060932440.31808@shell4.speakeasy.net>
References: <Pine.LNX.4.58.0709031409580.18152@shell4.speakeasy.net>
	<s5hwsv56xl5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail4.sea5.speakeasy.net (mail4.sea5.speakeasy.net
	[69.17.117.6]) by alsa0.perex.cz (Postfix) with ESMTP id 362BC10381B
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 18:42:04 +0200 (CEST)
In-Reply-To: <s5hwsv56xl5.wl%tiwai@suse.de>
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

On Wed, 5 Sep 2007, Takashi Iwai wrote:
> At Mon, 3 Sep 2007 14:46:11 -0700 (PDT),
> Trent Piepho wrote:
> > Basically, there is an analog input (from the TV tuner), and a line out.
> > The analog input goes through ADC -> DAC steps and then to the line out.
> > There are three controls, one volume and two mute switches.  One switch
> > causes the source to be muted, the other only mutes the line out.  The
> > volume only controls the line out.
> >
> > So what should I call these controls?  Do I call the volume "Playback
> > Volume"?  The chip doesn't support playback, so that seems confusing.  It's
> > more like "Pass-through Volume", but that's not an option.  And what do I
> > call the source mute switch?  "Capture Switch"?  That doesn't seem quite
> > right either, since it doesn't just mute capture, but also mutes the
> > pass-through audio.
>
> Basically "Capture" and "Playback" in the control element names just
> indicate the direction rather than the functionality.  The analog-loop
> back is handled usually "XXX Playback Volume" in many drivers/codecs.
> Hence I think it's fine with "Playback Volume" in this case.

Ok, thanks.  The direction is clear when one has audio going to or from an
ALSA pcm device, but in the case of a pass-through it's not obvious.  I see
that the ca0106 driver has a control named "CAPTURE feedback Playback
Volume" that works the same way as the cx88 volume control.  Since cx88
only has the one control, I'll just name it "Playback Volume".
