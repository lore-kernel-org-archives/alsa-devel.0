From: Markus Korber <korbse@gmx.at>
Subject: Audio DMA buffer layout and setup
Date: Wed, 02 May 2007 10:54:01 +0200
Message-ID: <6zwszrobbq.fsf@odpc25.int.ondemand.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id F32C2243D1
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2007 10:54:03 +0200 (CEST)
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
buffer 0 or 1?  Or should I use RW mode?  Or something else?

Furthermore, since the hardware doesn't provide a 'current' DMA pointer
containing the DMA address being transmitted at the moment (I only have
interrupts generated after each double buffer has been transmitted),
what should the pcm_pointer() callback return?  

(I guess it should return 0 when called before IRQ0 and sizeof(double
 buffer 0) between IRQ0 and IRQ1?)

Best regards,
Markus Korber
