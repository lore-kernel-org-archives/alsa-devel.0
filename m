From: Stephen Warren <swarren@nvidia.com>
Subject: Re: Building Takashi's sound-2.6.git?
Date: Fri, 20 Aug 2010 09:05:01 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF02FE37665A@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FE376611@HQMAIL01.nvidia.com>
	<s5hsk29conv.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1008201729440.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id D0D922454E
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 18:05:11 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1008201729440.10278@eeebox2.perex-int.cz>
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
To: 'Jaroslav Kysela' <perex@perex.cz>, 'Takashi Iwai' <tiwai@suse.de>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> On Fri, 20 Aug 2010, Takashi Iwai wrote:
> 
> > At Thu, 19 Aug 2010 15:04:03 -0700,
> > Stephen Warren wrote:
> >>
> >> I'd like to use/develop-against/patch the ALSA drivers from:
> >> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> >> ...
> >> ... However, I can't see how to
> >> get gitcompile from there to build the sound subset of a complete kernel
> >> tree rather than e.g. something like:
> >
> > See alsa-driver/INSTALL, "Compilation from Linux kernel tree" section.
> > In short, run utils/setup-alsa-kernel $YOUR_SOUND_GIT_TREE_APATH
> > then gitcompile can be used.
> 
> It's not required. The alsa-driver/Makefile handles both alsa-kmirror and
> alsa-kernel trees now.

When I check out Takashi's sound-2.6 tree, am I suppose to explicitly
specify the checkout directory so that it's named alsa-kmirror now instead
of sound-2.6; the git-compile script doesn't check for the name sound-2.6.
Should the following be updated to search for more names:

test -z $ALSAKERNELDIR && ALSAKERNELDIR=../alsa-kmirror

... or is it assumed people will always set ALSAKERNELDIR?

Back to my original question: I did see the documentation regarding
utils/setup-alsa-kernel that Takashi mentioned. However, I was put off
trying that because it says:

	If you have the linux kernel tree containing the corresponding ALSA
	kernel codes (the version must match)

and I assumed that meant the version of the kernel source tree that
setup-alsa-kernel was to be used against must match the kernel version
actually being run, whereas I wanted to keep my old distro kernel and build
the ALSA drivers from a much later kernel.

However, that doesn't seem to be the case; I grabbed Takashi's latest
sound-2.6 and build against Ubuntu Karmic's 2.6.31-22-generic just fine. In
the text I quoted, does it instead mean that the kernel source tree and
alsa-driver-build checkouts must match. If so, I can whip up a patch to make
that a little clearer to me at least!

Thanks very much for the help.

-- 
nvpublic
