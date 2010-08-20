From: Stephen Warren <swarren@nvidia.com>
Subject: Re: Building Takashi's sound-2.6.git?
Date: Fri, 20 Aug 2010 11:05:29 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF02FE37666D@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FE376611@HQMAIL01.nvidia.com>
	<s5hsk29conv.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1008201729440.10278@eeebox2.perex-int.cz>
	<74CDBE0F657A3D45AFBB94109FB122FF02FE37665A@HQMAIL01.nvidia.com>
	<alpine.LNX.2.00.1008201833100.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id A52FD243BE
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 20:05:41 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1008201833100.10278@eeebox2.perex-int.cz>
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
> 
> On Fri, 20 Aug 2010, Stephen Warren wrote:
> 
> > Jaroslav Kysela wrote:
> >>
> >> On Fri, 20 Aug 2010, Takashi Iwai wrote:
> >>
> >>> At Thu, 19 Aug 2010 15:04:03 -0700,
> >>> Stephen Warren wrote:
> >>>>
> >>>> I'd like to use/develop-against/patch the ALSA drivers from:
> >>>> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> >>>> ...
> >>>> ... However, I can't see how to
> >>>> get gitcompile from there to build the sound subset of a complete kernel
> >>>> tree rather than e.g. something like:
> >>>
> >>> See alsa-driver/INSTALL, "Compilation from Linux kernel tree" section.
> >>> In short, run utils/setup-alsa-kernel $YOUR_SOUND_GIT_TREE_APATH
> >>> then gitcompile can be used.
> >>
> >> It's not required. The alsa-driver/Makefile handles both alsa-kmirror and
> >> alsa-kernel trees now.
> >
> > When I check out Takashi's sound-2.6 tree, am I suppose to explicitly
> > specify the checkout directory so that it's named alsa-kmirror now instead
> > of sound-2.6; the git-compile script doesn't check for the name sound-2.6.
> > Should the following be updated to search for more names:
> >
> > test -z $ALSAKERNELDIR && ALSAKERNELDIR=../alsa-kmirror
> 
> If you like, send a patch to gitcompile to check for sound-2.6 directory
> as well. I'm using different naming (alsa-kernel), so the gitcompile
> script checks for alsa-kernel and alsa-kmirror trees.

Unfortunately, it doesn't seem to work:

ALSAKERNELDIR=../sound-2.6/sound ./gitcompile

Yields:

make[3]: Entering directory `/home/swarren/shared/git_wa/ktest/alsa-driver-build/include/sound'
cp ../../alsa-kernel/include/*.h .
cp: cannot stat `../../alsa-kernel/include/*.h': No such file or directory
make[3]: *** [*.h] Error 1

It looks like this path isn't tested?

Anyway, now that I know that utils/setup-alsa-kernel works, I guess I'll just
use that.

-- 
nvpublic
