From: Daniel Mack <zonque@gmail.com>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Tue, 23 Aug 2011 14:20:11 +0200
Message-ID: <CACTFLAMh2Brji5NBOZjtDmyP-DPR3S4HCP93SO0sE9J7xEn3NQ@mail.gmail.com>
References: <4E5234F0.8000502@amlie.name>
	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>
	<4E52401C.8030605@amlie.name> <4E537524.9010303@ladisch.de>
	<4E537BE9.4050004@amlie.name>
	<CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>
	<4E53959A.7090702@amlie.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E7A9624673
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 14:20:12 +0200 (CEST)
Received: by yxk36 with SMTP id 36so26037yxk.38
	for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2011 05:20:12 -0700 (PDT)
In-Reply-To: <4E53959A.7090702@amlie.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristian Amlie <kristian@amlie.name>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 23, 2011 at 1:57 PM, Kristian Amlie <kristian@amlie.name> wrote:
> I was not able to to use 31250 baud as you suggested. However, I tried
> 38400 baud, and that seemed to work. I got a small number of bytes
> everytime I pressed a key on the instrument.
>
> Using the following command line:
>
> $ cu -s 38400 -l /dev/ttyUSB0 | hexdump -C
>
> and pressing the same key repeatedly with the same force, I got the
> following output:
>
> 00000000 =A018 f9 ff 18 03 f8 18 f9 =A0ff 18 01 f8 18 f9 ff 18
> |................|
> 00000010 =A001 f8 18 fb ff 18 01 f8 =A018 fb ff 18 01 f8 18 fb
> |................|
> 00000020 =A0ff 18 03 f8 18 f9 ff 18 =A001 f8 18 fb ff 18 01 f8
> |................|
> 00000030 =A018 fb ff 18 01 f8 18 fb =A0ff 18 01 f8 07 43 6f 6e
> |.............Con|
> 00000040 =A06e 65 63 74 65 64 2e 0a =A007 43 6f 6e 6e 65 63 74
> |nected...Connect|
> 00000050 =A065 64 2e 0a 0a 07 44 69 =A073 63 6f 6e 6e 65 63 74
> |ed....Disconnect|
> 00000060 =A065 64 2e 0a =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 |ed..|
> 00000064

That hexdump reads as "Connected....Disconnected". Are you sure you
get useful data from cu?

If you are certain about this, I would recommend you add some debug
printk() into drivers/usb/serial/ftdi_sio.c and trace what values the
functions change_speed() and update_mctrl() pass to usb_control_msg()
when the device is connected and cu is started. Once we have this
information, I can prepare a patch to add the control messages to the
MIDI driver.


Daniel
