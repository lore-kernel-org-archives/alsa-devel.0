From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 6/6] ASoC: omap-dmic: Cleanup the probe
	function
Date: Thu, 11 Jul 2013 14:31:21 +0200
Message-ID: <51DEA599.6030205@ti.com>
References: <1373537930-10467-1-git-send-email-peter.ujfalusi@ti.com>
 <1373537930-10467-7-git-send-email-peter.ujfalusi@ti.com>
 <51DE928A.4090402@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 498952657DD
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 14:31:25 +0200 (CEST)
In-Reply-To: <51DE928A.4090402@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 07/11/2013 01:10 PM, Lars-Peter Clausen wrote:
> On 07/11/2013 12:18 PM, Peter Ujfalusi wrote:
>> Move the clk_get later in the function. In this way we do not need to use
>> goto in other error cases.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> =

> How about using devm_clk_get?

I tend to forgot about the devm_* time to time ;)

-- =

P=E9ter
