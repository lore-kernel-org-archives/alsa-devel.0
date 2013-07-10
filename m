From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v4 2/7] Documentation: DT: add
	sam9x5ek-wm8731 machine driver
Date: Wed, 10 Jul 2013 11:32:42 +0200
Message-ID: <CACQ1gAjxWYVrOM8wvq7emArO7s_bion-ZgnB9tx3DN5htoV2qw@mail.gmail.com>
References: <1373372929-17800-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-3-git-send-email-richard.genoud@gmail.com>
 <20130709150114.GB27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f173.google.com (mail-ie0-f173.google.com
 [209.85.223.173])
 by alsa0.perex.cz (Postfix) with ESMTP id BE07F2656A5
 for <alsa-devel@alsa-project.org>; Wed, 10 Jul 2013 11:33:03 +0200 (CEST)
Received: by mail-ie0-f173.google.com with SMTP id k13so15088116iea.32
 for <alsa-devel@alsa-project.org>; Wed, 10 Jul 2013 02:33:03 -0700 (PDT)
In-Reply-To: <20130709150114.GB27646@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2013/7/9 Mark Brown <broonie@kernel.org>:
> On Tue, Jul 09, 2013 at 04:25:28PM +0200, Richard Genoud wrote:
>> This add the sound DT binding for sam9x5ek-wm8731 machine driver
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> ---
>>  .../bindings/sound/atmel-sam9x5-wm8731-audio.txt   |   30 ++++++++++++++++++++
>
> Put new binding documents in the same patch that reads them, this makes
> review easier.
ok, I'll squash it with patch 1

>> +  - atmel,audio-routing: A list of the connections between audio components.
>
> This needs to be more specific and list the available board specific
> nodes for routing.  For the CODEC you can just refer to the CODEC
> binding documentation.
Ok, I'll do that.

>> +  - atmel,format: DAI format. Must be "i2s"
>
> So why not just omit this then?
Will be removed.

>
>> +  - atmel,bitclock-master:  DAI clock master
>> +  - atmel,frame-master: DAI frame master
>
> The driver isn't handling these and there's no information on how to set
> them.
They will also go away.


Thanks !
