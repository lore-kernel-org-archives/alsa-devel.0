From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Tue, 15 Apr 2008 13:32:38 +0100
Message-ID: <20080415123238.GA2732@localhost>
References: <20080411204610.GA32413@tango.0pointer.de>
	<20080414172839.GA26513@tango.0pointer.de>
	<4803C78A.3020109@superbug.co.uk>
	<200804150552.13578.faber@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 031E224702
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 14:23:12 +0200 (CEST)
Received: from localhost (78-32-150-178.no-dns-yet.enta.net [78.32.150.178])
	by mail3.uklinux.net (Postfix) with ESMTP id 0EB671F669A
	for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2008 13:23:11 +0100 (BST)
Received: from anon by localhost with local (Exim 4.63)
	(envelope-from <john@sound-man.co.uk>) id 1JlkL0-0000iP-4A
	for alsa-devel@alsa-project.org; Tue, 15 Apr 2008 13:32:38 +0100
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

On Tue, Apr 15, 2008 at 05:52:13AM +0200, Florian Faber wrote:
> On Monday 14 April 2008 23:07:22 James Courtier-Dutton wrote:
> > The aim of the dB values in the ALSA mixer is this.
> >
> > For Playback:
> > Set all the mixer controls to 0dB.
> > Send a sample digital signal from the CPU to the sound card.
> > The measured analog signal on the line-out should be the same for ALL
> > sound cards.
> 
> Consumer levels are -10dBV while pro audio levels are +4dBu. And you 
> have to be more specific what to measure.

Exactly.

> How about this: You do what you want with the consumer boards, and leave 
> the pro guys alone. Pro drivers are not 'broken' if they don't 
> implement such a 'feature', they are pro drivers.

vote++

John
