From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/2] ASoC: tlv320aic3x: Fix
 snd_soc_dapm_put_volsw_aic3x callback
Date: Wed, 28 May 2014 09:27:03 +0200
Message-ID: <53858FC7.5020407@metafoo.de>
References: <1401187986-11059-1-git-send-email-peter.ujfalusi@ti.com>
 <20140527110259.GM12304@sirena.org.uk> <53848D66.1050204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-170.synserver.de (smtp-out-170.synserver.de
 [212.40.185.170])
 by alsa0.perex.cz (Postfix) with ESMTP id E79B2265629
 for <alsa-devel@alsa-project.org>; Wed, 28 May 2014 09:27:03 +0200 (CEST)
In-Reply-To: <53848D66.1050204@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/27/2014 03:04 PM, Peter Ujfalusi wrote:
> Mark,
>
> On 05/27/2014 02:02 PM, Mark Brown wrote:
>> On Tue, May 27, 2014 at 01:53:04PM +0300, Peter Ujfalusi wrote:
>>> Hi,
>>>
>>> Commit "cf7c1de20c576 ASoC: dapm: Move 'value' field from widget to
>>> control" changed the way how the 'value' has been stored for a widget.
>>> This resulted issues with codec drivers needing and using custom dapm put
>>> callbacks to handle the hw underneath, like the tlv320aic3x driver.
>>> Since the driver is not updated following the mentioned commit it is mostly
>>> broken when we try to change Left/Righ PGA mixers:
>>
>> Applied both, thanks.
>
> After discussing this with Lars over the IRC, would it be possible to drop
> these patches? I'll come back with another set to fix this issue tomorrow.


After giving some more though to the discussion from yesterday I think it is 
best to just find out why snd_soc_test_bits() returns -EINVAL and fix that 
and leave the rest as it is for now. Moving dapm_kcontrol_set_value() around 
is a bit more complicated than I thought.

- Lars
