From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 6/6] ASoC: samsung: Fix of-node refcount
 unbalance in odroid_audio_probe()
Date: Wed, 20 Feb 2019 12:06:41 +0100
Message-ID: <6c7514f9-f765-82a9-3583-98214a225539@samsung.com>
References: <20190219154652.13644-1-tiwai@suse.de>
 <CGME20190219154757epcas4p2e9cdfcf26df7e5ec39c16ceec964f6d0@epcas4p2.samsung.com>
 <20190219154652.13644-7-tiwai@suse.de>
 <69d7e286-9ae0-71c8-af82-cc5eb4919d16@samsung.com>
 <s5hh8cyhhev.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8CD78F80784
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 12:06:51 +0100 (CET)
In-reply-to: <s5hh8cyhhev.wl-tiwai@suse.de>
Content-language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 2/20/19 11:40, Takashi Iwai wrote:
> On Tue, 19 Feb 2019 17:36:56 +0100, Sylwester Nawrocki wrote:
>> On 2/19/19 16:46, Takashi Iwai wrote:
>>> odroid_audio_probe() leaves of-nodes without unreferenced after use.
>>> Fix it by shuffling some code a bit and add the missing of_node_put()
>>> calls accordingly.

>>> Only compile-tested.  Please review carefully.  Thanks!
>> Thanks for the patch. Current code for 5.1 is a bit different and we 
>> may now need something like:
> 
> Ah thanks, I forgot to follow asoc repo since merging to sound.git
> tree in this regard.
> 
> Care to submit the patch for the latest tree from your side?

Sure, I have just posted the patch for review.

--
Regards,
Sylwester
