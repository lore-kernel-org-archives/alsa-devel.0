From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: [PATCH 7/8] ASoC: Add SPI support for WM8731
Date: Mon, 8 Sep 2008 21:27:13 +0100
Message-ID: <200809082127.13653.gineera@aspect135.co.uk>
References: <1220291224-11269-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<200809041148.29439.gineera@aspect135.co.uk>
	<20080908135201.GA11376@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hqYxImzCl6uNc0R"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-4.talktalk.net [62.24.128.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 83DB52435D
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 22:20:05 +0200 (CEST)
In-Reply-To: <20080908135201.GA11376@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ALSA devel <alsa-devel@alsa-project.org>
Cc: Bryan Wu <cooloney@kernel.org>, Cliff Cai <cliff.cai@analog.com>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_hqYxImzCl6uNc0R
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 08 September 2008 14:52, you wrote:
> On Thu, Sep 04, 2008 at 11:48:29AM +0100, Alan Horstmann wrote:
> > I assume that spi_transfer sends bytes in order, from the tx_buf
> > position, and it seems clear that data[0] is the high byte that should go
> > first.  As msg[2] is u16 (why?), I would have thought that the byte at
> > &msg[0] would be the low byte on LE, high byte on BE so it would only be
> > correct on BE.
>
> Your analysis makes sense to me.
>
> > Changing the code to use
>
> ...
>
> > fixes the problem here.
>
> Could you supply a patch, please?

Attached and here inline is the small change we applied to ensure the byte 
order is correct in the _spi_write function.  Note we observed the spi bus 
with a fast Digital Oscilloscope, and could readily see the bytes were 
originally reversed in our case (AT91SAM9260).  Our build is set to LE, but I 
have no idea why the write should be fine on Blackfin-LE without this change.

With just this one change we have been successful in running the codec over 
spi.  At present we do have an issue with dapm during capture -nothing is 
being turned on!  Any pointers would be appreciated.

Alan

wm8731_spi_write_byte_order.patch

--- wm8731-orig.c	2008-09-08 17:16:52.000000000 +0100
+++ wm8731.c	2008-09-08 21:03:16.000000000 +0100
@@ -688,12 +688,13 @@
 {
 	struct spi_transfer t;
 	struct spi_message m;
-	u16 msg[2];
+	u8 msg[2];

 	if (len <= 0)
 		return 0;

-	msg[0] = (data[0] << 8) + data[1];
+	msg[0] = data[0];
+	msg[1] = data[1];

 	spi_message_init(&m);
 	memset(&t, 0, (sizeof t));


--Boundary-00=_hqYxImzCl6uNc0R
Content-Type: application/octet-stream;
  name="wm8731_spi_write_byte_order.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="wm8731_spi_write_byte_order.patch"

--- wm8731-orig.c	2008-09-08 17:16:52.000000000 +0100
+++ wm8731.c	2008-09-08 21:03:16.000000000 +0100
@@ -688,12 +688,13 @@
 {
 	struct spi_transfer t;
 	struct spi_message m;
-	u16 msg[2];
+	u8 msg[2];
 
 	if (len <= 0)
 		return 0;
 
-	msg[0] = (data[0] << 8) + data[1];
+	msg[0] = data[0];
+	msg[1] = data[1];
 
 	spi_message_init(&m);
 	memset(&t, 0, (sizeof t));

--Boundary-00=_hqYxImzCl6uNc0R
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_hqYxImzCl6uNc0R--
