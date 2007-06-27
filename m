From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: [Pkg-alsa-devel] Bug#430833: libasound2: PCM
	plugin `lfloat'	not built
Date: Wed, 27 Jun 2007 22:16:00 +0200
Message-ID: <20070627201600.GA23639@frodo.home.lxtec.de>
References: <20070627152724.7416.6901.reportbug@ponder.ncipher.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 77E4724520
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2007 22:16:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070627152724.7416.6901.reportbug@ponder.ncipher.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Wooding <mdw@distorted.org.uk>, 430833@bugs.debian.org
Cc: alsa-devel@alsa-project.org, control@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

forwarded 430833 alsa-devel@alsa-project.org

-- 

On Wed, 27 Jun 2007 the mental interface of
Mark Wooding told:

> Package: libasound2
> Version: 1.0.14a-1
> Severity: normal
> Tags: patch
> 
> The PCM plugin `lfloat' isn't compiled into libasound.  In particular,
> this prevents the `plug' plugin from doing linear<->float conversion,
> and in turn this means that hardly any ALSA clients can use the JACK
> plugin from libasound2-plugins, because JACK uses FLOAT_LE format
> throughout.
> 
> The reason for this is quite simple: the configure script is broken!  In
> particular, the sense of the `softfloat' check used to decide whether to
> disable the plugin is wrong!  (That's aside from the question of whether
> it's sensible to fail to build the thing just because it might be slow.)
> 

We should solve this in general. It's not a Debian specific wish so
forwarded upstream.

> 
> Index: alsa-lib-1.0.14a/configure.in
> ===================================================================
> --- alsa-lib-1.0.14a.orig/configure.in  2007-06-27 16:24:58.000000000
> +0100
> +++ alsa-lib-1.0.14a/configure.in       2007-06-27 16:25:19.000000000
> +0100
> @@ -416,7 +416,7 @@
>    build_pcm_share="no"
>  fi
>  
> -if test "$softfloat" != "yes"; then
> +if test "$softfloat" = "yes"; then
>    build_pcm_lfloat="no"
>  fi
>  
> Index: alsa-lib-1.0.14a/configure
> ===================================================================
> --- alsa-lib-1.0.14a.orig/configure     2007-06-27 16:25:23.000000000
> +0100
> +++ alsa-lib-1.0.14a/configure  2007-06-27 16:25:38.000000000 +0100
> @@ -20946,7 +20946,7 @@
>    build_pcm_share="no"
>  fi
>  
> -if test "$softfloat" != "yes"; then
> +if test "$softfloat" = "yes"; then
>    build_pcm_lfloat="no"
>  fi
>  
> 

Elimar


-- 
  Experience is something you don't get until 
  just after you need it!
