From: Stephen Warren <swarren@nvidia.com>
Subject: Re: Building Takashi's sound-2.6.git?
Date: Fri, 20 Aug 2010 13:20:13 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF02FE37668C@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FE376611@HQMAIL01.nvidia.com>
	<s5hsk29conv.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1008201729440.10278@eeebox2.perex-int.cz>
	<74CDBE0F657A3D45AFBB94109FB122FF02FE37665A@HQMAIL01.nvidia.com>
	<alpine.LNX.2.00.1008201833100.10278@eeebox2.perex-int.cz>
	<74CDBE0F657A3D45AFBB94109FB122FF02FE37666D@HQMAIL01.nvidia.com>
	<alpine.LNX.2.00.1008202011380.10278@eeebox2.perex-int.cz>
	<74CDBE0F657A3D45AFBB94109FB122FF02FE376670@HQMAIL01.nvidia.com>
	<alpine.LNX.2.00.1008202134330.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id C61BF1037EA
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 22:20:26 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1008202134330.10278@eeebox2.perex-int.cz>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Jaroslav Kysela' <perex@perex.cz>
Cc: 'Takashi Iwai' <tiwai@suse.de>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> Stephen Warren wrote:
> > Jaroslav Kysela wrote:
> >> Stephen Warren wrote:
> >>> Unfortunately, it doesn't seem to work:
> >>>
> >>> ALSAKERNELDIR=../sound-2.6/sound ./gitcompile
> >>
> >> It should be:
> >>
> >> ALSAKERNELDIR=../sound-2.6 ./gitcompile
> >
> > sound-2.6 is a complete Linux kernel tree, not just the ALSA drivers.
> > Hence, the second part of the following test fails, because last.c is in
> > ../sound-2.6/sound/last.c not ../sound-2.6/last.c
> >
> > if [ ! -d $ALSAKERNELDIR -o ! -f $ALSAKERNELDIR/last.c ]; then
> >    echo "No alsa-kmirror is found."
> 
> You're right. But the Makefile accepts both trees. This patch should solve
> this issue:

OK, that patch works OK, but I actually ended up getting the exact same issue.

make[3]: Warning: File `.includes' has modification time 0.04 s in the future
cp ../../alsa-kernel/include/*.h .
cp: cannot stat `../../alsa-kernel/include/*.h': No such file or directory

I looked into that further this time, and I found it's because
alsa-driver-build/alsa-kernel/include points at ../sound-2.6/include/sound,
but should have an extra "../" on the front. Doing the following fixes this:

ALSAKERNELDIR=`cd ../sound-2.6 && pwd` ./gitcompile

Doesn't this affect the ../alsa-kmirror case too? Perhaps everyone who checks
out alsa-kmirror places it inside the alsa-driver-build directory, or symlinks
it themselves first?

Perhaps gitcompile can add the following right before the make:

ALSAKERNELDIR=`cd ${ALSAKERNELDIR} && pwd`

But I'm not familiar enough with all configurations people use this in to
know whether that would break anything.

If that's OK, the final patch might be as below; it Works For Me.

diff --git a/gitcompile b/gitcompile
index b845fd8..57e56e2 100755
--- a/gitcompile
+++ b/gitcompile
@@ -28,18 +28,22 @@ fi
 #fi
 
 # check for alsa-kmirror directory
-if [ -d alsa-kernel -a -f alsa-kernel/last.c ]; then
+if [ -d alsa-kernel -a -f alsa-kernel/sound/last.c ]; then
   ALSAKERNELDIR="alsa-kernel"
 elif [ -d alsa-kmirror -a -f alsa-kmirror/last.c ]; then
   ALSAKERNELDIR="alsa-kmirror"
 else
-  test -z $ALSAKERNELDIR && ALSAKERNELDIR=../alsa-kmirror
-  if [ ! -d $ALSAKERNELDIR -o ! -f $ALSAKERNELDIR/last.c ]; then
-    echo "No alsa-kmirror is found."
-    echo "Please specify the correct location via ALSAKERNELDIR environment variable."
-    exit 1
+  test -z $ALSAKERNELDIR && [ -d ../alsa-kmirror ] && ALSAKERNELDIR=../alsa-kmirror
+  test -z $ALSAKERNELDIR && [ -d ../sound-2.6 ] && ALSAKERNELDIR=../sound-2.6
+  if [ ! -d "$ALSAKERNELDIR" -o ! -f "$ALSAKERNELDIR/last.c" ]; then
+    if [ ! -f "$ALSAKERNELDIR/sound/last.c" ]; then
+      echo "No alsa-kmirror or alsa-kernel tree is found."
+      echo "Please specify the correct location via ALSAKERNELDIR environment variable."
+      exit 1
+    fi
   fi
 fi
+ALSAKERNELDIR=`cd ${ALSAKERNELDIR} && pwd`
 make ALSAKERNELDIR="$ALSAKERNELDIR" all-deps || exit 1
 aclocal $ACLOCAL_FLAGS || exit 1
 autoconf || exit 1

-- 
nvpublic
