From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/10] ASoC: twl6040: Combine the custom
 volsw get, and put functions
Date: Tue, 27 Sep 2011 12:42:44 +0100
Message-ID: <20110927114243.GA4289@opensource.wolfsonmicro.com>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
	<2435781.WrNUf02Inv@barack>
	<20110927105625.GF2910@opensource.wolfsonmicro.com>
	<15316585.mj9RxehzRH@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3FE222412D
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 13:42:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <15316585.mj9RxehzRH@barack>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 27, 2011 at 02:21:37PM +0300, P=E9ter Ujfalusi wrote:

> In case of SOC_SINGLE_TLV I (will) need to call snd_soc_put_volsw
> In case of SOC_DOUBLE_TLV I need to call  snd_soc_put_volsw
> In case of SOC_DOUBLE_R_TLV I need to call  snd_soc_put_volsw_2r.

Or we could just update the macros and unify all the operations which
might be easier overall?
