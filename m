From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 3/7] ASoC: TWL4030: Make offset
	cancellation path configurable
Date: Tue, 25 May 2010 14:59:51 +0300
Message-ID: <201005251459.51911.peter.ujfalusi@nokia.com>
References: <1274787248-18583-1-git-send-email-peter.ujfalusi@nokia.com>
	<1274787248-18583-4-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 47D01244BF
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 13:59:59 +0200 (CEST)
In-Reply-To: <1274787248-18583-4-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

resending, because:

On Tuesday 25 May 2010 14:34:04 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> For paths use the defines from
> include/linux/mfd/twl4030-codec.h:
> TWL4030_OFFSET_CNCL_SEL_*

... =


>  	/* initiate offset cancellation */
>  	anamicl =3D twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICL);
> +	anamicl &=3D ~TWL4030_OFFSET_CNCL_SEL;
> +	anamicl |=3D (setup->offset_cncl_path << 5);

No need for the shift, it seams to be left from some older test code.

-- =

P=E9ter
