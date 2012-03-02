From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 00/10] OMAP/ASoC: Move and merge McBSP driver under
 ASoC
Date: Fri, 02 Mar 2012 16:37:17 +0200
Message-ID: <4F50DB1D.1090007@ti.com>
References: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com> <20120228104925.GA3683@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120228104925.GA3683@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 02/28/2012 12:49 PM, Mark Brown wrote:
> On Tue, Feb 28, 2012 at 09:40:10AM +0200, Peter Ujfalusi wrote:
>=20
>> NOTE: this series has been generated agains Takashi's topic/asoc bra=
nch merged
>> with Mark's for-next branch since this series depends on changes in =
Marks'
>> branch, but not yet pulled by Takashi (snd_soc_add_dai_controls impl=
ementation
>> from Liam).
>=20
> Never base *anything* off my for-next branch, it gets rebuilt regular=
ly.

Sorry it was my mistake. I have merged your for-3.4 branch with
Takashi's topic/asoc to be able test the v2 series which dropped my
version of snd_soc_add_dai_controls()

Sometimes I use your for-next branch, but I'm not building on top of it
since I have also noticed that it got rebuilt occasionally.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
