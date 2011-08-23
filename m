From: Kristian Amlie <kristian@amlie.name>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Tue, 23 Aug 2011 15:12:40 +0200
Message-ID: <4E53A748.4070404@amlie.name>
References: <4E5234F0.8000502@amlie.name>	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>	<4E52401C.8030605@amlie.name>	<4E537524.9010303@ladisch.de>	<4E537BE9.4050004@amlie.name>	<CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>	<4E53959A.7090702@amlie.name>
	<CACTFLAMh2Brji5NBOZjtDmyP-DPR3S4HCP93SO0sE9J7xEn3NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy9.bluehost.com (oproxy9.bluehost.com [69.89.24.6])
	by alsa0.perex.cz (Postfix) with SMTP id 4C2531039F5
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 15:12:54 +0200 (CEST)
In-Reply-To: <CACTFLAMh2Brji5NBOZjtDmyP-DPR3S4HCP93SO0sE9J7xEn3NQ@mail.gmail.com>
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

On 08/23/11 14:20, Daniel Mack wrote:
> On Tue, Aug 23, 2011 at 1:57 PM, Kristian Amlie <kristian@amlie.name> wrote:
>> I was not able to to use 31250 baud as you suggested. However, I tried
>> 38400 baud, and that seemed to work. I got a small number of bytes
>> everytime I pressed a key on the instrument.
>>
>> Using the following command line:
>>
>> $ cu -s 38400 -l /dev/ttyUSB0 | hexdump -C
>>
>> and pressing the same key repeatedly with the same force, I got the
>> following output:
>>
>> 00000000  18 f9 ff 18 03 f8 18 f9  ff 18 01 f8 18 f9 ff 18
>> |................|
>> 00000010  01 f8 18 fb ff 18 01 f8  18 fb ff 18 01 f8 18 fb
>> |................|
>> 00000020  ff 18 03 f8 18 f9 ff 18  01 f8 18 fb ff 18 01 f8
>> |................|
>> 00000030  18 fb ff 18 01 f8 18 fb  ff 18 01 f8 07 43 6f 6e
>> |.............Con|
>> 00000040  6e 65 63 74 65 64 2e 0a  07 43 6f 6e 6e 65 63 74
>> |nected...Connect|
>> 00000050  65 64 2e 0a 0a 07 44 69  73 63 6f 6e 6e 65 63 74
>> |ed....Disconnect|
>> 00000060  65 64 2e 0a                                       |ed..|
>> 00000064
> 
> That hexdump reads as "Connected....Disconnected". Are you sure you
> get useful data from cu?

Quite sure. Those messages are just from cu (I assume), telling me that
I connected and disconnected (by killing it). If I run it without
piping, they appear before and after the bytestream as they should. I
don't really know why they appear at the end in that output; maybe a
buffering issue.

In either case, the important data is in the three first lines. That is
what appears while I'm pressing the keys.

> If you are certain about this, I would recommend you add some debug
> printk() into drivers/usb/serial/ftdi_sio.c and trace what values the
> functions change_speed() and update_mctrl() pass to usb_control_msg()
> when the device is connected and cu is started. Once we have this
> information, I can prepare a patch to add the control messages to the
> MIDI driver.

Alright, I guess it is the urb_value and urb_index values you are
interested in?

Here is the output from one complete run of cu, including connecting,
pressing a key once on the instrument and killing cu afterwards:

[20380.847492] change_speed(): urb_value: 16696, urb_index: 0
[20380.849364] update_mctrl(): urb_value: 771, priv->interface: 0
[20380.851360] change_speed(): urb_value: 49230, urb_index: 0
[20380.854412] change_speed(): urb_value: 49230, urb_index: 0
[20380.857361] change_speed(): urb_value: 49230, urb_index: 0
[20387.615704] change_speed(): urb_value: 16696, urb_index: 0
[20387.619557] update_mctrl(): urb_value: 768, priv->interface: 0

-- 
Kristian
