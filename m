From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Building Takashi's sound-2.6.git?
Date: Fri, 20 Aug 2010 17:33:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008201729440.10278@eeebox2.perex-int.cz>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FE376611@HQMAIL01.nvidia.com>
	<s5hsk29conv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id EA3A01038F6
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 17:33:58 +0200 (CEST)
In-Reply-To: <s5hsk29conv.wl%tiwai@suse.de>
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
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 20 Aug 2010, Takashi Iwai wrote:

> At Thu, 19 Aug 2010 15:04:03 -0700,
> Stephen Warren wrote:
>>
>> I'd like to use/develop-against/patch the ALSA drivers from:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>>
>> ... since I think they're the most up-to-date with patches?
>>
>> However, that's a complete kernel tree rather than the subset that's
>> available in snapshots at:
>>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/alsa/alsa-driver/
>>
>> I figured I could just grab the above git, and also:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/alsa-driver-build.git
>>
>> ... to build just the ALSA driver modules. However, I can't see how to
>> get gitcompile from there to build the sound subset of a complete kernel
>> tree rather than e.g. something like:
>>
>> http://git.alsa-project.org/?p=alsa-driver.git;a=summary
>>
>> Can somebody give me a clue? Thanks very much.
>
> See alsa-driver/INSTALL, "Compilation from Linux kernel tree" section.
> In short, run utils/setup-alsa-kernel $YOUR_SOUND_GIT_TREE_APATH
> then gitcompile can be used.

It's not required. The alsa-driver/Makefile handles both alsa-kmirror and 
alsa-kernel trees now.

Does anyone use the 'copy' mode of the setup-alsa-kernel script?

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
