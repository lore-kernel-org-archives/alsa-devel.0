From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: ASoC: OMAP mcbsp: dai->dev is missing warning
Date: Thu, 3 Dec 2009 11:45:47 +0200
Message-ID: <200912031145.47139.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id D066C243B2
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 10:45:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello,

Recently the following warnings appeared during the bootup on OMAP platform=
s:

No device for DAI omap-mcbsp-dai-0
No device for DAI omap-mcbsp-dai-1
No device for DAI omap-mcbsp-dai-2
No device for DAI omap-mcbsp-dai-3
No device for DAI omap-mcbsp-dai-4

I have taken a look, and it is printed, because the dai->dev is NULL for OM=
AP =

McBSP DAIs. Also the comment there states, that the dai->dev will become =

mandatory in the future.
At the moment the platform device/driver is not used for the =

sound/soc/omap/omap-mcbsp, it is used for the arch/arm/plat-omap/mcbsp.c, s=
o we =

really don't have possibility at the moment to provide a valid dai->dev for=
 ASoC =

at the moment.

Mark: Do you have some estimates, when the dai->dev will become mandatory?

Jarkko: Shall we start to think about the possibilities to provide a valid =
dai-
>dev for the mcbsp DAIs?

-- =

P=E9ter
