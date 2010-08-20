From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Building Takashi's sound-2.6.git?
Date: Fri, 20 Aug 2010 18:34:38 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008201833100.10278@eeebox2.perex-int.cz>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FE376611@HQMAIL01.nvidia.com>
	<s5hsk29conv.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1008201729440.10278@eeebox2.perex-int.cz>
	<74CDBE0F657A3D45AFBB94109FB122FF02FE37665A@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id B28942413A
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 18:34:38 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF02FE37665A@HQMAIL01.nvidia.com>
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
>> On Fri, 20 Aug 2010, Takashi Iwai wrote:
>>
>>> At Thu, 19 Aug 2010 15:04:03 -0700,
>>> Stephen Warren wrote:
>>>>
>>>> I'd like to use/develop-against/patch the ALSA drivers from:
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>>>> ...
>>>> ... However, I can't see how to
>>>> get gitcompile from there to build the sound subset of a complete kernel
>>>> tree rather than e.g. something like:
>>>
>>> See alsa-driver/INSTALL, "Compilation from Linux kernel tree" section.
>>> In short, run utils/setup-alsa-kernel $YOUR_SOUND_GIT_TREE_APATH
>>> then gitcompile can be used.
>>
>> It's not required. The alsa-driver/Makefile handles both alsa-kmirror and
>> alsa-kernel trees now.
>
> When I check out Takashi's sound-2.6 tree, am I suppose to explicitly
> specify the checkout directory so that it's named alsa-kmirror now instead
> of sound-2.6; the git-compile script doesn't check for the name sound-2.6.
> Should the following be updated to search for more names:
>
> test -z $ALSAKERNELDIR && ALSAKERNELDIR=../alsa-kmirror

If you like, send a patch to gitcompile to check for sound-2.6 directory 
as well. I'm using different naming (alsa-kernel), so the gitcompile 
script checks for alsa-kernel and alsa-kmirror trees.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
