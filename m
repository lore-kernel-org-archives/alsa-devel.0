From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: alsa-lib-1.0.18 doesn't build with
	option	'--with-softfloat'
Date: Wed, 7 Jan 2009 11:01:25 +0000
Message-ID: <20090107110123.GA16772@sirena.org.uk>
References: <da1989290901060152t2ce35849i1da6872552a07754@mail.gmail.com>
	<da1989290901070102k41904cf1pbcb10b228a692ec@mail.gmail.com>
	<s5hk597scct.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 15E8D1037FF
	for <Alsa-devel@alsa-project.org>; Wed,  7 Jan 2009 12:01:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hk597scct.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel@alsa-project.org, Cliff Cai <cliffcai.sh@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 07, 2009 at 10:18:42AM +0100, Takashi Iwai wrote:
> pcm_ladspa.c can't be build without libm, I guess.  This should be
> excluded with the softfload option.  Ditto for alisp.

> How about the patch below?

OpenEmbedded has been carrying the following patch for a while,
cooindcidentally I was actually looking at their ALSA packaging last
night and thinking about pushing this to you - it forces liking with
libm which is more important when using softfloat.

It was written by Henning Heinold <heinold@inf.fu-berlin.de>

Index: alsa-lib-1.0.15/configure.in
===================================================================
--- alsa-lib-1.0.15.orig/configure.in	2007-10-15 10:45:26.000000000 +0200
+++ alsa-lib-1.0.15/configure.in	2008-07-19 15:51:34.177119589 +0200
@@ -191,9 +191,9 @@
   AC_MSG_RESULT(no)
 fi
 
-ALSA_DEPLIBS=""
-if test "$softfloat" != "yes"; then
-  ALSA_DEPLIBS="-lm"
+ALSA_DEPLIBS="-lm"
+if test "$softfloat" = "yes"; then
+   AC_CHECK_LIB([m], [floor], , [ALSA_DEPLIBS=""])
 fi
 
 dnl Check for libdl
