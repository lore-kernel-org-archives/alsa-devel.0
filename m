From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH - Fix typo in configure.ac 1/1] PATCH - Fix
 typo in configure.ac
Date: Tue, 25 Sep 2018 10:00:31 +0200
Message-ID: <8a6c56eb-cfb5-efac-f2ca-215d2b1d8fd2@perex.cz>
References: <5ba9c647.1c69fb81.1df8f.531b@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 52BC1267892
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2018 10:00:34 +0200 (CEST)
In-Reply-To: <5ba9c647.1c69fb81.1df8f.531b@mx.google.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: plevine457@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Applied. Thanks.

Dne 25.9.2018 v 07:22 plevine457@gmail.com napsal(a):
> From: Peter Levine <plevine457@gmail.com>
> 
> Signed-off-by: Peter Levine <plevine457@gmail.com>
> 
> diff --git a/configure.ac b/configure.ac
> index 3e2d233..cc3740b 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -90,7 +90,7 @@ if test "$use_maemo_rm" = "yes"; then
>  fi
>  
>  AC_ARG_ENABLE([libav],
> -      AS_HELP_STRING([--disable-avlib], [Do not build plugins depending on libav/ffmpeg (a52,lavrate...)]))
> +      AS_HELP_STRING([--disable-libav], [Do not build plugins depending on libav/ffmpeg (a52,lavrate...)]))
>  
>  if test "x$enable_libav" != "xno"; then
>    PKG_CHECK_MODULES(LIBAV, [libavcodec libavutil libavresample], [HAVE_LIBAV=yes], [HAVE_LIBAV=no])
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
