From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: OMAP machines: Fix kernel crash due
	to changes in core
Date: Fri, 07 Oct 2011 14:46:13 +0300
Message-ID: <4189395.0St6XppZfI@barack>
References: <1317971206-10365-1-git-send-email-peter.ujfalusi@ti.com>
	<20111007104800.GH19080@opensource.wolfsonmicro.com>
	<1923772.Cd9hLQzlop@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 62865103B43
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 13:46:01 +0200 (CEST)
Received: by mail-ey0-f170.google.com with SMTP id 24so1793768eyg.1
	for <alsa-devel@alsa-project.org>; Fri, 07 Oct 2011 04:45:49 -0700 (PDT)
In-Reply-To: <1923772.Cd9hLQzlop@barack>
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

On Friday 07 October 2011 14:12:43 P=E9ter Ujfalusi wrote:
> As I said: sdp4430 strated to crash yesterday morning - without any change
> in the sdp4430 driver.

bisect given me this commit:
commit 35c64bcad5c8244d973efbf7e58f6e0e09635504
Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date:   Wed Sep 28 18:23:53 2011 +0100

    ASoC: Ensure all DAPM widgets have a power check callback
    =

    Makes the code simpler.
    =

    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

So this means we had this issue masked by the if (!w->power_check).
Since machine drivers rarely add mixers/muxes the issue has not been really
seen.
We tend to add _SPK, _HP, and stuff like that...

But I have checked the commit before this one. While it is not crashing the
kernel it does ignores the machine added DAPM widgets. They did not power on
(they used to power on). Based on this commit this is expected behavior.

The bisected commit just masked the underlaying issue.

--
P=E9ter
