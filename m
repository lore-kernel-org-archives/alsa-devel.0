From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/2] ASoC: codecs: Add support for
	PCM1789
Date: Sat, 17 Mar 2018 19:19:51 +0800
Message-ID: <201803171907.vbmkB7Z8%fengguang.wu@intel.com>
References: <20180315161825.5524-2-mylene.josserand@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4346E267196
 for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2018 12:19:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180315161825.5524-2-mylene.josserand@bootlin.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, michael@amarulasolutions.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org, kbuild-all@01.org, thomas.petazzoni@bootlin.com, mylene.josserand@bootlin.com
List-Id: alsa-devel@alsa-project.org

Hi Myl=E8ne,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v4.16-rc4]
[also build test WARNING on next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to h=
elp improve the system]

url:    https://github.com/0day-ci/linux/commits/Myl-ne-Josserand/ASoC-code=
cs-Add-support-for-PCM1789/20180317-174449


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/codecs/pcm1789.c:265:1-3: ERROR: test of a variable/field addr=
ess

vim +265 sound/soc/codecs/pcm1789.c

   260	=

   261	int pcm1789_common_exit(struct device *dev)
   262	{
   263		struct pcm1789_private *priv =3D dev_get_drvdata(dev);
   264	=

 > 265		if (&priv->work)
   266			flush_work(&priv->work);
   267	=

   268		return 0;
   269	}
   270	EXPORT_SYMBOL_GPL(pcm1789_common_exit);
   271	=


---
0-DAY kernel test infrastructure                Open Source Technology Cent=
er
https://lists.01.org/pipermail/kbuild-all                   Intel Corporati=
on
