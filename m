From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v4 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
Date: Mon, 23 Apr 2018 16:04:55 +0800
Message-ID: <E5D0F76C-0A83-4D2C-81F7-BD5768C0A7DC@canonical.com>
References: <20180420094432.13133-1-kai.heng.feng@canonical.com>
 <20180420094432.13133-3-kai.heng.feng@canonical.com>
 <s5hbmeew01d.wl-tiwai@suse.de>
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C806E2671EA
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 10:05:03 +0200 (CEST)
Received: from mail-pg0-f69.google.com ([74.125.83.69])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <kai.heng.feng@canonical.com>)
 id 1fAWT8-0001UP-Sd
 for alsa-devel@alsa-project.org; Mon, 23 Apr 2018 08:05:03 +0000
Received: by mail-pg0-f69.google.com with SMTP id f19so4090318pgv.4
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 01:05:02 -0700 (PDT)
In-Reply-To: <s5hbmeew01d.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: mjg59@srcf.ucam.org, alsa-devel@alsa-project.org, Mario Limonciello <mario.limonciello@dell.com>, tiwai@suse.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, andy@infradead.org
List-Id: alsa-devel@alsa-project.org



> On Apr 20, 2018, at 8:10 PM, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 20 Apr 2018 11:44:32 +0200,
> Kai-Heng Feng wrote:
>> Now it's a typical discrete-only system. HDMI audio comes from AMD audio
>> controller, others from Intel audio controller.
>>
>> When SG is enabled, the unused AMD audio contoller still exposes its
>> sysfs, so userspace still opens the control file and stream. If
>> userspace tries to output sound through the stream, it hangs the system.
>
> Hm, could you give more information about how it hangs?

Well, I should say "it hangs the userspace process" instead.

$ speaker-test -t wav -c 2 -D hw:CARD=HDMI,DEV=3
...and it just stopped. Can't Ctrl+C to break it.

>
>
>> @@ -1627,6 +1629,42 @@ static void check_msi(struct azx *chip)
>>  	}
>>  }
>>
>> +#if IS_ENABLED(CONFIG_DELL_LAPTOP)
>
> This should be IS_REACHABLE(), as both dell-laptop and HD-audio are
> tristate.

Thanks, will update in next version.

>
>> +static bool check_dell_switchable_gfx(struct pci_dev *pdev)
>
> I'd remove "_dell" word here.  Such a check would be likely needed for
> other vendors, and it's quite possible that the function will be
> extended to cover a wider DMI table.

Makes sense. Will also update this one.

Kai-Heng

>
>
> thanks,
>
> Takashi
