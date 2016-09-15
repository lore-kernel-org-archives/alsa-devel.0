From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] Revert "ASoC: core: mark SND_SOC_BYTES_EXT
	as deprecated"
Date: Fri, 16 Sep 2016 08:26:35 +0900
Message-ID: <042638a1-3881-aec2-6371-599cf2814d56@sakamocchi.jp>
References: <1473947149-6663-1-git-send-email-o-takashi@sakamocchi.jp>
 <20160915142148.GR21682@localhost.localdomain>
 <6357ad44-b194-7dfd-b3e8-938af89f4b54@sakamocchi.jp>
 <20160915145429.GL27974@sirena.org.uk>
 <0d366da8-5683-7633-b4a1-f75973e71e97@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id E63B62666BB
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2016 01:26:40 +0200 (CEST)
In-Reply-To: <0d366da8-5683-7633-b4a1-f75973e71e97@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, vinod.koul@intel.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, clemens@ladisch.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sep 16 2016 07:29, Takashi Sakamoto wrote:
> On Sep 15 2016 23:54, Mark Brown wrote:
>> On Thu, Sep 15, 2016 at 11:41:43PM +0900, Takashi Sakamoto wrote:
>>> On Sep 15 2016 23:21, Charles Keepax wrote:
>>
>>>> Although you might want to resend using Mark's kernel.org address
>>>> as I imagine he would be the one to apply the change and that is
>>>> the address he normally uses for patches.
>>
>>> Oh, he uses the domain instead of linaro.org. I missed it.
>>
>>> Now I add him to CC list.
>>
>> As documented in SubmittingPatches please send patches to the 
>> maintainers for the code you would like to change.  The normal kernel
>> workflow is that people apply patches from their inboxes, if they aren't
>> copied they are likely to not see the patch at all and it is much more
>> difficult to apply patches.
> 
> I see. I'll post this to below addresses.
> 
> $ ./scripts/get_maintainer.pl
> /tmp/patch/0001-Revert-ASoC-core-mark-SND_SOC_BYTES_EXT-as-deprecate.patch
> fatal:
> /tmp/patch/0001-Revert-ASoC-core-mark-SND_SOC_BYTES_EXT-as-deprecate.patch:
> '/tmp/patch/0001-Revert-ASoC-core-mark-SND_SOC_BYTES_EXT-as-deprecate.patch'
> is outside repository
> Liam Girdwood <lgirdwood@gmail.com> (supporter:SOUND - SOC LAYER /
> DYNAMIC AUDIO POWER MANAGEM...)
> Mark Brown <broonie@kernel.org> (supporter:SOUND - SOC LAYER / DYNAMIC
> AUDIO POWER MANAGEM...)
> Jaroslav Kysela <perex@perex.cz> (maintainer:SOUND)
> Takashi Iwai <tiwai@suse.com> (maintainer:SOUND)
> alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
> AUDIO POWER MANAGEM...)
> linux-kernel@vger.kernel.org (open list)

I changed my mind. I just added you to CC list of new patch, then sent
it. Please apply it your tree after reviewing. I don't like to be
involved to the yeast, and dull work.


Regards

Takashi Sakamoto
