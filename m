From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/3] ASoC: multi-comp: OMAP platform fixes
Date: Tue, 10 Aug 2010 09:42:20 +0300
Message-ID: <201008100942.20331.peter.ujfalusi@nokia.com>
References: <1281080355-22589-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100806105628.2971f8a1.jhnikula@gmail.com>
	<201008091909.59930.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 44E6B24449
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 08:42:40 +0200 (CEST)
In-Reply-To: <201008091909.59930.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Janusz,

On Monday 09 August 2010 20:09:57 ext Janusz Krzysztofik wrote:
> =

> Hi,
> If your request for testing Peter's patches is still valid, what exact tr=
ee
> and branch would you like me to test the patches against? I've tried to
> locate a tree with the patches already applied by Liam, but failed.
> =

> Meanwhile, I've verified that the patches, or their OMAP1 related bits, a=
re
> harmless when applied against (almost) current l-o master. However, I'm n=
ot
> sure if testing the new platform devices not actually used by any
> corresponding platform drivers is what you expected.

Since I do not have access to OMAP1 based boards, I can not test the patch =

which adds support for ASoC/multi-comp on OMAP1, I would be glad, if you co=
uld =

verify, if it is working on your board.

Liam has squashed the patches, so they are not visible.
In theory you can use your existing config, and the audio shall be working =
as =

it used to (before multi-comp).

It would be nice to know, if OMAP1 still works...

Thanks for taking time for this!
P=E9ter
