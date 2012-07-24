From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Merging alsa-driver and alsa-kmirror to one GIT
	repo
Date: Tue, 24 Jul 2012 16:29:22 +0200
Message-ID: <500EB142.5030307@perex.cz>
References: <500EA085.8090105@perex.cz> <s5hboj5s2o0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 90A972652A8
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 16:28:37 +0200 (CEST)
In-Reply-To: <s5hboj5s2o0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Date 24.7.2012 15:34, Takashi Iwai wrote:
> At Tue, 24 Jul 2012 15:17:57 +0200,
> Jaroslav Kysela wrote:
>>
>> Hi all,
>>
>> 	I believe, it's time to manage only one GIT repository for the
>> alsa-driver package now. The merge has benefits mainly for the end users
>> - bisecting may work, the correlation between kernel sources and our
>> out-of-kernel build framework becomes more strong.
> 
> The biggest question from my side is how to handle it in future.
> 
> IMHO, the current alsa-driver tree structure isn't in the best form.
> Alternatively, we can change the alsa-driver tree into the standard
> linux-kernel tree form: i.e. linux-kernel plus the extra alsa-driver
> build stubs.  In that way, you can keep the consistency by pulling the
> main kernel part easily into alsa-driver tree if the change in the
> build stub is required.
> 
> Of course, it means some directory changes would be required.  But
> git pull is much saner than cherry-picking each commit to a different
> tree (alsa-kmirror) with directory/path conversions.

Although the git merging features are very good, I do not prefer to
build something on top of this development type. The cross patch
management may reveal also some auto-merge mistakes (I hit few). Also,
working with the whole Linux tree is not necessary for the developement.
I mostly debug things on top of the distro specific kernel. I don't
understand the requirement to fetch 99% of unused code to build the
sound driver for another kernel.

> The downside is that creating a traditional alsa-driver release
> tarball won't be straightforward but need some script.  But it
> shouldn't be too hard.
> 
> 
> Also, the release management of alsa-driver is another question.
> It's pretty obvious that 99% of changes nowadays are in the driver.
> And we are working rather together with the kernel release cycle more
> than the ALSA release.  Thus it's more natural to release the
> alsa-driver along the kernel release cycle.
> 
> That is, we may release alsa-driver-3.5 now containing the same stuff
> for 3.5 kernel but also with the external build stubs.  It no longer
> needs to stick with the old "ALSA version", IMO.  The ALSA version
> is rather confusing for both users and developers since the same
> version appears in the different kernels with pretty different ALSA
> driver codes actually.

Yes, the kernel build-in ALSA version should be changed (to something
like 'k3.5' or removed).

I am not sure, if it's necessary to relate the alsa-driver releases to
the kernel releases. From my perspective, it's just a snapshot, which
may be more tested for the compilation on more different kernels. The
standard ALSA versioning make sense for this, too. Timestamps show the
relationship nicely.

					Jaroslav

>> 	I merged the alsa-driver and alsa-kmirror repos with full history. I
>> also added some code changes to enable the "build-in" mirror tree in
>> Makefile and gitcompile from v1.0.18 (but I don't think that it will be
>> used).
>>
>> 	The structure of new repository is similar, but the kernel mirrored
>> code is located in the mirror/ subdirectory. The paths are exactly same
>> as in the Linux kernel tree, so possible patches can be applied without
>> any path modifications. Of course, we may create a bash script to do
>> proper and full cherry-picks between kernel and mirrored trees
>> (comments, author, dates).
>>
>> 	New temporary repository has name alsa-driver.new:
>>
>> http://git.alsa-project.org/?p=alsa-driver.new.git;a=summary
>>
>> 	The another difference is that the releases are now branches not tags.
>> It allows me to do quick fixes out of the standard development or
>> separate the main development in the release time window (to not include
>> some very new code). The previous branches won't contain probably any
>> additional commits, but it's probably better to play with only one
>> reference scheme.
>>
>> 	I think that the change from alsa-driver.git to alsa-driver.new.git
>> should be quick. Please, report any objections or acks now.
>>
>> 	Schedule: When accepted, I will rename the original alsa-driver.git
>> repository to alsa-driver.old.git and move alsa-driver.new.git to
>> alsa-driver.git quickly.
>>
>> 	1.0.26 release: This was my last big change (with the ALSA server
>> upgrade) which blocked me to do the 1.0.26 release. I'm going to create
>> new release after the repos switch ASAP.
>>
>> 					Jaroslav
>>
>> -- 
>> Jaroslav Kysela <perex@perex.cz>
>> Linux Kernel Sound Maintainer
>> ALSA Project; Red Hat, Inc.
>>


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
