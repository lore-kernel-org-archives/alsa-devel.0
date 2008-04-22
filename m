From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: MIDI on ice1724 - preliminary findings and questions
Date: Tue, 22 Apr 2008 22:23:55 +0200
Message-ID: <480E495B.20607@insite.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060807080900080709090601"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id A168224622
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Apr 2008 22:24:01 +0200 (CEST)
Received: from [192.168.105.213] (ap-dustin.bobrnet.cz [10.109.8.38])
	by mailserver.bobrnet.net (8.13.8/8.13.8/Debian-3) with ESMTP id
	m3MKO0Fi003283
	for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2008 22:24:01 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060807080900080709090601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am trying to fix the ancient MIDI problem with ice1724 cards. I 
applied Takashi's patch from 
http://mailman.alsa-project.org/pipermail/alsa-devel/2007-April/000641.html 
and made some minor changes (MPU401_INFO_INPUT | MPU401_INFO_OUTPUT to 
mpu401_uart info_flags, added a few debugs for testing).

I can test only MIDI input using my MIDI keyboard, I have no MIDI output 
device available. The input works fine now, the output most probably too 
since the method snd_vt1724_mpu401_write gets called when transmitting 
some data with amidi.

But here is the problem I do not understand:

When no MIDI input/output is used, the interrupt handler 
snd_vt1724_interrupt gets called with interrupt status 0x10 which 
correctly refers to the audio data interrupt (VT1724_IRQ_MTPCM).

However, when MIDI input or output is used (opened) even for a short 
time after the module is loaded, any subsequent audio playback generates 
interrupt status of 0x30 which refers to VT1724_IRQ_MTPCM AND 
VT1724_IRQ_MPU_TX. I have no idea why VT1724_IRQ_MPU_TX gets generated.

The first run of the snd_vt1724_interrupt loop tries to handle the MPU 
TX status, calling uart_interrupt_tx in mpu401_uart.c:

	if (test_bit(MPU401_MODE_BIT_OUTPUT, &mpu->mode) &&
	    test_bit(MPU401_MODE_BIT_OUTPUT_TRIGGER, &mpu->mode)) {
		spin_lock_irqsave(&mpu->output_lock, flags);
		snd_mpu401_uart_output_write(mpu);
		spin_unlock_irqrestore(&mpu->output_lock, flags);
	}

However, since the MPU output is not open at this time (no MIDI is being 
transmitted), the call to snd_mpu401_uart_output_write is skipped. Even 
though I think the interrupt status should get cleared by

outb(status, ICEREG1724(ice, IRQSTAT))

the loop repeats with the MPU TX interrupt status enabled until the 
timeout check breaks the while loop, returning to the interrupt handler 
the next moment again.

Apr 19 22:20:47 nahore kernel: [ 2402.938245] uart interrupt: status 0x30
Apr 19 22:20:47 nahore kernel: [ 2402.938260] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.938267] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.938274] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.938281] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.938288] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.938295] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.938302] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.938309] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.938316] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.938323] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.938326] ice1724: Too long irq 
loop, status = 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.961247] uart interrupt: status 0x30
Apr 19 22:20:47 nahore kernel: [ 2402.961278] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.961285] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.961292] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.961299] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.961306] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.961313] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.961320] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.961327] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.961334] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.961341] uart interrupt: status 0x20
Apr 19 22:20:47 nahore kernel: [ 2402.961344] ice1724: Too long irq 
loop, status = 0x20

After the playback stops, the interrupts are gone too. It seems as if 
the playback interrupt initiates the MPU TX interrupt.

If we could avoid generating the MPU TX interrupt during regular 
playback, I believe the major problem would be resolved.

Even if I mask the interrupts (CCS01) and do not explicitly unmask them 
(according to proc ice1724 the CCS01 register stays at 0xa0), the 
interrupt gets generated.

I am enclosing the testing patch producing the above given results.

Thanks a lot for any suggestion or help.

Regards,

Pavel.

--------------060807080900080709090601
Content-Type: application/x-gzip;
 name="mpu401-test.diff.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="mpu401-test.diff.gz"

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
--------------060807080900080709090601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060807080900080709090601--
