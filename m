From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add STA32X codec driver
Date: Thu, 16 Jun 2011 10:39:22 +0200
Message-ID: <4DF9C13A.2000205@metafoo.de>
References: <1308079626-31239-1-git-send-email-zonque@gmail.com>	<1308079626-31239-2-git-send-email-zonque@gmail.com>	<20110615150516.GC2806@opensource.wolfsonmicro.com>
	<20110615205329.GA7445@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 60478103A10
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 10:40:38 +0200 (CEST)
In-Reply-To: <20110615205329.GA7445@sig21.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Johannes Stezenbach <js@sig21.net>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Daniel Mack <zonque@gmail.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On 06/15/2011 10:53 PM, Johannes Stezenbach wrote:
> On Wed, Jun 15, 2011 at 04:05:16PM +0100, Mark Brown wrote:
>> On Tue, Jun 14, 2011 at 09:27:05PM +0200, Daniel Mack wrote:
>>
>>> +static const char *sta32x_limiter_ac_release_thr[] = {
>>> +	"-inf", "-29dB", "-20dB", "-16dB", "-14dB", "-12dB", "-10dB", "-8dB",
>>> +	"-7dB", "-6dB", "-5dB", "-4dB", "-3dB", "-2dB", "-1dB", "0dB" };
>>> +static const char *sta32x_limiter_drc_attack_thr[] = {
>>> +	"-31dB", "-29dB", "-27dB", "-25dB", "-23dB", "-21dB", "-19dB", "-17dB",
>>> +	"-16dB", "-15dB", "-14dB", "-13dB", "-12dB", "-10dB", "-7dB", "-4dB" };
>>> +static const char *sta32x_limiter_drc_release_thr[] = {
>>> +	"-inf", "-38dB", "-36dB", "-33dB", "-31dB", "-30dB", "-28dB", "-26dB",
>>> +	"-24dB", "-22dB", "-20dB", "-18dB", "-15dB", "-12dB", "-9dB", "-6dB" };
>>> +
>>
>> Doing these as regular volume TLVs will tend to work better in UIs.
> 
> The steps are not evenly distributed so I thought this is the
> only way to describe the hardware correctly.  Or is there a
> way to do controls which look like a slider in alsamixer
> with steps as shown above?
> 

You can put multiple scale items each with their own min/max value into a TLV.
For example for DRC attack in your case this would look like:

static const unsigned int drc_attack_tlv[] = {
	TLV_DB_RANGE_HEAD(3),
	0, 7, TLV_DB_SCALE_ITEM(-3100, 200, 0),
	8, 13, TLV_DB_SCALE_ITEM(-1600, 100, 0),
	14, 16, TLV_DB_SCALE_ITEM(-1000, 300, 0),
};

- Lars
