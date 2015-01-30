From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Fix data delay
	configuration
Date: Fri, 30 Jan 2015 19:50:48 +0200
Message-ID: <54CBC478.7080805@bitmer.com>
References: <1422621751-30484-1-git-send-email-peter.ujfalusi@ti.com>
 <20150130125217.GA16659@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 5502026047E
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 18:51:12 +0100 (CET)
In-Reply-To: <20150130125217.GA16659@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 01/30/2015 02:52 PM, Pavel Machek wrote:
> Hi!
> 
>> Fix the issue introduced by:
>> 368494093354 ASoC: tlv320aic3x: Add TDM support
>>
>> The CTRLC register were not receiving the correct delay configuration,
>> which will corrupt DSP_A audio mode.
>>
>> Reported-by: Pavel Machek <pavel@ucw.cz>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Tested-by: Pavel Machek <pavel@ucw.cz>
> 
You could add into v2 (see Takashi's Fixes: tag comment) also my

Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
