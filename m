From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: looping S/PDIF data
Date: Mon, 30 Jun 2008 20:21:09 +0200
Message-ID: <48692415.3070204@keyaccess.nl>
References: <20080531112606.5884a1c9@mjolnir.drzeus.cx>	<20080617215504.3203a5ed@mjolnir.drzeus.cx>	<4858B84B.4030800@keyaccess.nl>	<s5hej6t91u1.wl%tiwai@suse.de>	<Pine.LNX.4.61.0806191435270.1798@tm8103-a.perex-int.cz>	<s5hskv97fqk.wl%tiwai@suse.de>	<20080620214516.28e9d3f3@mjolnir.drzeus.cx>	<485C0A97.7020909@keyaccess.nl>	<20080621000050.43160d47@mjolnir.drzeus.cx>	<485C2DF7.7080408@keyaccess.nl>	<20080621010910.018f880d@mjolnir.drzeus.cx>	<485CF0AE.3020204@keyaccess.nl>
	<20080630191133.7f7c349d@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 77D8624727
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Jun 2008 20:20:06 +0200 (CEST)
In-Reply-To: <20080630191133.7f7c349d@mjolnir.drzeus.cx>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, mulix@mulix.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 30-06-08 19:11, Pierre Ossman wrote:

> On Sat, 21 Jun 2008 14:14:38 +0200
> Rene Herman <rene.herman@keyaccess.nl> wrote:
> 
>> On 21-06-08 01:09, Pierre Ossman wrote:
>>
>>> trident: pause s/pdif output
>>>
>>> Stop the S/PDIF DMA engine and output when the device is told to pause.
>>> It will keep on looping the current buffer contents if this isn't done.
>>>
>>> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
>> Verified to fix the reported pause problem on a 4DWaveNX (and indeed to 
>> not affect a 4DWaveDX). The Trident SPDIF doesn't seem capable of 44100 
>> which for me means it's not all that useful but you no doubt know 
>> yourself that/if it is for you...
>>
>> Tested-by: Rene Herman <rene.herman@gmail.com>
> 
> 
> Sooo.... ack? nak? limbo?

... come on shake your body baby, do the limbo, I know ...

Your fix is commit f19a62ecba9d0963cee2b673f0ad34917b5e57ad in the 
"sound-2.6" git repo (Takashi Iwai's tree), branch "master", at

git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

also viewable at:

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commit;h=f19a62ecba9d0963cee2b673f0ad34917b5e57ad

That commit is pre the 1.0.17-rc3 release/tag so it's in. Will find its 
way into the kernel during the next merge window no doubt...

Rene.
