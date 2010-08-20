From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Building Takashi's sound-2.6.git?
Date: Fri, 20 Aug 2010 08:02:49 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008200758540.10278@eeebox2.perex-int.cz>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FE376611@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F503244B2
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 08:02:50 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF02FE376611@HQMAIL01.nvidia.com>
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

On Thu, 19 Aug 2010, Stephen Warren wrote:

> I'd like to use/develop-against/patch the ALSA drivers from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>
> ... since I think they're the most up-to-date with patches?
>
> However, that's a complete kernel tree rather than the subset that's
> available in snapshots at:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/alsa/alsa-driver/
>
> I figured I could just grab the above git, and also:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/alsa-driver-build.git
>
> ... to build just the ALSA driver modules. However, I can't see how to
> get gitcompile from there to build the sound subset of a complete kernel
> tree rather than e.g. something like:
>
> http://git.alsa-project.org/?p=alsa-driver.git;a=summary
>
> Can somebody give me a clue? Thanks very much.
>
> (I guess I could just build the entire kernel, but that's a lot more time
> than just the audio modules)

You may just create this tree from git repos (do not mix the sources):

alsa/alsa-driver (the alsa-driver.git tree from git.alsa-project.org or
 		  Takashi's tree from git.kernel.org)
alsa/alsa-kernel (the alsa-kernel.git tree from git.alsa-project.org or
                   Takashi's tree from git.kernel.org)

and do:

cd alsa/alsa-driver
./gitcompile

The script should automatically detect the linux-2.6 tree and do 
the out-of-kernel compilation.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
