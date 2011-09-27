From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 06/10] ASoC: twl6040: correct loop counters
	for HS/HF ramp code
Date: Tue, 27 Sep 2011 09:21:14 +0300
Message-ID: <1946709.L1hqkRcruS@barack>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
	<1317043593-27202-7-git-send-email-peter.ujfalusi@ti.com>
	<20110926213259.GF2872@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog109.obsmtp.com (na3sys009aog109.obsmtp.com
	[74.125.149.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 0AA1624375
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 08:21:05 +0200 (CEST)
Received: by mail-bw0-f54.google.com with SMTP id zs8so7924698bkb.41
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 23:21:04 -0700 (PDT)
In-Reply-To: <20110926213259.GF2872@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Monday 26 September 2011 22:33:01 Mark Brown wrote:
> On Mon, Sep 26, 2011 at 04:26:29PM +0300, Peter Ujfalusi wrote:
> > -	for (i =3D 0; i <=3D 16; i++) {
> > +	for (i =3D 0; i <=3D 15; i++) {
> =

> It'd seem more natural to change these to being simple < comparisons -
> they're far more common.  Any great reason for going tis way (perhaps
> context?).

No particular reason IMHO, just a copy from the wm8350 driver.
I'll check how they look like in assembly, it could be that <=3D is better =
in =

ARM?

--
P=E9ter
