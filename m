From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/1] ASoC: soc-core: check rate for
 symmetry only when pcm is active
Date: Wed, 24 Aug 2011 19:05:35 +0200
Message-ID: <4E552F5F.9070801@metafoo.de>
References: <1314183728-23627-1-git-send-email-b29396@freescale.com>
	<4E5520CE.60204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 36CC4103815
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 19:06:12 +0200 (CEST)
In-Reply-To: <4E5520CE.60204@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, Dong Aisheng <b29396@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 08/24/2011 06:03 PM, Liam Girdwood wrote:
> On 24/08/11 12:02, Dong Aisheng wrote:
>> For the playback and record using different dai links,
>> checking !rtd->rate for symmetry may not be accurate because that
>> pcm may be acutually not running and the default new open rate is 0,
>> then the warning message "Not enforcing symmetric_rates" will
>> happen each time with running arecord | aplay.
>>
>> Now we only check rate for symmetry when the pcm is really active
>> which seems more sensible.
>>
>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Cc: Liam Girdwood <lrg@ti.com>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Acked-by: Liam Girdwood <lrg@ti.com>
> 

I don't think the patch in it's current form is a good idea. All it does is
silencing the warning instead of addressing the real issue. The issue at hand
here is, that the same DAI is connected to two other DAIs and the thus shared
between two PCMs. The shared DAI requires symmetric rates. This is something
that is not covered by the current code, since it assumes that a DAI is not
shared between different PCMs. So with this patch the warning will be gone, but
it is still possible that the capture and playback stream of the DAI to be
configured to run at different rates, which will obviously unwanted behavior.

A more sensible solution would in my opinion be to save the current rate in the
dai struct itself and not in the pcm struct. Upon opening a stream check for
cpu and codec DAI whether they require symmetry. If they do and are active
constraint the rate to DAIs rate. This also ensures that if boths DAIs are
already active and are running at different rates there will be no valid rate
for the new stream.
