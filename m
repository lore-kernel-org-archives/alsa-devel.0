From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Building Takashi's sound-2.6.git?
Date: Fri, 20 Aug 2010 21:37:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008202134330.10278@eeebox2.perex-int.cz>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FE376611@HQMAIL01.nvidia.com>
	<s5hsk29conv.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1008201729440.10278@eeebox2.perex-int.cz>
	<74CDBE0F657A3D45AFBB94109FB122FF02FE37665A@HQMAIL01.nvidia.com>
	<alpine.LNX.2.00.1008201833100.10278@eeebox2.perex-int.cz>
	<74CDBE0F657A3D45AFBB94109FB122FF02FE37666D@HQMAIL01.nvidia.com>
	<alpine.LNX.2.00.1008202011380.10278@eeebox2.perex-int.cz>
	<74CDBE0F657A3D45AFBB94109FB122FF02FE376670@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 420272443A
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 21:37:42 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF02FE376670@HQMAIL01.nvidia.com>
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
Cc: 'Takashi Iwai' <tiwai@suse.de>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 20 Aug 2010, Stephen Warren wrote:

> Jaroslav Kysela wrote:
>>
>> On Fri, 20 Aug 2010, Stephen Warren wrote:
>>
>>> Jaroslav Kysela wrote:
>>>>
>>>> On Fri, 20 Aug 2010, Stephen Warren wrote:
>>>>
>>>>> Jaroslav Kysela wrote:
>>>>>>
>>>>>> On Fri, 20 Aug 2010, Takashi Iwai wrote:
>>>>>>
>>>>>>> At Thu, 19 Aug 2010 15:04:03 -0700,
>>>>>>> Stephen Warren wrote:
>>>>>>>>
>>>>>>>> I'd like to use/develop-against/patch the ALSA drivers from:
>>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>>>>>>>> ...
>>>>>>>> ... However, I can't see how to
>>>>>>>> get gitcompile from there to build the sound subset of a complete kernel
>>>>>>>> tree rather than e.g. something like:
>>>>>>>
>>>>>>> See alsa-driver/INSTALL, "Compilation from Linux kernel tree" section.
>>>>>>> In short, run utils/setup-alsa-kernel $YOUR_SOUND_GIT_TREE_APATH
>>>>>>> then gitcompile can be used.
>>>>>>
>>>>>> It's not required. The alsa-driver/Makefile handles both alsa-kmirror and
>>>>>> alsa-kernel trees now.
>>>>>
>>>>> When I check out Takashi's sound-2.6 tree, am I suppose to explicitly
>>>>> specify the checkout directory so that it's named alsa-kmirror now instead
>>>>> of sound-2.6; the git-compile script doesn't check for the name sound-2.6.
>>>>> Should the following be updated to search for more names:
>>>>>
>>>>> test -z $ALSAKERNELDIR && ALSAKERNELDIR=../alsa-kmirror
>>>>
>>>> If you like, send a patch to gitcompile to check for sound-2.6 directory
>>>> as well. I'm using different naming (alsa-kernel), so the gitcompile
>>>> script checks for alsa-kernel and alsa-kmirror trees.
>>>
>>> Unfortunately, it doesn't seem to work:
>>>
>>> ALSAKERNELDIR=../sound-2.6/sound ./gitcompile
>>
>> It should be:
>>
>> ALSAKERNELDIR=../sound-2.6 ./gitcompile
>
> sound-2.6 is a complete Linux kernel tree, not just the ALSA drivers.
> Hence, the second part of the following test fails, because last.c is in
> ../sound-2.6/sound/last.c not ../sound-2.6/last.c
>
> if [ ! -d $ALSAKERNELDIR -o ! -f $ALSAKERNELDIR/last.c ]; then
>    echo "No alsa-kmirror is found."

You're right. But the Makefile accepts both trees. This patch should solve 
this issue:

diff --git a/gitcompile b/gitcompile
index b845fd8..72f9781 100755
--- a/gitcompile
+++ b/gitcompile
@@ -28,16 +28,18 @@ fi
  #fi

  # check for alsa-kmirror directory
-if [ -d alsa-kernel -a -f alsa-kernel/last.c ]; then
+if [ -d alsa-kernel -a -f alsa-kernel/sound/last.c ]; then
    ALSAKERNELDIR="alsa-kernel"
  elif [ -d alsa-kmirror -a -f alsa-kmirror/last.c ]; then
    ALSAKERNELDIR="alsa-kmirror"
  else
    test -z $ALSAKERNELDIR && ALSAKERNELDIR=../alsa-kmirror
    if [ ! -d $ALSAKERNELDIR -o ! -f $ALSAKERNELDIR/last.c ]; then
-    echo "No alsa-kmirror is found."
-    echo "Please specify the correct location via ALSAKERNELDIR environment variable."
-    exit 1
+    if [ ! -f $ALSAKERNELDIR/sound/last.c ]; then
+      echo "No alsa-kmirror or alsa-kernel tree is found."
+      echo "Please specify the correct location via ALSAKERNELDIR environment variable."
+      exit 1
+    fi
    fi
  fi
  make ALSAKERNELDIR="$ALSAKERNELDIR" all-deps || exit 1

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
