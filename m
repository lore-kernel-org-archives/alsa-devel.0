From: "Arun KS" <getarunks@gmail.com>
Subject: Re: amixer error
Date: Wed, 12 Nov 2008 11:01:07 +0530
Message-ID: <dfeb90390811112131y6a70f59aj3b02347303517ca1@mail.gmail.com>
References: <dfeb90390811110225m8e77523pd9cccccbae7ea1ec@mail.gmail.com>
	<s5hk5bar1if.wl%tiwai@suse.de>
	<dfeb90390811110345t4bee5c67l28fe807ad9de7667@mail.gmail.com>
	<s5h63muqxtz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from po-out-1718.google.com (po-out-1718.google.com [72.14.252.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BE4D1037FC
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 06:31:09 +0100 (CET)
Received: by po-out-1718.google.com with SMTP id b23so348901poe.2
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 21:31:08 -0800 (PST)
In-Reply-To: <s5h63muqxtz.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 11, 2008 at 5:27 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 11 Nov 2008 17:15:15 +0530,
> Arun KS wrote:
>>
>> On Tue, Nov 11, 2008 at 4:08 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Tue, 11 Nov 2008 15:55:38 +0530,
>> > Arun KS wrote:
>> >>
>> >> Hi,
>> >>
>> >> I am getting an error for amixer, but my amixer controls works fine.
>> >>
>> >> Here is the log:
>> >>
>> >> [root@OMAP2530EVM ~]#
>> >> [root@OMAP2530EVM ~]#
>> >> [root@OMAP2530EVM ~]#
>> >> [root@OMAP2530EVM ~]# amixer
>> >> amixer: Mixer default load error: Operation not permitted
>> >
>> > How about checking via strace?
>>
>> Below is the strace output:
> ...
>> open("/dev/snd/controlC0", O_RDWR)      = 3
>> ioctl(3, USBDEVFS_CONTROL, 0xbea498fc)  = 0
>> fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
>> fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
>> ioctl(3, USBDEVFS_RELEASEINTERFACE, 0xbea49980) = 0
>> ioctl(3, USBDEVFS_RELEASEINTERFACE, 0xbea49980) = 0
>> ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
>> ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = 0
>> ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
>> ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
>> ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
>> ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
>> ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
>> ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
>> ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
>> ioctl(3, USBDEVFS_IOCTL, 0xbea492e0)    = 0
>> ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
>> ioctl(3, USBDEVFS_IOCTL, 0xbea492d8)    = 0
>> ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
>> ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = 0
>> ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = 0
>> ioctl(3, USBDEVFS_CONNECTINFO, 0xbea49718) = 0
>> ioctl(3, USBDEVFS_IOCTL, 0xbea492c0)    = -1 EPERM (Operation not permitted)
>
> Weird.  USBDEVFS_IOCTL corresponds to SNDRV_IOCTL_ELEM_REPLACE,
> and USBDEVFS_CONNECTINFO to SNDRV_IOCTL_ELEM_ADD.
> [some strace versions don't show SNDRV_* ioctls because they are defined
>  via enum instead of #define in asound.h...]
> These are for user-defined control elements.
> And, strace shows that you don't use any ~/.asound or /etc/asound.conf...

But when i use a different kernel and different codec with the same
file system, amixer is working.

So the filesytem is fine. AM I Rite?

Is it kernel dependent?

Regards,
Arun



> Takashi
>
