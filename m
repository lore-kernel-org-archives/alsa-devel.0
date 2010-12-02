From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v2] ASoC: tpa6130a2: Replace DAPM code with
	direct interface
Date: Thu, 2 Dec 2010 12:16:12 +0200
Message-ID: <201012021216.12166.peter.ujfalusi@nokia.com>
References: <1291274996-28056-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101202095626.GB19267@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 409C110382F
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 11:16:19 +0100 (CET)
In-Reply-To: <20101202095626.GB19267@rakim.wolfsonmicro.main>
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
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thursday 02 December 2010 11:56:26 ext Mark Brown wrote:
> I thought we'd decided that adding a HP widget in the driver was the
> most straightforward thing here?  Still...

At least with my device I need to add some delay before enabling the amp, s=
o =

anyway I need to ahve the DAPM_HP in the machine driver.
We do not have users for this amp, and the n900 support is still partial (t=
hat =

uses the tpa on the headset path, which is not yet there).
How ever I can add back a support to register the DAPM_HP in the amp driver =

which can be used by machine drivers without special needs (in a separate =

patch).
 =

> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Thanks,
P=E9ter
