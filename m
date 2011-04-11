From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: SND_SOC_DAPM_VIRT_MUX question
Date: Mon, 11 Apr 2011 13:27:54 -0700
Message-ID: <20110411202753.GE29405@opensource.wolfsonmicro.com>
References: <1302168008.27103.21.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 57ECD10389B
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 22:27:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1302168008.27103.21.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: alsa <alsa-devel@alsa-project.org>, Liam <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 07, 2011 at 02:50:08PM +0530, Koul, Vinod wrote:

> But the problem is that the this VIRT mux is not allowing me to change
> values :(, set to to 1.
> I remember that code checks if the path should be allowed for MUX and
> implements only if its allowed, but in virtual mix case it should not do
> so... or I am missing something?

It should be possible to set the mux to any value, the routes will only
be created if they exist but that shouldn't affect the control itself.
The only check _put_enum_virt() does is if the value is greater than the
number of elements in the enumeration.

However...

| static const char *sn95031_decoder_text[] = {"None", "Speaker",
|         "Headset"};
| static const struct soc_enum sn95031_decoder_enum =
|         SOC_ENUM_SINGLE(SND_SOC_NOPM, 0, 3, sn95031_decoder_text);
| static const struct snd_kcontrol_new sn95031_decoder_control =
|         SOC_DAPM_ENUM("Route", sn95031_decoder_enum);

...I think you want to be using an ENUM_VIRT here?
