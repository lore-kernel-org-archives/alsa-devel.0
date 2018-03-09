From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2 2/3] platform/x86: dell-*: Add interface for switchable
 graphics status query
Date: Fri, 9 Mar 2018 16:14:03 +0800
Message-ID: <DC881209-6C71-4B13-BF48-05F1F93E207A@canonical.com>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-2-kai.heng.feng@canonical.com>
 <20180308163837.myfmnowz5ogto52w@pali>
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.15\))
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308163837.myfmnowz5ogto52w@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: mjg59@srcf.ucam.org, dvhart@infradead.org, andy@infradead.org, Mario Limonciello <mario.limonciello@dell.com>, tiwai@suse.com, platform-driver-x86@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



> On Mar 9, 2018, at 12:38 AM, Pali Rohár <pali.rohar@gmail.com> wrote:
>
> On Thursday 08 March 2018 17:10:22 Kai-Heng Feng wrote:
>> +int dell_switchable_gfx_enabled(bool *enabled);
>
> What about following API?
>
> bool dell_switchable_gfx_is_enabled(void);
>
> Are you really interested in errors? Then what about?

Not really. We can assume it's false when there's any error.

I'll update the function in next version, thanks!

Kai-Heng

>
> int dell_switchable_gfx_is_enabled(void);
>
> with e.g.
>   < 0 - error
>   = 0 - disabled
>> 0 - enabled
>
> -- 
> Pali Rohár
> pali.rohar@gmail.com
