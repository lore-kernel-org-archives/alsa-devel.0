From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: IRQ trouble...
Date: Sat, 25 Jan 2003 20:41:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E32E87C.9000505@student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi all,

I' writing a device driver for the Maxi Studio ISIS, and I'm 
expierencing the following problem:

First a little introduction:
I've adapted the es1968 driver, because the card is based upon a 
Maestro2EM device.
Then I took Uros' sam9407 code, and modified it a little to fit my 
needs. This is because the actual sound device of the ISIS is a SAM9707 
ISA chip, which is attached to the 'IDMA' expansion port of the Maestro 
(feature unique to the 2M / 2EM devices). Uros' code uses a HWDEP 
interface to load the firmware to the SAM device, as recommended by 
ALSA. I also adapted this tool.

Before I started on the ALSA driver, I wrote a little tool to upload the 
firmware from userspace. This allowed me to uses at least the maestro 
device with the es1968 alsa driver. This tool works fine: card is 
configured, firmware uploaded etc... I called it 'maxiinit'.

Communication occurs by the SAM raising an interrupt to the Maestro, 
which in turn raises interrupt to the host. The host then reads out the SAM.

So far for the intro...

This interrupt scheme is where my problem occurs.When using the driver 
alone, I don't get any interrupts.

So I thought of the following: why not load the firmware from userspace, 
and use my new driver in stead of the es1968 one. So I loaded the ISIS 
driver, then started the maxiinit app, and to my surprise the driver 
started to catch the SAM interrupts. So now my situation is:

Scheme 1: loading snd-isis, then trying bootload through HWDEP interface 
        => failure (no interrupt, meaning timeout)
scheme 2: loading snd-isis, run maxiinit, then trying bootload through 
HWDEP interface => success (interrupts are generated, all ok)

the strange thing is that both maxiinit, and the HWDEP ioctl 'bootload' 
are doing exactly the same.

let me give an example of both schemes: (log output)
The interrupt routine should wait for the 'ack' byte and then fill the 
'queue'.

what should happen here is:
prepare queue to wait for 0xFE and then receive 0 bytes
write 0x3F to SAM
wait for queue to get status 'done' (with timeout)
[ sam processes request and raises interrupt]
-> inthandler: read value from SAM, compare with 0xFE (should be equal)
-> inthandler: if equal, set queue status to 'done' so everything can 
continue

continue

This is reality:
Scheme1:
Jan 25 20:09:02 ox kernel: ALSA sam_ucode.c:283: sam9407: switch to UART 
mode
Jan 25 20:09:02 ox kernel: ALSA sam_io.c:216: entering queue_prepare    
                    ;prepare queue
Jan 25 20:09:02 ox kernel: ALSA sam_io.c:239: queue prepared: status=3 
ack=FE                ; queue is prepared
Jan 25 20:09:02 ox kernel: ALSA sam_io.c:73: sam9407: 
snd_sam9407_output_cmd = 0x3f    ; start output routine
Jan 25 20:09:02 ox kernel: ALSA sam_io.c:65: sam9407: 
snd_sam9407_output_ready?        ; is sam ready to receive
Jan 25 20:09:02 ox kernel: ALSA isis.c:567: write CRTL: 3F            
                ; yes, write the value
Jan 25 20:09:02 ox kernel: ALSA sam_io.c:349: sam9407: command 0x3f ack 
timeout    ; trouble in paradise
Jan 25 20:09:02 ox kernel: ALSA sam_ucode.c:289: sam9407: can't switch 
to UART mode

Scheme2: (= scheme1 but maxiinit before HWDEP bootloader)
Jan 25 20:37:25 ox kernel: ALSA sam_ucode.c:283: sam9407: switch to UART 
mode
Jan 25 20:37:25 ox kernel: ALSA sam_io.c:216: entering queue_prepare
Jan 25 20:37:25 ox kernel: ALSA sam_io.c:239: queue prepared: status=3 
ack=FE
Jan 25 20:37:25 ox kernel: ALSA sam_io.c:73: sam9407: 
snd_sam9407_output_cmd = 0x3f
Jan 25 20:37:25 ox kernel: ALSA sam_io.c:65: sam9407: 
snd_sam9407_output_ready?
Jan 25 20:37:25 ox kernel: ALSA isis.c:567: write CRTL: 3F
Jan 25 20:37:25 ox kernel: ALSA isis.c:2185: received interrupt
Jan 25 20:37:25 ox kernel: ALSA isis.c:2199: received sam interrupt
Jan 25 20:37:25 ox kernel: ALSA sam_io.c:143: entering sam interrupt
Jan 25 20:37:25 ox kernel: ALSA isis.c:600: read DATA8: FE
Jan 25 20:37:25 ox kernel: ALSA sam_io.c:155: sam9407: interrupt: stat = 
0x0, data = 0xfe

Jan 25 20:37:25 ox kernel: ALSA sam_io.c:216: entering queue_prepare    
; continue with next command
Jan 25 20:37:25 ox kernel: ALSA sam_io.c:239: queue prepared: status=3 
ack=88
Jan 25 20:37:25 ox kernel: ALSA sam_io.c:73: sam9407: 
snd_sam9407_output_cmd = 0x48
Jan 25 20:37:25 ox kernel: ALSA sam_io.c:65: sam9407: 
snd_sam9407_output_ready?
Jan 25 20:37:25 ox kernel: ALSA isis.c:567: write CRTL: 48


Anyone with a solution? Or a cause?

Thanks,

Pieter




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
