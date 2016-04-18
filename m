From: Jeremy McDermond <nh6z@nh6z.net>
Subject: Re: [PATCH] ASoC: tlv320aic32x4: Add SPI support
Date: Mon, 18 Apr 2016 07:45:35 -0700
Message-ID: <35635C45-EDA1-43C3-86DF-9C6DBEA27846@nh6z.net>
References: <1460745059-5737-1-git-send-email-nh6z@nh6z.net>
 <20160418103554.GR3217@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.xenotropic.com (mail.xenotropic.com [198.178.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D99826154C
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 16:45:40 +0200 (CEST)
In-Reply-To: <20160418103554.GR3217@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


> On Apr 18, 2016, at 3:35 AM, Mark Brown <broonie@kernel.org> wrote:
> 
> On Fri, Apr 15, 2016 at 11:30:59AM -0700, Jeremy McDermond wrote:
>> The TLV320AIC32x4 support the control channel over either SPI or I2C.
>> Added the proper interfacing with regmap to make the driver able to
>> handle either possibility.
>> 
>> Signed-off-by: Jeremy McDermond <nh6z@nh6z.net>
>> ---
>> sound/soc/codecs/Kconfig         |   5 +-
>> sound/soc/codecs/tlv320aic32x4.c | 181 +++++++++++++++++++++++++++++++++++----
>> 2 files changed, 165 insertions(+), 21 deletions(-)
> 
> Instead of putting everything in one file please split the driver so it
> has separate core and I2C modules and then add a SPI module like we do
> for newer drivers.

No problem.  Thanks Mark.  Would you like the separation of the I2C code to be in a separate patch set, or is one patch set with two separate patches fine?

>> config SND_SOC_TLV320AIC32X4
>> -	tristate
>> +	tristate "Texas Instruments TLV320AIC32x4 CODECs"
>> +	depends on SND_SOC_I2C_AND_SPI
> 
> Making the driver directly user selectable is a separate change and
> should be in a separate patch.

I should have reviewed my submission better.  This was for testing only.  Sorry about that.

--
Jeremy McDermond (NH6Z)
Xenotropic Systems
mcdermj@xenotropic.com
