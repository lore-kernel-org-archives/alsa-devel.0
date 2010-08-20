From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] alsa-driver-build/Makefile: Support
 CONFIG_SND_KERNELDIR
Date: Fri, 20 Aug 2010 22:03:12 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008202202030.10278@eeebox2.perex-int.cz>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FE37665B@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 38DD824454
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 22:03:13 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF02FE37665B@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 20 Aug 2010, Stephen Warren wrote:

> Some kernels define CONFIG_SND_KERNELDIR rather than CONFIG_SND_KERNELBUILD.
> If the latter is not set, then use the former.
>
> Signed-off-by: Stephen Warren <swarren@swarren-lx2.nvidia.com>
> ---
> Makefile |    6 ++++++
> 1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9af188f..59c477c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -157,6 +157,12 @@ all-deps: toplevel.config.in acinclude.m4 include/config1.h.in
> include/sndversions.h:
> 	$(MAKE) dep
>
> +ifdef NEW_KBUILD
> +  ifeq ("$(CONFIG_SND_KERNELBUILD)", "")
> +    override CONFIG_SND_KERNELBUILD := $(CONFIG_SND_KERNELDIR)
> +  endif
> +endif
> +
> .PHONY: compile
> compile: include/sndversions.h
> ifdef NEW_KBUILD

Thanks. It's better to fix this issue in configure.in:

diff --git a/configure.in b/configure.in
index 18b1440..e94cbe7 100644
--- a/configure.in
+++ b/configure.in
@@ -124,6 +124,9 @@ AC_ARG_WITH(build,
  if test -d "$kernelbuild"; then
    kernelbuild=$(cd "$kernelbuild" && pwd)
  fi
+if test -z "$kernelbuild"; then
+  kernelbuild="$kerneldir"
+fi
  CONFIG_SND_KERNELBUILD="$kernelbuild"
  AC_MSG_RESULT($kernelbuild)

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
