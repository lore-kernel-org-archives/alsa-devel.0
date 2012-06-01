From: MR Swami Reddy <MR.Swami.Reddy@ti.com>
Subject: Re: [PATCH RESEND] ASoC: Support TI Isabelle Audio
	driver
Date: Fri, 1 Jun 2012 17:54:22 +0530
Message-ID: <4FC8B476.4030305@ti.com>
References: <1338289786-2751-1-git-send-email-MR.Swami.Reddy@ti.com>
	<20120530164008.GO9947@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 672B4103B49
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2012 14:18:43 +0200 (CEST)
In-Reply-To: <20120530164008.GO9947@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Deshpande A,
	Vishwas" <Vishwas.A.Deshpande@ti.com>, "Girdwood, Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Wednesday 30 May 2012 10:10 PM, Mark Brown wrote:
> On Tue, May 29, 2012 at 04:39:46PM +0530, MR.Swami.Reddy@ti.com wrote:
>
>> he below patch is a basic driver code for TI Isabelle audio codec. The
>> functionalities like headset detection, etc., will be included incrementally
>> in the up-coming patches.
> Overall this is very good, there's a few issues below but they're pretty
> minor and ought to be easy to fix.

Thanks for quick review. I will fix these minor issues and update the patch.
>> +/* codec private data */
>> +struct isabelle_priv {
>> +	struct regmap *regmap;
>> +};
> If this is all you need then you should be able to use the newly
> introduced dev_get_regmap() to get the regmap back (other drivers should
> be being updated for this soon).
>

The dev_get_regmap() is not found in the 'for-next' or '3.5' branch. So
this api can't be used with 'for-next' source base. Please advice. 
>> +static const struct i2c_device_id isabelle_i2c_id[] = {
>> +	{ "isabelle", 0 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, isabelle_i2c_id);
> This should really include a list of part numbers - the general
> expecation people have is that they can just register the part number.
This audio codec has been referred as 'isabelle' in datasheet and no
specific part number.

Thanks
Swami
