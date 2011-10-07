From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: OMAP machines: Fix kernel crash due
	to changes in core
Date: Fri, 07 Oct 2011 16:14:36 +0300
Message-ID: <4518982.z3cBzfSFpP@barack>
References: <1317971206-10365-1-git-send-email-peter.ujfalusi@ti.com>
	<1923772.Cd9hLQzlop@barack>
	<20111007114749.GI19080@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75])
	by alsa0.perex.cz (Postfix) with ESMTP id 794A0103B55
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 15:14:11 +0200 (CEST)
Received: by mail-bw0-f52.google.com with SMTP id 5so4463230bke.25
	for <alsa-devel@alsa-project.org>; Fri, 07 Oct 2011 06:14:09 -0700 (PDT)
In-Reply-To: <20111007114749.GI19080@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, =?utf-8?B?R3Jhxb52eWRhcw==?= Ignotas <notasas@gmail.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Friday 07 October 2011 12:47:49 Mark Brown wrote:
> Removing the calls is a totally sensible thing to do, like I say they
> should at best be a waste of time.  The problem with your patch was that
> weren't just removing them, you were replacing them with calls to
> new_widgets() which should be equally pointless.  If we have to do that
> we're clearly failing at something.

I tend to agree with all of these.
I have done some bisecting, and this is my conclusion:
We have quite many machine drivers adding their DAPM widgets/routes in their
dai_link->init callback.
All of these machine driver added DAPM widgets stopped working with:

commit 0b07ab9244d34929b6e07d6a275137a229e9c839
    ASoC: Instantiate DAPM widgets before we do the DAI link init

This patch moves the snd_soc_dapm_new_widgets() call pre dai_link->init.
Make sense for those machines which passing their DAPM widgets/routes via t=
he
snd_soc_card struct.
Rest of the machines were ended up their DAPM widgets being not initialized=
 -
ever.
They had the soc_dapm_sync call which is pointless thing to call anyway. Th=
ese
machines started to crash with commit:

commit 35c64bcad5c8244d973efbf7e58f6e0e09635504
    ASoC: Ensure all DAPM widgets have a power check callback

Since the check for w->power_check has been removed from dapm_power_one_wid=
get

What we can do:
- Add back the snd_soc_dapm_new_widgets() call post dai_link->init in the
soc_post_component_init (while keeping the pre dai_link->init call to this).
- Convert all machine drivers which uses the dai_link->init call to just ad=
d =

their DAPM widgets/routes to pass it via snd_soc_card struct.
- From the remaining drivers the soc_dapm_sync need to be removed. If they =
do =

funky stuff with their widgets we might need to add snd_soc_dapm_new_widget=
s() =

for their init call to be sure they are not crashing.

I have converted some of the OMAP machine drivers according to point 2 afte=
r =

this patch. I only changed those which seamed obvious.

This patch was mostly a search'n'replace to make sure they are no longer =

crashing.

--
P=E9ter
