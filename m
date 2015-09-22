From: Arun Raghavan <arun@accosted.net>
Subject: Re: [PATCH - alsa-utils 1/1] arecord: Remove only
 regular files
Date: Tue, 22 Sep 2015 18:54:42 +0530
Message-ID: <CACuU-+gX-QnsE_KHwX_55zCZRcKw=V=JvQkuKwvkfNoCDTmL5g@mail.gmail.com>
References: <1442840757-5403-1-git-send-email-a.volkov@rusbitech.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f182.google.com (mail-yk0-f182.google.com
 [209.85.160.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B2232625CF
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 15:25:04 +0200 (CEST)
Received: by ykft14 with SMTP id t14so8560759ykf.0
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 06:25:02 -0700 (PDT)
In-Reply-To: <1442840757-5403-1-git-send-email-a.volkov@rusbitech.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Volkov <a.volkov@rusbitech.ru>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 21 September 2015 at 18:35, Alexander Volkov <a.volkov@rusbitech.ru> wrote:
> arecord removes a file before writing into it. It's not
> appropriate in some cases. For example, if you a pass
> a symlink to a file, then the symlink will be removed
> while the user expects to record into the symlink's target.
> Another case is recording into the device file. Some
> modems provide a tty device file as a voice device.
> And it's not possible to write into it under root with
> arecord, because it removes the device file.
>
> So check the type of a file before writing into it and
> remove only regular files.
>
> Signed-off-by: Alexander Volkov <a.volkov@rusbitech.ru>
>
> diff --git a/aplay/aplay.c b/aplay/aplay.c
> index 459f7dd..1b2cdfc 100644
> --- a/aplay/aplay.c
> +++ b/aplay/aplay.c
> @@ -2929,6 +2929,7 @@ static void capture(char *orig_name)
>         char *name = orig_name; /* current filename */
>         char namebuf[PATH_MAX+1];
>         off64_t count, rest;            /* number of bytes to capture */
> +       struct stat statbuf;
>
>         /* get number of bytes to capture */
>         count = calc_count();
> @@ -2973,7 +2974,10 @@ static void capture(char *orig_name)
>                         }
>
>                         /* open a new file */
> -                       remove(name);
> +                       if (!lstat(name, &statbuf)) {
> +                               if (S_ISREG(statbuf.st_mode))
> +                                       remove(name);
> +                       }
>                         fd = safe_open(name);
>                         if (fd < 0) {
>                                 perror(name);

Would it work to just open with O_TRUNC?

-- Arun
