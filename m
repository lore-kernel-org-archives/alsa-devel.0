From: Jie Jiang <jjinfo@nudt.edu.cn>
Subject: Questions about alsa driver for i.Mx27 + wm8974:
 playback time shorter than the original record time
Date: Thu, 26 Aug 2010 20:05:38 +0800
Message-ID: <1282824338.1106.44.camel@UT43>
Reply-To: jjinfo@nudt.edu.cn
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nudt.edu.cn (mail.nudt.edu.cn [61.187.54.11])
	by alsa0.perex.cz (Postfix) with SMTP id 254A924965
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 14:09:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I have been working on developing alsa driver for wm8974 codec on i.mx27
platform. The wm8974 codec is connected to i.mx27 via SSI1 port. And the
OS kernel is linux-2.6.19.2.By now, the driver modules can be
successfully built and installed/loaded into kernel. 

I tested the driver playback function with a wav file (8KHz, 16-bit,
mono) recorded by Audacity on my laptop.The playback of this wave file
on my laptop lasts about 51 seconds. But when I play it (via aplay) on
the mx27 platform, the playback time lasts about 34 seconds, and the
playback speed is quite faster than the normal speed and the speaker
output sounds like being compressed.

In my driver, wm8974 works in I2S master mode and mx27 ssi1 is
configured as I2S slave. 

The configuration of wm9874 audio interface register is 0x10, which set
wm8974 as I2S master, word length is 16bits, normal bclk and frame clock
polarity.

The configuration of mx27 ssi1 transmission channel is as follows(using
ssi api from kernel 2.6.19.2):

ssi_tx_shift_direction(ssi, 0);	// MSB first shift   
ssi_tx_clock_polarity(ssi, 0);	// clock on RISING edge   
ssi_tx_frame_sync_active(ssi, 1);// frame sync LOW active   
ssi_tx_early_frame_sync(ssi, 1);//init frame sync one bit before data
ssi_tx_frame_sync_length(ssi, 0);  //one word length frame
ssi_tx_bit0(ssi, 1); // shifting w.r.t. bit 0 of TXSR   
ssi_tx_word_length(ssi, 0x7);  //16bit WL 
ssi_tx_frame_rate(ssi, 2); // DC[4:0] non-zero
ssi_tx_clock_direction(ssi, 0); // external bit clock    
ssi_tx_frame_direction(ssi, 0); // external frame sync   
ssi_tx_clock_divide_by_two(ssi, 0);
ssi_tx_clock_prescaler(ssi, 0);
ssi_tx_fifo_empty_watermark(ssi, 0, TX_WATERMARK);//TX_WATERMARK=4
ssi_tx_fifo_enable(ssi, 0, 1); // tx fifo0 enable   
ssi_transmit_enable(ssi, 1); // transmit section enable   
ssi_interrupt_enable(ssi, ssi_tx_dma_interrupt_enable); // enable tx dma
ssi_interrupt_enable(ssi, ssi_tx_fifo_0_empty);
ssi_interrupt_enable(ssi, ssi_tx_fifo_1_empty);
ssi_i2s_mode(ssi, 2); //i2s slave

Here I'm not very sure about the setting of frame rate and frame sync
length.  Is the above setting right?  But even I set frame rate to 1, it
does not make any difference. 

What's the possible reason causing the incorrect faster playback speed?
Any suggestion is appreciated.

Regards,
Jie Jiang
