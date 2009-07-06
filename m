From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: davinci-i2c,pcm updates
Date: Mon, 06 Jul 2009 14:30:21 -0700
Message-ID: <4A526CED.7050606@boundarydevices.com>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
	<20090705114122.GA5334@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth00.csee.onr.siteprotect.com
	(smtpauth00.csee.onr.siteprotect.com [64.26.60.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BF1B2452C
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jul 2009 23:30:32 +0200 (CEST)
In-Reply-To: <20090705114122.GA5334@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: khilman@deeprootsystems.com, Chaithrika U S <chaithrika@ti.com>, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Sat, Jul 04, 2009 at 07:29:50PM -0700, Troy Kisky wrote:
>> This patch set is against git://git.alsa-project.org/alsa-kernel.git
> 
> Best to use
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
> 
> or
> 	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git
> 
>> but the last patch in series won't compile until the sram allocator patch
>> is available.
> 
> I've not reviewed or checked the code yet but it's likely to collide
> with the updates which Chaithrika U S did to add support for some newer
> processors.  Those are still sitting unmerged on the davinci branch of
> my git since I've not heard anything about the arch/arm changes for the
> clocks that they depend on.  The last thing I saw was a query from Kevin
> about the use of plain names.
> 
> Could you give a pointer to the SRAM allocator patch, please?
> 
Your for-2.6.32 branch has the file arch/arm/mach-davinci/include/mach/sram.h
so it has the patch.

But I also rely on patch from davinci-git
commit 09f6541323bd216f3661385ce26819a4c65cbae6
Author: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Date:   Thu May 21 07:41:40 2009 -0400

ARM: DaVinci: Interface changes visible to EDMA clients



But the last patch in series needs rebased on to this. Unfortunately,
this patch is not yet in your for-2.6.32 branch. So, unless this patch
is going to merge first, I show remove the need for this patch???


Thanks
Troy
