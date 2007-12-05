From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Mindprint DI-MOD USB
Date: Wed, 05 Dec 2007 12:47:44 +0100
Message-ID: <1196855264.12342.1224921547@webmail.messagingengine.com>
References: <20071205084935.GA24821@diller-5.physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 986AA24505
	for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2007 12:47:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071205084935.GA24821@diller-5.physik.uni-kl.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christian Schumann <schumann@physik.uni-kl.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Christian Schumann wrote:
> The DI-MOD USB is pretty usb-audio class compliant with the exception of
> the spdif output, which has to be activated manaually. I did this with
> the windows driver, but it would be nice to be able to do that with
> ALSA. 
> I have a Envoice MkII with the DI-MOD USB, and my suggestion would be to
> automatically enable the spdif output when initializing the driver. The
> spdif output does not have any other effect on the card functionality.

That is, it doesn't affect the analog output in any way?

> Digital: Vendorrequest, Typ: Out/Vendorinterface, bReq setCur, wVal 0x00,
> wIndex 0x04, data length 1: data 0x01
> Analog: Vendorrequest, Typ: Out/Vendorinterface, bReq setCur, wVal 0x00,
> wIndex 0x02, data length 1: data 0x00
> 
> I don't have experience in writing drivers, but if someone can give me a
> clue where to start, I could give it a try.

Have a look at the *_boot_quirk functions in usbaudio.c.


Regards,
Clemens
