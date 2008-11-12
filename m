From: "Arun KS" <getarunks@gmail.com>
Subject: Re: amixer error
Date: Wed, 12 Nov 2008 17:05:28 +0530
Message-ID: <dfeb90390811120335x143d60fw96059321719b73fe@mail.gmail.com>
References: <dfeb90390811110225m8e77523pd9cccccbae7ea1ec@mail.gmail.com>
	<s5h63muqxtz.wl%tiwai@suse.de>
	<dfeb90390811112131y6a70f59aj3b02347303517ca1@mail.gmail.com>
	<200811120857.54214.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.241])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BBBD243B3
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 12:35:30 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so357806rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 03:35:28 -0800 (PST)
In-Reply-To: <200811120857.54214.gineera@aspect135.co.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 12, 2008 at 2:27 PM, Alan Horstmann <gineera@aspect135.co.uk> wrote:
> On Wednesday 12 November 2008 05:31, Arun KS wrote:
>> On Tue, Nov 11, 2008 at 5:27 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Tue, 11 Nov 2008 17:15:15 +0530,
>> >
>> > Arun KS wrote:
>> >> On Tue, Nov 11, 2008 at 4:08 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> > At Tue, 11 Nov 2008 15:55:38 +0530,
>> >> >
>> >> > Arun KS wrote:
>> >> >> Hi,
>> >> >>
>> >> >> I am getting an error for amixer, but my amixer controls works fine.
>> >> >>
>> >> >> Here is the log:
>> >> >>
>> >> >> [root@OMAP2530EVM ~]#
>> >> >> [root@OMAP2530EVM ~]#
>> >> >> [root@OMAP2530EVM ~]#
>> >> >> [root@OMAP2530EVM ~]# amixer
>> >> >> amixer: Mixer default load error: Operation not permitted
>> >> >
>> >> > How about checking via strace?
>> >>
>> >> Below is the strace output:
>> >
>> > ...
>> >
>> >> open("/dev/snd/controlC0", O_RDWR)      = 3
>> >> ioctl(3, USBDEVFS_CONTROL, 0xbea498fc)  = 0
>> >> fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
>> >> fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
>> >> ioctl(3, USBDEVFS_RELEASEINTERFACE, 0xbea49980) = 0
>> >> ioctl(3, USBDEVFS_RELEASEINTERFACE, 0xbea49980) = 0
>> >> ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
>> >> ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = 0
>> >> ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
>> >> ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
>> >> ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
>> >> ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
>> >> ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
>> >> ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
>> >> ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
>> >> ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
>> >> ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
>> >> ioctl(3, USBDEVFS_IOCTL, 0xbea492d8)    = 0
>> >> ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
>> >> ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = 0
>> >> ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = 0
>> >> ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
>> >> ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = -1 EPERM (Operation not
>> >> permitted)
>> >
>> > Weird.  USBDEVFS_IOCTL corresponds to SNDRV_IOCTL_ELEM_REPLACE,
>> > and USBDEVFS_CONNECTINFO to SNDRV_IOCTL_ELEM_ADD.
>> > [some strace versions don't show SNDRV_* ioctls because they are defined
>> >  via enum instead of #define in asound.h...]
>> > These are for user-defined control elements.
>> > And, strace shows that you don't use any ~/.asound or /etc/asound.conf...
>>
>> But when i use a different kernel and different codec with the same
>> file system, amixer is working.
>>
>> So the filesytem is fine. AM I Rite?
>>
>> Is it kernel dependent?
>
> This is embedded, on ARM -right?  I'll just throw in a couple of suggestions
> we went through as 'newbie-at-embedded's.  The build environment can cause
> havoc! (which are you using?) and throw up spurious errors.
>
> The filesystem contains Alsa-lib, whereas the kernel image is usually
> separate.  However the Alsa-lib is really a user abstraction of the kernel
> driver, and as such it's version needs to correspond to the particular
> Alsa-driver in the kernel (Takashi correct me if I understand wrong).  Thus
> our build environment's habit of allowing you to select a specific kernel
> source by number and then getting either a fixed old Alsa-lib (the same one
> as always) or just getting the latest release, but in either case with no
> reference to the kernel, causes potential problems in the driver<->lib
> interface.  (Been there).
>
> Also we experienced unpredictable errors with versioned symbols and UClibc
> (which I have posted about previously).  Other build parameters such as the
> setting of -mabi can cause incompatibilities between parts.
>
> Just ideas, HTH,

Thanks Alan.
Thanks Takashi.

I am using 2.6.22 kernel, in which alsa verson is 1.0.14. I downgraded
my alsa lib and utills to
1.0.14, but still i have the same error. Need to see what the issue is.

Thanks again for your time and support.

Regards,
Arun KS
 >
> Alan
>
>
>
>
