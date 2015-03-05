From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [ALSA-LIB][PATCH] Add support for compress offload
 API
Date: Thu, 5 Mar 2015 12:23:19 +0530
Message-ID: <20150305065319.GV2613@intel.com>
References: <1425486142-19910-1-git-send-email-qais.yousef@imgtec.com>
 <54F787CF.1030804@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D900A2652DB
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 07:56:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <54F787CF.1030804@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Qais Yousef <qais.yousef@imgtec.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2015 at 04:31:43PM -0600, Pierre-Louis Bossart wrote:
> I am no lawyer but I think there is work to do on the license and
> copyright parts, see below.
> -Pierre
> 
> On 3/4/15 10:22 AM, Qais Yousef wrote:
> >Merge tinycompress library into alsa-lib using LGPL license.
> >Only function names were modified to match the coding style in alsa-lib,
> >prepending snd_compr to function names and structs.
> >
> >Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
> >Cc: Takashi Iwai <tiwai@suse.de>
> >Cc: Vinod Koul <vinod.koul@intel.com>
> >Cc: Mark Brown <broonie@kernel.org>
> >---
> >  configure.ac                     |   9 +
> >  include/Makefile.am              |   4 +
> >  include/compress.h               | 245 ++++++++++++++++
> >  include/sound/compress_offload.h | 191 +++++++++++++
> >  include/sound/compress_params.h  | 404 ++++++++++++++++++++++++++
> >  src/Makefile.am                  |   7 +
> >  src/compress/Makefile.am         |   8 +
> >  src/compress/compress.c          | 599 +++++++++++++++++++++++++++++++++++++++
> >  8 files changed, 1467 insertions(+)
> >  create mode 100644 include/compress.h
> >  create mode 100644 include/sound/compress_offload.h
> >  create mode 100644 include/sound/compress_params.h
> >  create mode 100644 src/compress/Makefile.am
> >  create mode 100644 src/compress/compress.c
> >
> >diff --git a/configure.ac b/configure.ac
> >index f0995e3ae787..a768730781e0 100644
> >--- a/configure.ac
> >+++ b/configure.ac
> >@@ -368,6 +368,9 @@ AC_ARG_ENABLE(mixer,
> >  AC_ARG_ENABLE(pcm,
> >    AS_HELP_STRING([--disable-pcm], [disable the PCM component]),
> >    [build_pcm="$enableval"], [build_pcm="yes"])
> >+AC_ARG_ENABLE(compress,
> >+  AS_HELP_STRING([--disable-compress], [disable the compress component]),
> >+  [build_compress="$enableval"], [build_compress="yes"])
> >  AC_ARG_ENABLE(rawmidi,
> >    AS_HELP_STRING([--disable-rawmidi], [disable the raw MIDI component]),
> >    [build_rawmidi="$enableval"], [build_rawmidi="yes"])
> >@@ -418,6 +421,7 @@ AC_SUBST(PYTHON_INCLUDES)
> >
> >  AM_CONDITIONAL([BUILD_MIXER], [test x$build_mixer = xyes])
> >  AM_CONDITIONAL([BUILD_PCM], [test x$build_pcm = xyes])
> >+AM_CONDITIONAL([BUILD_COMPRESS], [test x$build_compress = xyes])
> >  AM_CONDITIONAL([BUILD_RAWMIDI], [test x$build_rawmidi = xyes])
> >  AM_CONDITIONAL([BUILD_HWDEP], [test x$build_hwdep = xyes])
> >  AM_CONDITIONAL([BUILD_SEQ], [test x$build_seq = xyes])
> >@@ -431,6 +435,9 @@ fi
> >  if test "$build_pcm" = "yes"; then
> >    AC_DEFINE([BUILD_PCM], "1", [Build PCM component])
> >  fi
> >+if test "$build_compress" = "yes"; then
> >+  AC_DEFINE([BUILD_COMPRESS], "1", [Build compress component])
> >+fi
> >  if test "$build_rawmidi" = "yes"; then
> >    AC_DEFINE([BUILD_RAWMIDI], "1", [Build raw MIDI component])
> >  fi
> >@@ -641,6 +648,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
> >  	  include/Makefile include/sound/Makefile src/Versions src/Makefile \
> >            src/control/Makefile src/mixer/Makefile \
> >  	  src/pcm/Makefile src/pcm/scopes/Makefile \
> >+	  src/compress/Makefile \
> >  	  src/rawmidi/Makefile src/timer/Makefile \
> >            src/hwdep/Makefile src/seq/Makefile src/ucm/Makefile \
> >            src/alisp/Makefile \
> >@@ -693,6 +701,7 @@ cat >> include/asoundlib.h <<EOF
> >  #include <alsa/conf.h>
> >  EOF
> >  test "$build_pcm" = "yes" && echo "#include <alsa/pcm.h>" >> include/asoundlib.h
> >+test "$build_compress" = "yes" && echo "#include <alsa/compress.h>" >> include/asoundlib.h
> >  test "$build_rawmidi" = "yes" && echo "#include <alsa/rawmidi.h>" >> include/asoundlib.h
> >  test "$build_pcm" = "yes" && echo "#include <alsa/timer.h>" >> include/asoundlib.h
> >  test "$build_hwdep" = "yes" && echo "#include <alsa/hwdep.h>" >> include/asoundlib.h
> >diff --git a/include/Makefile.am b/include/Makefile.am
> >index 4baa03af69e1..395a2ed60d70 100644
> >--- a/include/Makefile.am
> >+++ b/include/Makefile.am
> >@@ -30,6 +30,10 @@ alsainclude_HEADERS += pcm_ioplug.h
> >  endif
> >  endif
> >
> >+if BUILD_COMPRESS
> >+alsainclude_HEADERS += compress.h
> >+endif
> >+
> >  if BUILD_RAWMIDI
> >  alsainclude_HEADERS += rawmidi.h
> >  endif
> >diff --git a/include/compress.h b/include/compress.h
> >new file mode 100644
> >index 000000000000..250ce0c3f7c4
> >--- /dev/null
> >+++ b/include/compress.h
> >@@ -0,0 +1,245 @@
> >+/*
> >+ * tinycompress library for compress audio offload in alsa
> >+ * Copyright (c) 2011-2012, Intel Corporation.
> >+ *
> >+ *
> >+ * This program is free software; you can redistribute it and/or modify it
> >+ * under the terms and conditions of the GNU Lesser General Public License,
> >+ * version 2.1, as published by the Free Software Foundation.
> >+ *
> >+ * This program is distributed in the hope it will be useful, but WITHOUT
> >+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> >+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
> >+ * License for more details.
> 
> It looks like this is pulled from
> tinycompress/include/tinycompress/tinycompress.h, which was released
> with a dual BSD and LGPL license. I wonder if you can remove the BSD
> license really? At the very least you should make it clear where
> this code came from.
apart for legal stuff, we have another issue of having two versions which
will lead to mainatince cost

I was thinking that we can add support in alsa lib for tinycompress by
pulling the git as part of this project, so that alsa gets latest code
always and we can use single repostory for android and linux distros



> >+ *  compress_offload.h - compress offload header definations
> >+ *
> >+ *  Copyright (C) 2011 Intel Corporation
> >+ *  Authors:	Vinod Koul <vinod.koul@linux.intel.com>
> >+ *		Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >+ *
> >+ *  This program is free software; you can redistribute it and/or modify
> >+ *  it under the terms of the GNU General Public License as published by
> >+ *  the Free Software Foundation; version 2 of the License.
> 
> So this one is pulled form the kernel and with GPL, not LGPL. Whoa.
One should use *installed headers*, are these installed ones or copied from
kernel?

-- 
~Vinod
