From: =?ISO-8859-15?Q?Eric_B=E9nard?= <eric@eukrea.com>
Subject: Re: imx-ssi.c & SND_SOC_DAIFMT_I2S
Date: Wed, 26 May 2010 14:41:35 +0200
Message-ID: <4BFD16FF.9060401@eukrea.com>
References: <4BFCEB10.6000205@eukrea.com>
	<20100526103753.GQ17272@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 27.mail-out.ovh.net (27.mail-out.ovh.net [91.121.30.210])
	by alsa0.perex.cz (Postfix) with SMTP id 76635103964
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 14:41:38 +0200 (CEST)
In-Reply-To: <20100526103753.GQ17272@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Sascha,

Le 26/05/2010 12:37, Sascha Hauer a =E9crit :
> I just had a look at the oscilloscope. For me it seems to make no
> difference whether I use I2S mode or what is done in current driver.
> Both look like your second picture.

strange, here that's not the case, if I don't add this, I get the first =

picture (left & right data on the same frame half period).

One thing : I'm using i.MX27's SSI port 4 which may be "special" as it =

can be host or device port, do you think this could make a difference vs =

your configuration ?

Eric
