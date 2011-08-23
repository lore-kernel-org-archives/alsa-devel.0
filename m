From: Kristian Amlie <kristian@amlie.name>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Tue, 23 Aug 2011 13:57:14 +0200
Message-ID: <4E53959A.7090702@amlie.name>
References: <4E5234F0.8000502@amlie.name>	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>	<4E52401C.8030605@amlie.name>	<4E537524.9010303@ladisch.de>	<4E537BE9.4050004@amlie.name>
	<CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy8-pub.bluehost.com (oproxy8-pub.bluehost.com
	[69.89.22.20]) by alsa0.perex.cz (Postfix) with SMTP id C8A131039D9
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 13:57:48 +0200 (CEST)
In-Reply-To: <CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 08/23/11 12:16, Daniel Mack wrote:
> On Tue, Aug 23, 2011 at 12:07 PM, Kristian Amlie <kristian@amlie.name> wrote:
>> On 08/23/11 11:38, Clemens Ladisch wrote:
>>> Kristian Amlie wrote:
>>>>   idVendor           0x0403 Future Technology Devices International, Ltd
>>>>   idProduct          0xb8d8
>>>
>>> There is a kernel driver for this chipset; try
>>> "modprobe ftdi_sio product=0xb8d8".  This will give you a serial port
>>> which you can try to configure for the correct baud rate and see whether
>>> MIDI bytes come out.  (There is currently no mechanism to make a MIDI
>>> device from such a serial port; this would require extending or creating
>>> a driver.)
>>
>> Forgive me, I'm not very well acquainted with how serial drivers work in
>> Linux. The driver did give me a new device, so here is what I tried:
>>
>> $ setserial /dev/ttyUSB0 spd_normal uart 16550A
>> $ cat /dev/ttyUSB0 > dump
>>
>> I was not able to get any output from the serial device, however, while
>> cat was running and I was pressing buttons on the instrument, it
>> spontaneously changed program on me (MIDI program change), so
>> *something* goes across the wire.
> 
> Try "cu" (provided in the package "uucp" on some distributions), and
> see if you can make the hardware operate on 31250 Baud, which is the
> nominal rate for MIDI. If you can, you should be able to receive a raw
> MIDI byte stream. But as I say, I think that requires a special
> divider setup that is not supported by the ftdi_sio driver.

I was not able to to use 31250 baud as you suggested. However, I tried
38400 baud, and that seemed to work. I got a small number of bytes
everytime I pressed a key on the instrument.

Using the following command line:

$ cu -s 38400 -l /dev/ttyUSB0 | hexdump -C

and pressing the same key repeatedly with the same force, I got the
following output:

00000000  18 f9 ff 18 03 f8 18 f9  ff 18 01 f8 18 f9 ff 18
|................|
00000010  01 f8 18 fb ff 18 01 f8  18 fb ff 18 01 f8 18 fb
|................|
00000020  ff 18 03 f8 18 f9 ff 18  01 f8 18 fb ff 18 01 f8
|................|
00000030  18 fb ff 18 01 f8 18 fb  ff 18 01 f8 07 43 6f 6e
|.............Con|
00000040  6e 65 63 74 65 64 2e 0a  07 43 6f 6e 6e 65 63 74
|nected...Connect|
00000050  65 64 2e 0a 0a 07 44 69  73 63 6f 6e 6e 65 63 74
|ed....Disconnect|
00000060  65 64 2e 0a                                       |ed..|
00000064

-- 
Kristian
