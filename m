From: Markus Korber <korbse@gmx.at>
Subject: Audio DMA buffer layout
Date: Tue, 08 May 2007 13:47:47 +0200
Message-ID: <6zbqgvsfj0.fsf@odpc25.int.ondemand.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 6ED5A24385
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2007 13:47:49 +0200 (CEST)
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

I'm working with a custom sound chip with its own DMA hardware.  The
figure shows how the I2S DMA expects data to be prepared:

     IRQ1 +----------------+
          | page_3 (right) |\
          +----------------+ > double buffer 1
          | page_2 (left)  |/
     IRQ0 +----------------+
          | page_1 (right) |\
          +----------------+ > double buffer 0
          | page_0 (left)  |/
          +----------------+

The hardware has 2 double buffers, each containing left and right sample
regions, i.e. it alternately transmits samples from page_0 and page_1,
i.e. double buffer 0, then generates an interrupt and starts
transmitting page_2 and page_3.  After that another interrupt is
generated and the process begins again with double buffer 0.

So my question is, how to tell ALSA about this memory layout?  Is it
possible to operate in MMAP mode with SNDRV_PCM_INFO_NONINTERLEAVED?
But then, how to tell the application that it should either fill double
buffer 0 or 1?  Or should I use RW mode and copy samples manually to
another buffer?  Or something else?  SG-DMA?  page()-callback?

Best regards,
Markus Korber
