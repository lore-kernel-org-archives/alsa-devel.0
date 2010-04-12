From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.34
Date: Mon, 12 Apr 2010 16:33:21 +0100
Message-ID: <eqib47j8js6sy9pv0e2bpbmx.1271086199105@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BDC2724645
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Apr 2010 17:33:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam@alsa-project.org, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Apologies for the quoting - I'm replying from my phone. I think in terms of code quality it'd be fine for stable but since it introduces an incompatible API change it's really a no go for the default stable release - any out of tree users would be broken by it which would be bad. It might be worth suggesting somewhere to publish them - if I get a chance I'll probably post something to my blog which should get good Google juice.

Daniel Mack <daniel@caiaq.de> wrote:

>On Mon, Apr 05, 2010 at 07:38:40PM +0100, Mark Brown wrote:
>> The following changes since commit fb48e3c6a4d8888aff61fbf567aadac7d206e973:
>>   Graham Gower (1):
>>         ASoC: Fix passing platform_data to ac97 bus users and fix a leak
>> 
>> are available in the git repository at:
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34
>> 
>> This is rather large for a stable update due to the inclusion of
>> Daniel's backported fix for corruption of DMA data due to use of
>> dma_data by both capture and playback streams (which is large but
>> straightforward)
>
>Do you think it is safe to push this ASoC-DMA patch to stable@ as well?
>I posted backported version already and I believe they're fine.
>
>Thanks,
>Daniel
>
