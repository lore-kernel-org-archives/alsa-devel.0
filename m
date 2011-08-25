From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: How to handle special SPI read/write for ASoC codec
	driver?
Date: Thu, 25 Aug 2011 16:39:18 +0530
Message-ID: <1314270558.16158.89.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	by alsa0.perex.cz (Postfix) with ESMTP id 40F33243D1
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 12:57:46 +0200 (CEST)
Received: from mail37-am1 (localhost.localdomain [127.0.0.1])	by
	mail37-am1-R.bigfish.com (Postfix) with ESMTP id 5622C5304B4	for
	<alsa-devel@alsa-project.org>; Thu, 25 Aug 2011 10:57:43 +0000 (UTC)
Received: from AM1EHSMHS006.bigfish.com (unknown [10.3.201.242])	by
	mail37-am1.bigfish.com (Postfix) with ESMTP id 5CC7D1BB00C5	for
	<alsa-devel@alsa-project.org>; Thu, 25 Aug 2011 10:56:16 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,
   I am working on updating ASoC codec driver for Dialog's DA7210 codec
(sound/soc/codec/da7210.c). I am planning to add SPI support and have a
query.

DA7210 codec has total 136, 8 bit registers (0x88). It supports 8 bit
address and 8 bit data format for SPI. One out of eight address bits is
used to indicate read/write operation, so effectively there are only
seven bits to represent address. So, directly we can only address 128 (0
to 127) registers.

In order to make other upper registers (128 to 136) addressable, DA7210
provides a special PAGE1 register addressed at (0x00 / 0x80). This PAGE1
register basically acts as an offset to normal registers addresses. If
PAGE1 register's value is "0x0" then, register address "0" actually maps
to 0th register. But if page register's value is "0x80", then register
address "0" actually maps to 128th register, register "2" maps to 129th
reg, and so on.

While adding support for SPI, I need to add this logic of setting
correct page while reading and writing. AFAIK, the proper place to add
this extra logic is read/write functions on codec. i.e. something
similar to, 

@@ -208,6 +208,38 @@ static int da7210_write(struct snd_soc_codec *codec, u32 reg, u32 value)
 
 	BUG_ON(codec->driver->volatile_register);
 
+#if defined(CONFIG_SPI_MASTER)
+	/*
+	 * spi_page member of private data stores current status of page
+	 * register. 0 => page 0 selected, 1 => page 1 selected
+	 */
+	struct da7210_priv *da7210 = snd_soc_codec_get_drvdata(codec);
+	if(reg >= 0x80){
+		/* We are writing register in page 1 */
+		if(!da7210->spi_page){
+			/* Need to set page register first */
+			data[0] = 0x00;
+			data[1] = 0x80;		/* need to set seventh bit */
+			if (2 != codec->hw_write(codec->control_data, data, 2))
+				return -EIO;
+			cache[0] = 0x80;	/* Update cache */
+			da7210->spi_page = 1;	/* Update local status */
+		}
+			
+	}else {
+		/* We are writing register in page 0 */
+		if(da7210->spi_page){
+			/* Need to reset page register first */
+			data[0] = 0x80;
+			data[1] = 0x00;		/* need to reset seventh bit */
+			if (2 != codec->hw_write(codec->control_data, data, 2))
+				return -EIO;
+			cache[0x80] = 0x00;	/* Update cache */
+			da7210->spi_page = 0;	/* Update local status */
+		}
+	}
+#endif
+
 	data[0] = reg & 0xff;
 	data[1] = value & 0xff;
 
Any comments on this code?

Is there any better place to put this extra logic? Any way to accommodate this in to generic soc-io functions?


Thanks,

-- Ashish
