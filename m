From: gianluca <gianlucarenzi@eurekelettronica.it>
Subject: Re: Fwd: Issue on Linux 4.12-rc7 on iMX6 based board
Date: Mon, 3 Jul 2017 11:36:28 +0200
Message-ID: <5d5f3326-8412-1af2-ac6f-ba3c5adf0013@eurekelettronica.it>
References: <7ab79167-fa6c-4aea-0545-48d0522d5d77@eurekelettronica.it>
 <d7d15b1d-ac7f-4b45-b7e6-e4cdc0d5cc65@eurekelettronica.it>
 <CAOMZO5C1HSN2m4P34GQq2+SKB+kmm9WUjr37T_Q_W6LwCQQQFQ@mail.gmail.com>
 <2cb47b9c-d631-6fe0-8e5c-3f1d2604ab0d@eurekelettronica.it>
 <CAOMZO5CYw-eoOuaP6Tb3c51va9ua7gvg2mTz+kX7fYtQdhsK+w@mail.gmail.com>
 <c19fa7f1-17f3-1bd0-81a2-a916fac8c1ab@eurekelettronica.it>
 <CAOMZO5CnuSim+vXB7eTBDV_PFrNf9Hgpj6AJea9hnELjaVdsTg@mail.gmail.com>
 <259c247e-3638-f814-932a-ec5a2c9200b5@eurekelettronica.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qmail.e-mind.com (qmail34.e-mind.com [188.94.192.34])
 by alsa0.perex.cz (Postfix) with SMTP id 93E39266884
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 11:36:30 +0200 (CEST)
In-Reply-To: <259c247e-3638-f814-932a-ec5a2c9200b5@eurekelettronica.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Now I did some great steps ahead! ;-)

I can assume there is some misconfigured alsa stuff in my debootstrapped 
armhf jessie distro!!!

First step: from Barebox bootloader I tried to move on/off all pins 
connected to the SGTL5000 from SoC iMX6. They are moving good, so I can 
assume _NO_HARDWARE_ issue.

Second step: burn a ubuntu armhf image (boundary-devices-jessie) to 
match up my system-boot (/etc/fstab and /etc/inittab), adding the 
/lib/modules/4.12-rc7/ directory and drivers, and add the uImage for 
4.12-rc7 on the sdcard.

Third step: burn on the sdcard the Barebox bootloader instead of the 
(unrunningble) u-boot for another board (Nitrogen).

Fourth step: turn on my board with this sdcard.

Sound is working. The levels of the capabilities (PCM, MIC, DAC, ...) 
are settable and they are working fine.

I can play and I can record. The only thing is the driver can use only 
S24_LE as frequeny for recording but afterall everything is working as 
expected.

Now the biggest question:

WTF are working alsa or its configuration in a deboostrapped armhf 
distribution? Actually this distro was upgraded two times:

1- Wheezy armel
2- Wheezy armel + armhf
3- Wheezy armhf
4- Jessie armhf
5- apt get dist-upgrade...

Something in between was wrong with alsa. Any help or configuration file 
to fix this issue???

> # aplay -L
> null
>     Discard all samples (playback) or generate zero samples (capture)
> default:CARD=imx6ek360sgtl50
>     imx6-ek360-sgtl5000,
>     Default Audio Device
> sysdefault:CARD=imx6ek360sgtl50
>     imx6-ek360-sgtl5000,
>     Default Audio Device
> dmix:CARD=imx6ek360sgtl50,DEV=0
>     imx6-ek360-sgtl5000,
>     Direct sample mixing device
> dsnoop:CARD=imx6ek360sgtl50,DEV=0
>     imx6-ek360-sgtl5000,
>     Direct sample snooping device
> hw:CARD=imx6ek360sgtl50,DEV=0
>     imx6-ek360-sgtl5000,
>     Direct hardware device without any conversions
> plughw:CARD=imx6ek360sgtl50,DEV=0
>     imx6-ek360-sgtl5000,
>     Hardware device with all software conversions

>
>
> # aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: imx6ek360sgtl50 [imx6-ek360-sgtl5000], device 0: HiFi sgtl5000-0 []
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> root@nitrogen:~# arecord -l
> **** List of CAPTURE Hardware Devices ****
> card 0: imx6ek360sgtl50 [imx6-ek360-sgtl5000], device 0: HiFi sgtl5000-0 []
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0


May I have a simple configuration file for this?


On 06/29/2017 06:28 PM, gianluca wrote:
> On 06/29/2017 04:30 PM, Fabio Estevam wrote:
>> On Thu, Jun 29, 2017 at 11:24 AM, gianluca
>> <gianlucarenzi@eurekelettronica.it> wrote:
>>
>>> So, are they good?
>>
>> If your hardware really uses these pins, then yes :-)
>>
>
> Now looking at other boards where our hardware-guy took the inspiration
> (i.e. iMX6 Rex from Fedevel) the device-tree is the same as mine.
>
>> MX6QDL_PAD_GPIO_0__CCM_CLKO1        0x030b0
>
> 0x130b0 or 0x030b0 the only difference is the PAD_CTL_HYS      (1 << 16)
>
> Maybe more strong to noise, but basically they are the same.
>
> But I found an issue when playing data from aplay without specifing the
> device or specifying one:
>
>> # aplay /usr/share/sounds/alsa/Front_Center.wav
>> Playing WAVE 'Front_Center.wav' : Signed 16 bit Little Endian, Rate
>> 48000 Hz, Mono
>
> or
>
>> # aplay -D hw:0,0 /usr/share/sounds/alsa/Front_Right.wav
>> Playing WAVE 'Front_Center.wav' : Signed 16 bit Little Endian, Rate
>> 48000 Hz, Mono
>> aplay: set_params:1233: Sample format non available
>> Available formats:
>> - S24_LE
>
> Maybe some ALSA misconfigured????
>
> This distro is a bootstrapped jessie Debian 8, so some configuration
> could be missing or not-so-good-configured.
>

Regards,
-- 
Eurek s.r.l.                          |
Electronic Engineering                | http://www.eurek.it
via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212
