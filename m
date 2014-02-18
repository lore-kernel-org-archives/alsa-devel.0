From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: SOC_VALUE_ENUM usages in cs42l52 & cs42l73 drivers
Date: Tue, 18 Feb 2014 11:36:30 -0600
Message-ID: <alpine.DEB.2.02.1402181135380.22940@heelrod>
References: <s5hha7wwdth.wl%tiwai@suse.de>
 <alpine.DEB.2.02.1402181132070.22940@heelrod>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 66FE4261B19
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 18:36:37 +0100 (CET)
In-Reply-To: <alpine.DEB.2.02.1402181132070.22940@heelrod>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

>> Similarly, cs42l73.c has four definitions, but with different masks:
>>
>> 	SOC_VALUE_ENUM_SINGLE(CS42L73_MMIXCTL, 6, 1, ...
>> 	SOC_VALUE_ENUM_SINGLE(CS42L73_MMIXCTL, 4, 3, ...
>> 	SOC_VALUE_ENUM_SINGLE(CS42L73_MMIXCTL, 2, 5, ...
>> 	SOC_VALUE_ENUM_SINGLE(CS42L73_MMIXCTL, 0, 7, ...
>> 
The 3rd argument appears to line up with the register offset for each 
block. Don't really know why, but I'll check

Thanks,
Brian
