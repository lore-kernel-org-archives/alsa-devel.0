From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Tue, 15 Apr 2008 14:12:03 +0100
Message-ID: <20080415131203.GA2818@localhost>
References: <20080411204610.GA32413@tango.0pointer.de>
	<20080414172839.GA26513@tango.0pointer.de>
	<4803C78A.3020109@superbug.co.uk>
	<200804150552.13578.faber@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 5273E10381A
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 15:02:36 +0200 (CEST)
Received: from localhost (78-32-150-178.no-dns-yet.enta.net [78.32.150.178])
	by mail3.uklinux.net (Postfix) with ESMTP id 460611F669A
	for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2008 14:02:36 +0100 (BST)
Received: from anon by localhost with local (Exim 4.63)
	(envelope-from <john@sound-man.co.uk>) id 1Jlkx9-0000jt-38
	for alsa-devel@alsa-project.org; Tue, 15 Apr 2008 14:12:03 +0100
Content-Disposition: inline
In-Reply-To: <200804150552.13578.faber@faberman.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> On Monday 14 April 2008 23:07:22 James Courtier-Dutton wrote:
> > The aim of the dB values in the ALSA mixer is this.
> >
> > For Playback:
> > Set all the mixer controls to 0dB.
> > Send a sample digital signal from the CPU to the sound card.
> > The measured analog signal on the line-out should be the same for ALL
> > sound cards.

The dB setting in a mixer refers to gain, not level.
Expecting the same absolute level from pro and consumer
sound cards at the same gain setting is a little ridiculous.
If I set a control at 0dB I want just that: 0dB gain.

John
