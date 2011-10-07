From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: OMAP machines: Fix kernel crash due
 to changes in core
Date: Fri, 7 Oct 2011 14:46:36 +0100
Message-ID: <20111007134635.GG14518@opensource.wolfsonmicro.com>
References: <1317971206-10365-1-git-send-email-peter.ujfalusi@ti.com>
	<1923772.Cd9hLQzlop@barack>
	<20111007114749.GI19080@opensource.wolfsonmicro.com>
	<4518982.z3cBzfSFpP@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4B6F3103B77
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 15:46:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4518982.z3cBzfSFpP@barack>
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
Cc: alsa-devel@alsa-project.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, =?utf-8?Q?Gra=C5=BEvydas?= Ignotas <notasas@gmail.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 07, 2011 at 04:14:36PM +0300, P=E9ter Ujfalusi wrote:

> What we can do:
> - Add back the snd_soc_dapm_new_widgets() call post dai_link->init in the
> soc_post_component_init (while keeping the pre dai_link->init call to thi=
s).

Yes, that's needed.

> - Convert all machine drivers which uses the dai_link->init call to just =
add =

> their DAPM widgets/routes to pass it via snd_soc_card struct.

Obviously we should be doing this where we can - we won't be able to get
all of them as some of them will have conditionals.

> - From the remaining drivers the soc_dapm_sync need to be removed. If the=
y do =

> funky stuff with their widgets we might need to add snd_soc_dapm_new_widg=
ets() =

> for their init call to be sure they are not crashing.

new_widgets() is orthogonal to the sync(), there is now a stronger
requirement for it though.

> I have converted some of the OMAP machine drivers according to point 2 af=
ter =

> this patch. I only changed those which seamed obvious.

Yeah, I didn't apply all those patches as they depended on this one.
