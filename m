From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Vendor support in Alsa Drivers
Date: Sat, 14 Jun 2008 23:20:50 +0200
Message-ID: <20080614232050.a5395f90.pochini@shiny.it>
References: <484E4E24.1060509@libera.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out114.alice.it (smtp-out114.alice.it [85.37.17.114])
	by alsa0.perex.cz (Postfix) with ESMTP id CCE53244DD
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Jun 2008 23:23:00 +0200 (CEST)
In-Reply-To: <484E4E24.1060509@libera.cc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Emmanuel Kasper <emmanuel@libera.cc>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 10 Jun 2008 11:49:24 +0200
Emmanuel Kasper <emmanuel@libera.cc> wrote:

> Hello
> With a couple of other french folks, we are building a kind of webshop
> for Linux/FreeBSD compatible hardware. We will reference only devices
> which work with a free driver, so no nvidia binary thingie or atheros HAL.
> Based on the information found  on  the alsa wiki we plan to reference
> the following sound devices:
> 
> M-Audio Audiophile 24/96 (  snd-ice1712 driver )
> Terratec AUREON 5.1
> M-Audio Fast Track usb
> Hercules Muse Pocket LT
> Ion TTUSB usb turnable ( these 4 working with snd-usb-driver )

Add Echoaudio PCI and CARDBUS cards. They released the lowlevel part of
their driver under the LGPL and the firmware in binary only form with the
explicit permission to use it in the Linux kernel
(http://echoaudio.com/Downloads/Developer.php). They were helpful and sent
me a Gina3G when it was released. IIRC they also support the Freebob people
for the Audiofire cards.


--
Giuliano.
