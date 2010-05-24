From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB midi support for KAOSS pad
Date: Tue, 25 May 2010 00:54:12 +0200
Message-ID: <20100524225412.GR30801@buzzloop.caiaq.de>
References: <AANLkTimUYbWSqsahW9m8AbIjZuT-yVvnkGpnfCrLyi8u@mail.gmail.com>
	<20100524153324.GL30801@buzzloop.caiaq.de>
	<AANLkTil4vczJ2ymOEAUCRQBfZroxxtRpWpC6Wl3TgcUq@mail.gmail.com>
	<20100524205319.GP30801@buzzloop.caiaq.de>
	<AANLkTik4fUbdlrhDZWEVxckWgpiSDPvo2snpU-5cHWBd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 649D310385C
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 00:54:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTik4fUbdlrhDZWEVxckWgpiSDPvo2snpU-5cHWBd@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pedro Ferreira <ilzogoiby@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 25, 2010 at 12:34:03AM +0200, Pedro Ferreira wrote:
> > And here, the device is disconnected from USB, but I doubt that is
> > related to the driver stack. The only thing I can currently think of is
> > that the device draws too much power at this point, and a voltage
> > brown-out causes the device to reset. Can you try a powered hub, or is
> > this device powered by an external supply anyway?
> 
> It's got its own power supply :)
> 
> > Did you successfully
> > use it on the _same_ hardware under Windows?
> 
> Haven't tried... I don't have windows on this machine :/

Could you try to temporarily disable the snd-usb-audio driver (move the
module away or build a kernel without support for it) and then see
whether the mass storage function works stable? And then the other way
around - disable USB mass storage and try the audio function only.

Maybe that can give some hint.

Daniel
