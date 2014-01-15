From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v2 0/8] ASoC: simple-card: simplify code
Date: Wed, 15 Jan 2014 16:51:28 +0100
Message-ID: <20140115165128.479994c3@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

This patch set simplifies the code and make easier a possible multi-DAI
links extension.
--
v2:
	- split the changes into 8 patches (Mark Brown request)
	- remove the dynamic DAI link array allocation
	- fix lack of init function when DT use

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
