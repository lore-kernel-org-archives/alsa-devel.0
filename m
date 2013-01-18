From: Miro Hodak <mhodak127@gmail.com>
Subject: Re: HD-audio regression after commit
	34588709af61be1550b4e2bcee5c85d0ac4f34d4
Date: Fri, 18 Jan 2013 02:31:49 -0500
Message-ID: <CA+S_cwqE6AgcVjp+wtPuJA_AcJqUvL0Ocoq_QA5JVWQVYCsYSg@mail.gmail.com>
References: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
 <s5hehhk2uee.wl%tiwai@suse.de>
 <CAN8cciZEWPdKcX2J=16ry9UVoXZwasF7GfN9O4JGwJPx+0Y8zQ@mail.gmail.com>
 <s5h8v7s2tja.wl%tiwai@suse.de>
 <CA+S_cwowFrLAWSRiQvPX5AZwuyo9DdA4qS7Xn3bMYy=AzzpHdg@mail.gmail.com>
 <s5hvcaw18qf.wl%tiwai@suse.de>
 <CA+S_cwq7mDPkjPCVpRecO93UW2gpYo7BpMfFARu0PZCvNT-w4A@mail.gmail.com>
 <s5hsj6017km.wl%tiwai@suse.de>
 <CA+S_cwo2mZn+5P3JuNWXZ+3taQcSHmvRhm95vjupY1o+FA+cpw@mail.gmail.com>
 <s5hobgo16ct.wl%tiwai@suse.de>
 <CA+S_cwqeP90pFpFviKns-bxxBS6ahunPgRfCG0BQTa5ZLPtE-Q@mail.gmail.com>
 <s5hlibs154t.wl%tiwai@suse.de>
 <CA+S_cwoLe=2tUr=EyFM0TxvbBaB12DCE2yDPwf3OzoRcO8jQug@mail.gmail.com>
 <CAN8cciama4q0EOiUsjp-KyyzehcvjwmdPdBQ9vsitbnR8g1PgA@mail.gmail.com>
 <CA+S_cwrmHguxk6WBxjAJTOaV8xV-4PH0gkpibFKs1P8bRxAsAg@mail.gmail.com>
 <s5hfw1zomf2.wl%tiwai@suse.de> <20130117191224.44794728@gmail.com>
 <s5hfw1z1s6a.wl%tiwai@suse.de> <20130117214043.5a1574ee@gmail.com>
 <s5h7gnb0y5z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f181.google.com (mail-ie0-f181.google.com
 [209.85.223.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 33BF2265243
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 08:31:52 +0100 (CET)
Received: by mail-ie0-f181.google.com with SMTP id 16so5970531iea.12
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 23:31:50 -0800 (PST)
In-Reply-To: <s5h7gnb0y5z.wl%tiwai@suse.de>
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
Cc: Raymond Yau <superquad.vortex2@gmail.com>, basinilya@gmail.com, =?ISO-8859-1?Q?Manolo_D=EDaz?= <diaz.manolo@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 18, 2013 at 2:04 AM, Takashi Iwai <tiwai@suse.de> wrote:

>
> Thanks.  It turned out that simply missing unsol_event handlers in the
> codec driver code.  The patch below should fix the issue.  It's
> already merged in test/hda-migrate and master branches.
>
>
> Takashi
>
> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Fix missing unsol event handler in some codec
>  drivers
>
> This resulted in non-working auto-mute behavior, of course...
>
>
Tested and it works for me!

Thanks for great work.
