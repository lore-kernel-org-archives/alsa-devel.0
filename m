From: Liam Girdwood <lrg@ti.com>
Subject: Re: [patch] ASoC: adau1701: signedness bug in
	adau1701_write()
Date: Mon, 20 Jun 2011 15:03:19 +0100
Message-ID: <4DFF5327.40903@ti.com>
References: <20110620071125.GG14591@shale.localdomain>
	<4DFF1AD6.4090103@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id CA988244A0
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 16:03:23 +0200 (CEST)
In-Reply-To: <4DFF1AD6.4090103@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "open list:SOUND - SOC LAYER..." <alsa-devel@alsa-project.org>, Dan Carpenter <error27@gmail.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 20/06/11 11:03, Lars-Peter Clausen wrote:
> On 06/20/2011 09:11 AM, Dan Carpenter wrote:
>> "ret" is supposed to be signed here.  The current code will only
>> return -EIO on error, instead of a more appropriate error code such
>> as -EAGAIN etc.
>>
>> Signed-off-by: Dan Carpenter <error27@gmail.com>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 

Acked-by: Liam Girdwood <lrg@ti.com>
