From: jiwang <jiada_wang@mentor.com>
Subject: Re: question about two ASoC commits
Date: Wed, 10 Sep 2014 14:17:50 +0900
Message-ID: <540FDEFE.5000600@mentor.com>
References: <540EBC14.6090002@mentor.com> <20140909101954.GO2601@sirena.org.uk>
 <857E9EDCA6C0904DB3357321AA9123EBE61DF1E9@NA-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C29D26172C
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 07:17:55 +0200 (CEST)
In-Reply-To: <857E9EDCA6C0904DB3357321AA9123EBE61DF1E9@NA-MBX-01.mgc.mentorg.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, broonie@kernel.org, tiwai@suse.de, perex@perex.cz, Joshua_Frkuska@mentor.com
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark

From: Mark Brown [mailto:broonie@kernel.org] Sent: Tuesday, September 
09, 2014 7:20 PM To: Wang, Jiada (ESD) Cc: Liam Girdwood; Jaroslav 
Kysela; Takashi Iwai; Frkuska, Joshua; alsa-devel@alsa-project.org; 
linux-kernel@vger.kernel.org Subject: Re: question about two ASoC 
commits On Tue, Sep 09, 2014 at 05:36:36PM +0900, jiwang wrote:
>> Can anyone tell me what is the reasoning of the following two commits
>> commit: 5d16333 ASoC: SND_SOC_DAIFMT_NB_NF become 0 as default
>> settings
>> commit: eef28e1 ASoC: SND_SOC_DAIFMT_GATED become 0 as default
>> settings
>> with these two commits, now we have
>> #define SND_SOC_DAIFMT_GATED            (0 << 4)
>> #define SND_SOC_DAIFMT_NB_NF            (0 << 8)
>> in soc-dai.h
>> what's the good to shift 0 with different numbers?
>> no matter the number, they both equal to 0.
>> IMO all bit flags which share same variable (in this case
>> SND_SOC_DAIFMT) should have different value, isn't it?
> As the commit message says this is so that we have a default value which does something sensible.
Yes I can read this from commit message,
But I am not very sure why not initialize dai format variable in driver 
itself.

further more, by having

commit: 5d16333 ASoC: SND_SOC_DAIFMT_NB_NF become 0 as default

DAI hardware signal inversions Macros are declared as following
#define SND_SOC_DAIFMT_NB_NF            (0 << 8) /* normal bit clock + frame */
#define SND_SOC_DAIFMT_NB_IF            (2 << 8) /* normal BCLK + inv FRM */
#define SND_SOC_DAIFMT_IB_NF            (3 << 8) /* invert BCLK + nor FRM */
#define SND_SOC_DAIFMT_IB_IF            (4 << 8) /* invert BCLK + FRM */

Now we are having undefined hole between NB_NF and NB_IF,
don't you think it's better to shift all the others down by 1, to keep them coherent?
so that when new mode (although it's likely there won't be) needs to be added,
it can be appended to the last,otherwise it may cause confuse, either to choose (1 << 8)
or (5 << 8)


Thanks,
Jiada
