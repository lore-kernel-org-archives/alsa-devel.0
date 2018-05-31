From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 15/21] ALSA: oxygen: use match_string() helper
Date: Thu, 31 May 2018 21:41:36 +0300
Message-ID: <CAHp75VeNgTVT_O_ytF2C_iavkDLz5uxQggxboWpB9f1fgjkYdQ@mail.gmail.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com> <1527765086-19873-16-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527765086-19873-16-git-send-email-xieyisheng1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 31, 2018 at 2:11 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.

Sorry, didn't notice before one thing:

> +               j = match_string(known_ctl_names, CONTROL_COUNT, ctl->id.name);
> +               if (j >= 0) {
> +                       chip->controls[j] = ctl;
> +                       ctl->private_free = oxygen_any_ctl_free;
> +               }

It looks to me you may get rid of j completely by utilizing existing err.

-- 
With Best Regards,
Andy Shevchenko
