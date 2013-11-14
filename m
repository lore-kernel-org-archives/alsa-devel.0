From: Ivailo Monev <xakepa10@gmail.com>
Subject: Re: udev rules prefix
Date: Thu, 14 Nov 2013 12:08:47 +0000
Message-ID: <5284BD4F.8080205@gmail.com>
References: <CABdmW1cQmesQfC2Kwt4CBOJzrVGBdaC2m2KFb4XeQZYhJAzfMQ@mail.gmail.com>
 <s5hr4ajqy5d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f53.google.com (mail-bk0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E6F02616E1
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 10:10:32 +0100 (CET)
Received: by mail-bk0-f53.google.com with SMTP id na10so848599bkb.26
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 01:10:32 -0800 (PST)
Received: from [31.211.147.156] ([31.211.147.156])
 by mx.google.com with ESMTPSA id b7sm1662051bkg.1.2013.11.14.01.10.30
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 14 Nov 2013 01:10:31 -0800 (PST)
In-Reply-To: <s5hr4ajqy5d.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/14/13 02:48, David Henningsson wrote:
> On 11/13/2013 09:36 PM, Ivailo wrote:
>> Hello,
>>
>> the default prefix for alsa-utils is /usr however the udev rules directory
>> is /lib/udev/rules.d thus on setups with separate partition for /usr the
>> binaries, from /usr/bin and /usr/sbin, will likely not be available during
>> the boot process and the udev rule will fail to restore the state.
>>
>> I suggest that the udev rules directory follows the prefix or append /usr
>> to it to resolve this.
>>
>> Cheers!
> Hi,
>
> ALSA merely follows what udev dictates, so I think your
> question/suggestion is better redirected on the udev (now systemd)
> mailinglist. Or potentially that of your distro.
>
Actually, you are not following what udev dictates (unless I'm missing 
something).
By default, systemd (and more importantly udev) will be installed with 
/usr prefix
(which is wrong in it self because it blindly assumes that /usr has been 
mounted
via initrd/initramfs where separate /usr partition is in use but let's 
not talk about
this here).


On 11/14/13 06:45, Takashi Iwai wrote:
> At Wed, 13 Nov 2013 20:36:48 +0000,
> Ivailo wrote:
>> Hello,
>>
>> the default prefix for alsa-utils is /usr however the udev rules directory
>> is /lib/udev/rules.d thus on setups with separate partition for /usr the
>> binaries, from /usr/bin and /usr/sbin, will likely not be available during
>> the boot process and the udev rule will fail to restore the state.
> Not true.  /lib must be always present at boot even if /usr isn't
> mounted.  That's the reason why /lib/udev was chosen as default in the
> past.
>
>
> Takashi
You got me wrong, I know that /lib should be available on early boot 
(unless it's a
symlink, like in Arch Linux) but the point is that since the alsa-utils 
binaries are
installed in /usr so should be the udev rules otherwise during boot 
without /usr
being mounted you will see error message about /usr/sbin/alsactl.
