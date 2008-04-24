From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: MIDI on ice1724 - long delays
Date: Thu, 24 Apr 2008 22:47:54 +0200
Message-ID: <4810F1FA.4020300@insite.cz>
References: <480E495B.20607@insite.cz>
	<s5h63u8evih.wl%tiwai@suse.de>	<480F189A.7030500@insite.cz>
	<480F99B8.3010408@insite.cz> <s5hod7zb4j7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060000020404060605040301"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id E46F824618
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Apr 2008 22:48:00 +0200 (CEST)
In-Reply-To: <s5hod7zb4j7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060000020404060605040301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Wed, 23 Apr 2008 22:19:04 +0200, Pavel Hofman wrote:
>> Pavel Hofman wrote:
>>> Takashi Iwai wrote:
>>>> At Tue, 22 Apr 2008 22:23:55 +0200, Pavel Hofman wrote:
>>>>> Hi,
>>>>> 
>>> ...........
>>>>> After the playback stops, the interrupts are gone too. It
>>>>> seems as if the playback interrupt initiates the MPU TX
>>>>> interrupt.
>>>>> 
>>>>> If we could avoid generating the MPU TX interrupt during
>>>>> regular playback, I believe the major problem would be
>>>>> resolved.
>>>>> 
>>>>> Even if I mask the interrupts (CCS01) and do not explicitly
>>>>> unmask them (according to proc ice1724 the CCS01 register
>>>>> stays at 0xa0), the interrupt gets generated.
>>>> OK, then the simplest way would be to just ignore the TX bit at
>>>> the second or later check.
>>>> 
>>>> How about the patch below?
>>> Takashi, thanks for the hack idea. The overhead is just one more
>>> loop which is nothing. I will test it and post details of further
>>> problems (there is a bunch of them :) )
>>> 
>> Hi,
>> 
>> The hack works fine, I am finally getting no CPU burning during
>> playback and  MIDI input/output.
> 
> Thanks for checking.  The fixed patches are on HG tree now. Please
> sync your tree.

Takashi, the patch you put into HG was not the one I sent you, but sort
of the original one that I said did not work.

pavel@nahore:~$ amidi -p hw:0 -d
ALSA lib rawmidi_hw.c:233:(snd_rawmidi_hw_open) open /dev/snd/midiC0D0
failed: Input/output error
cannot open port "hw:0": Input/output error

  amidi -p hw:0 -S
F0411042110C000000000074FF0411042110C000000000074F7F0411042110C000000000\
074F7F0411042110C0F0411042110C000000000074FF0411042110C000000000074F7F041\
1042110C000000000074F7F0411042110C0
ALSA lib rawmidi_hw.c:233:(snd_rawmidi_hw_open) open /dev/snd/midiC0D0
failed: Input/output error
cannot open port "hw:0": Input/output error

I do not know the reason for MPU401_INFO_NO_ACK. You removed it from the
original patch, but without it I always get the input/output error.


>> ................

> So, now it's a problem of MIDI "input", if I understand correctly? 
> What we need to check at first is whether the MPU_RX irq is issued at
>  the correct timing.  If not, check whether MPU watermarks 
> (MPU_FIFO_WM, CCS0E).  According to the datasheet, the values are 0 
> for both RX and TX.

MPU_RX irq did not get fired at all, even though the IRQ mask register 
CCS01 was 0x00, i.e. all interrupts enabled. I enabled the watermarks 
and that did the trick :) MPU_RX gets fired now, the delays are gone and 
Qsynth plays find with MIDI from USB or ice1724 input. It still feels as 
if midi from ice1724 has a little bit higher latency but I do not think 
we can do anything about it (plus it may just be my subjective feeling).

I am enclosing a patch to current HG which does not produce errors and 
puts HG to the functionality I have now. MIDI input works correctly. 
MIDI output is not physically tested, I only checked that 
snd_vt1724_mpu401_write gets called with reasonable data.

Thanks,

Pavel.




--------------060000020404060605040301
Content-Type: text/x-patch;
 name="mpu401-v3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpu401-v3.diff"

diff -r cde01a191e6e drivers/mpu401/mpu401_uart.c
--- a/drivers/mpu401/mpu401_uart.c	Thu Apr 24 15:11:29 2008 +0200
+++ b/drivers/mpu401/mpu401_uart.c	Thu Apr 24 22:17:01 2008 +0200
@@ -243,7 +243,7 @@ static int snd_mpu401_uart_cmd(struct sn
 #endif
 	}
 	mpu->write(mpu, cmd, MPU401C(mpu));
-	if (ack) {
+	if (ack && !(mpu->info_flags & MPU401_INFO_NO_ACK)) {
 		ok = 0;
 		timeout = 10000;
 		while (!ok && timeout-- > 0) {
diff -r cde01a191e6e include/mpu401.h
--- a/include/mpu401.h	Thu Apr 24 15:11:29 2008 +0200
+++ b/include/mpu401.h	Thu Apr 24 22:17:01 2008 +0200
@@ -50,6 +50,7 @@
 #define MPU401_INFO_INTEGRATED	(1 << 2)	/* integrated h/w port */
 #define MPU401_INFO_MMIO	(1 << 3)	/* MMIO access */
 #define MPU401_INFO_TX_IRQ	(1 << 4)	/* independent TX irq */
+#define MPU401_INFO_NO_ACK	(1 << 6)	/* No ACK cmd needed */
 
 #define MPU401_MODE_BIT_INPUT		0
 #define MPU401_MODE_BIT_OUTPUT		1
diff -r cde01a191e6e pci/ice1712/ice1724.c
--- a/pci/ice1712/ice1724.c	Thu Apr 24 15:11:29 2008 +0200
+++ b/pci/ice1712/ice1724.c	Thu Apr 24 22:17:01 2008 +0200
@@ -2429,7 +2429,10 @@ static int __devinit snd_vt1724_probe(st
 			if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_ICE1712,
 						       ICEREG1724(ice, MPU_CTRL),
 						       (MPU401_INFO_INTEGRATED |
-							MPU401_INFO_TX_IRQ),
+							MPU401_INFO_NO_ACK |
+							MPU401_INFO_TX_IRQ |
+							MPU401_INFO_INPUT |
+							MPU401_INFO_OUTPUT),
 						       ice->irq, 0,
 						       &ice->rmidi[0])) < 0) {
 				snd_card_free(card);
@@ -2442,12 +2445,10 @@ static int __devinit snd_vt1724_probe(st
 			outb(inb(ICEREG1724(ice, IRQMASK)) &
 			     ~(VT1724_IRQ_MPU_RX | VT1724_IRQ_MPU_TX),
 			     ICEREG1724(ice, IRQMASK));
-#if 0 /* for testing */
 			/* set watermarks */
 			outb(VT1724_MPU_RX_FIFO | 0x1,
 			     ICEREG1724(ice, MPU_FIFO_WM));
 			outb(0x1, ICEREG1724(ice, MPU_FIFO_WM));
-#endif
 		}
 	}
 

--------------060000020404060605040301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060000020404060605040301--
