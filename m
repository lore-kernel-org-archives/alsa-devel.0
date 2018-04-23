From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 2/3] platform/x86: dell-*: Add interface
 for switchable graphics status query
Date: Mon, 23 Apr 2018 16:43:41 +0300
Message-ID: <CAHp75VdwtOS_B978JOXqWRnj611jMJyN7BxFr+qu+Ojdf07i2Q@mail.gmail.com>
References: <20180420094432.13133-1-kai.heng.feng@canonical.com>
 <20180420094432.13133-2-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f176.google.com (mail-qk0-f176.google.com
 [209.85.220.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BBBC266E30
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 15:43:53 +0200 (CEST)
Received: by mail-qk0-f176.google.com with SMTP id o64so16150454qkl.7
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 06:43:53 -0700 (PDT)
In-Reply-To: <20180420094432.13133-2-kai.heng.feng@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mario Limonciello <mario.limonciello@dell.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 20, 2018 at 12:44 PM, Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> On some Dell platforms, there's a BIOS option "Enable Switchable
> Graphics". This information is useful if we want to do different things
> based on this value, e.g. disable unused audio controller that comes
> with the discrete graphics.

>  int dell_micmute_led_set(int on);
> +bool dell_switchable_gfx_is_enabled(void);

I would rather preserve existing API, i.e.
 - prototype int func(void), where return either state or negative error code.
 - naming: dell_switchable_gfx_get()

-- 
With Best Regards,
Andy Shevchenko
