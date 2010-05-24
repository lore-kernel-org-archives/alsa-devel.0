From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB midi support for KAOSS pad
Date: Mon, 24 May 2010 17:33:24 +0200
Message-ID: <20100524153324.GL30801@buzzloop.caiaq.de>
References: <AANLkTimUYbWSqsahW9m8AbIjZuT-yVvnkGpnfCrLyi8u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id BF7B324671
	for <alsa-devel@alsa-project.org>;
	Mon, 24 May 2010 17:33:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimUYbWSqsahW9m8AbIjZuT-yVvnkGpnfCrLyi8u@mail.gmail.com>
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

On Mon, May 24, 2010 at 05:07:22PM +0200, Pedro Ferreira wrote:
> I tried connecting my KAOSS PAD 3 to a linux laptop, and apparently
> ALSA MIDI detects the device.
> However, dmesg shows several messages, all similar to:
> 
> {{{
> [ 7088.722283] ALSA midi.c:1597: MIDIStreaming version 01.00
> [ 7088.722290] ALSA midi.c:1632: EP 02: 1 jack(s)
> [ 7088.722295] ALSA midi.c:1647: EP 82: 1 jack(s)
> [ 7088.722315] ALSA midi.c:1567: created 1 output and 1 input ports
> [ 7088.806326] usb 2-1.1: reset full speed USB device using ehci_hcd
> and address 15
> }}}
> 
> If i open qjackctl, i can see the device being added and removed successively.
> 
> Does anyone know what can be going wrong? I would be more than happy
> to contribute with usbmon logs, etc... or even try to research a bit
> if someone points me in the right direction.

Can you enable CONFIG_USB_DEBUG and post the full output that is
produced when the device is plugged in?

Thanks,
Daniel
