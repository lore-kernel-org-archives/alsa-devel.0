From: Tobias Hansen <Tobias.Hansen@physik.uni-hamburg.de>
Subject: Re: Status of the Tascam US-122mkII???
Date: Sat, 19 Jun 2010 21:03:55 +0200
Message-ID: <4C1D149B.7000802@physik.uni-hamburg.de>
References: <AANLkTimaehZwC-e1pmbQl-pLNb7gVp2Rt5Ujz4BfduR_@mail.gmail.com>
	<20100619174259.GJ17833@buzzloop.caiaq.de>
	<AANLkTilfDBFqGH41TGF0H855CfCm8fOjGMW7lwH1tXi_@mail.gmail.com>
	<20100619180956.GL17833@buzzloop.caiaq.de>
	<AANLkTikfeTzrOttiyI9BqqD3zHI7NXY8ScyXoY8Ruq8N@mail.gmail.com>
	<20100619185753.GN17833@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.physnet.uni-hamburg.de (MAIL.PHYSnet.uni-hamburg.de
	[134.100.106.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A558103817
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jun 2010 21:04:02 +0200 (CEST)
In-Reply-To: <20100619185753.GN17833@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, jordan johnston <triplesquarednine@gmail.com>
List-Id: alsa-devel@alsa-project.org

Daniel Mack schrieb:
>
> Sorry, I didn't check properly. The driver clearly notes the
> vendor/product ID of your device, that's why it is probed but fails.
>
> This was added in commit 2b6f6c0d11 ("ALSA: snd-usb-us122l: add product
> IDs of US-122MKII and US-144MKII"). Obviously, this patch wasn't tested
> with real hardware (this is also what the commit log says), so it's no
> surprise it doesn't work for you. I copied the author, and I'd vote for
> reverting the patch until the driver is modified to actually support
> what it claims to do.
>
>   
Yes, the driver doesn't work with the MKIIs. The patch can be reverted.

Greetings, Tobias
