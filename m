From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ASoC: Defining "signed integer" mixer controls?
Date: Thu, 03 Jun 2010 10:25:16 +0200
Message-ID: <4C0766EC.3090708@ladisch.de>
References: <hu6v9i$v43$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id A82EF103A75
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 10:25:19 +0200 (CEST)
In-Reply-To: <hu6v9i$v43$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Stuart Longland wrote:
> /* ADC PGA gain volumes. From 0 to 59.5 dB in 0.5 dB steps */
> static DECLARE_TLV_DB_MINMAX(adc_tlv, 0, 0);

The comment is wrong, this control goes from 0 to 0 dB.

> 	SOC_DOUBLE_R_TLV("PCM Playback Volume",
> 			 AIC3204_LDACVOL, AIC3204_RDACVOL,
> 			 0, 127, 0, dac_tlv),
> 
> However; it treats the bitfield as unsigned, which is wrong in this
> case.  The bitfield is a signed integer in two's complement format.  How
> do I convince ALSA that these integers have a sign bit?

ALSA's controls use signed values, it's the SOC_ macros that assume
bitfields.  You should be able to define a control with your own
callbacks like in a non-ASoC driver.


Regards,
Clemens
