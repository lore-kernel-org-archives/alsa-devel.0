From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/10] ASoC: twl6040: Combine the custom
 volsw get, and put functions
Date: Tue, 27 Sep 2011 11:56:26 +0100
Message-ID: <20110927105625.GF2910@opensource.wolfsonmicro.com>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
	<1317043593-27202-3-git-send-email-peter.ujfalusi@ti.com>
	<20110926212141.GB2872@opensource.wolfsonmicro.com>
	<2435781.WrNUf02Inv@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3C4E1103946
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 12:56:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2435781.WrNUf02Inv@barack>
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

On Tue, Sep 27, 2011 at 09:16:16AM +0300, P=E9ter Ujfalusi wrote:
> On Monday 26 September 2011 22:21:42 Mark Brown wrote:

> > Traditionally this would be done by comparing reg and rreg - if they're
> > the same they're a mono control.

> I'm not looking for the mono/stereo, but looking for the gain value(s) ar=
e in =

> the same register, but in different offset VS gain values are at the same =

> offset, but in two different registers.

That's not what you're actually checking :)  This would generally be
checked by comparing the shift registers - the basic reason we have the
two functions at all is that we used to mash everything into a 32 bit
int rather than using a pointer to struct.
