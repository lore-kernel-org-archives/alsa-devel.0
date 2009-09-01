From: Adam Gray <adam@randalflagg.net>
Subject: Re: ALSA on Alienware M17x
Date: Wed, 2 Sep 2009 01:07:22 +0930
Message-ID: <200909020107.22886.adam@randalflagg.net>
References: <200908281621.20263.adam@randalflagg.net>
	<200909020055.02986.adam@randalflagg.net>
	<s5heiqqsmq4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from randalflagg.net (randalflagg.net [150.101.102.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A3BF24346
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 17:37:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by randalflagg.net (Postfix) with SMTP id 2A0CA23609A
	for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2009 01:07:23 +0930 (CST)
In-Reply-To: <s5heiqqsmq4.wl%tiwai@suse.de>
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

On Wed, 2 Sep 2009 01:04:11 am Takashi Iwai wrote:
> At Wed, 2 Sep 2009 00:55:02 +0930,
> 
> Adam Gray wrote:
> > On Wed, 2 Sep 2009 12:51:21 am Takashi Iwai wrote:
> > > At Wed, 2 Sep 2009 00:40:13 +0930,
> > >
> > > Adam Gray wrote:
> > > > Sorry. Forgot to attach it the first time.
> > > > With model=dell-m6 I only get sound out of the first headphone jack
> > > > and the line-out jack.
> > >
> > > Which I/Os does your machine have?
> > > According to alsa-info.sh output, BIOS gives three HP jacks, one mic
> > > jack, one built-in speaker, one built-in mic, and one SPDIF out jack.
> > >
> > > I guess the problem is due to three HPs.  The driver hasn't been
> > > tested with three HP jacks, only with two HPs.
> > >
> > >
> > > thanks,
> > >
> > > Takashi
> >
> > It has two headphone jacks, one line-out jack and one microphone jack,
> > the front speakers and a microphone used with the webcam (I believe).
> 
> OK.  Try to unmute and adjust "Surround" volume.
> 
> 
> Takashi

Unmuted surround and volume is up full. Nothing from the headphones. I also 
unmuted the PC beep and turned it up (just to check) and still nothing. 
