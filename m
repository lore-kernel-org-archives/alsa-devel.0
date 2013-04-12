From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Re: M-Audio Delta 1010LT: S/PDIF clock source not
	working
Date: Fri, 12 Apr 2013 16:53:01 +0200
Message-ID: <51681FCD.5070800@gmail.com>
References: <515EEF10.1020007@gmail.com> <5160C35A.8020403@gmail.com>
 <5161A6D3.3060602@gmail.com> <201304072135.45811.gineera@aspect135.co.uk>
 <51634B17.3050907@gmail.com> <516423F0.9020409@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f50.google.com (mail-bk0-f50.google.com
 [209.85.214.50])
 by alsa0.perex.cz (Postfix) with ESMTP id CF8BD2616B9
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2013 16:53:04 +0200 (CEST)
Received: by mail-bk0-f50.google.com with SMTP id jg1so1403370bkc.23
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2013 07:53:04 -0700 (PDT)
In-Reply-To: <516423F0.9020409@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am 09.04.2013 16:21, schrieb Pavel Hofman:
> Please check ice1712 register values, specifically MT RATE to make sure
> ice1712 is switched to internal clocks when it should be clocked
> externally instead (
> http://ftp.sunet.se/pub/Linux/alsa/manuals/icensemble/envy24.pdf ). Or
> just dump  ice1712 in proc here, I will check with the datasheet.
>
> Unfortunately there is no /proc register dump coded for cs8427 yet. If
> you want to investigate further, you can add it to i2c/cs8427.c in a
> manner similar to e.g.
> http://git.alsa-project.org/?p=alsa-kmirror.git;a=blob;f=i2c/other/ak4114.c;h=fdf3c1b65e388414c995a597ef2b351b4ec2a220;hb=HEAD#l451

All right. I got cs8427 in proc now! I included registers 0x00 to 0x1f 
plus 0x7f which "is I.D. and version". I'll post a patch later.

Now I have the following scenario: Delta 1010LT internal clock on 
'IEC958 Input', internal clock default is 44100. I got a 1 kHz sine 
signal at the S/PDIF input with 96kHz samplerate. Due to the reverted 
patch it is capturing with 96kHz. Rate Locking / Rate Reset / Wordclock 
Status / Wordclock Sync are all 'off'.

Using a jack app or recording directly from alsa with audacity shows 
that the signal is not clean. It's got errors. Specifically once in a 
while (about every 5 seconds) a single sample value will last over the 
time of two samples. The signal gets shifted.

cs8427 register 0x04 bits 1:0 (RDX1:0: Recovered Input Clock Source) says:

   01 - 256 * Fsi, where Fsi is derived from the AES3 input frame rate

Whatever that means. Other values are:

   00 - 256 * Fsi, where Fsi is derived from the ILRCK pin (only possible
        when the serial audio input port is in slave mode)

   10 - Bypass the PLL and apply an external 256 * Fsi clock through the
        RMCK pin. The AES3 receiver is held in synchronous reset. This
        setting is useful to prevent UNLOCK interrupts when using an
        external RMCK and inputting data through the serial audio input
        port.

Serial audio input and output ports are in slave mode.

Here's the full contents of the proc files (the binary representations 
are in parenthesis added by a little tool that I wrote):

/proc/asound/M1010LT/cs8427:
-------------------------------------------
0x00 = 0x00 (00000000)
0x01 = 0x81 (10000001)
0x02 = 0x00 (00000000)
0x03 = 0x0c (00001100)
0x04 = 0x41 (01000001)
0x05 = 0x05 (00000101)
0x06 = 0x05 (00000101)
0x07 = 0x00 (00000000)
0x08 = 0x00 (00000000)
0x09 = 0x00 (00000000)
0x0a = 0x00 (00000000)
0x0b = 0x00 (00000000)
0x0c = 0x00 (00000000)
0x0d = 0x00 (00000000)
0x0e = 0x00 (00000000)
0x0f = 0x41 (01000001)
0x10 = 0x00 (00000000)
0x11 = 0xff (11111111)
0x12 = 0x18 (00011000)
0x13 = 0x12 (00010010)
0x14 = 0x00 (00000000)
0x15 = 0x00 (00000000)
0x16 = 0x00 (00000000)
0x17 = 0x00 (00000000)
0x18 = 0x00 (00000000)
0x19 = 0x00 (00000000)
0x1a = 0x00 (00000000)
0x1b = 0x00 (00000000)
0x1c = 0x00 (00000000)
0x1d = 0x00 (00000000)
0x1e = 0x40 (01000000)
0x1f = 0x00 (00000000)
0x7f = 0x71 (01110001)
-------------------------------------------

/proc/asound/M1010LT/ak4524:
-------------------------------------------
chip 0: 0x00 = 0x07 (00000111)
chip 0: 0x01 = 0x03 (00000011)
chip 0: 0x02 = 0x60 (01100000)
chip 0: 0x03 = 0x19 (00011001)
chip 0: 0x04 = 0x7f (01111111)
chip 0: 0x05 = 0x7f (01111111)
chip 0: 0x06 = 0x00 (00000000)
chip 0: 0x07 = 0x00 (00000000)
chip 1: 0x00 = 0x07 (00000111)
chip 1: 0x01 = 0x03 (00000011)
chip 1: 0x02 = 0x60 (01100000)
chip 1: 0x03 = 0x19 (00011001)
chip 1: 0x04 = 0x00 (00000000)
chip 1: 0x05 = 0x00 (00000000)
chip 1: 0x06 = 0x00 (00000000)
chip 1: 0x07 = 0x00 (00000000)
chip 2: 0x00 = 0x07 (00000111)
chip 2: 0x01 = 0x03 (00000011)
chip 2: 0x02 = 0x60 (01100000)
chip 2: 0x03 = 0x19 (00011001)
chip 2: 0x04 = 0x00 (00000000)
chip 2: 0x05 = 0x00 (00000000)
chip 2: 0x06 = 0x00 (00000000)
chip 2: 0x07 = 0x00 (00000000)
chip 3: 0x00 = 0x07 (00000111)
chip 3: 0x01 = 0x03 (00000011)
chip 3: 0x02 = 0x60 (01100000)
chip 3: 0x03 = 0x19 (00011001)
chip 3: 0x04 = 0x00 (00000000)
chip 3: 0x05 = 0x00 (00000000)
chip 3: 0x06 = 0x00 (00000000)
chip 3: 0x07 = 0x00 (00000000)
-------------------------------------------

/proc/asound/M1010LT/ice1712
-------------------------------------------
M Audio Delta 1010LT at 0xd040, irq 20

EEPROM:
   Subvendor        : 0x12143bd6
   Size             : 29 bytes
   Version          : 1
   Codec            : 0x1f (00011111)
   ACLink           : 0x80 (10000000)
   I2S ID           : 0x72 (01110010)
   S/PDIF           : 0x3 (00000011)
   GPIO mask        : 0x4 (00000100)
   GPIO state       : 0x7e (01111110)
   GPIO direction   : 0xfb (11111011)
   AC'97 main       : 0x0 (00000000)
   AC'97 pcm        : 0x0 (00000000)
   AC'97 record     : 0x0 (00000000)
   AC'97 record src : 0x44 (01000100)
   DAC ID #0        : 0x3 (00000011)
   DAC ID #1        : 0x3 (00000011)
   DAC ID #2        : 0x3 (00000011)
   DAC ID #3        : 0x3 (00000011)
   ADC ID #0        : 0x3 (00000011)
   ADC ID #1        : 0x3 (00000011)
   ADC ID #2        : 0x3 (00000011)
   ADC ID #3        : 0x3 (00000011)
   Extra #28        : 0x0 (00000000)

Registers:
   PSDOUT03         : 0x0000
   CAPTURE          : 0x00000000
   SPDOUT           : 0x0000
   RATE             : 0x10 (00010000)
   GPIO_DATA        : 0x5a (01011010)
   GPIO_WRITE_MASK  : 0x04 (00000100)
   GPIO_DIRECTION   : 0xfb (11111011)

-------------------------------------------

- Jonas
