From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sdp4430: Fix string for FM input name
Date: Tue, 9 Aug 2011 23:33:34 +0900
Message-ID: <20110809143333.GB15861@opensource.wolfsonmicro.com>
References: <1309976285-25319-1-git-send-email-peter.ujfalusi@ti.com>
	<3256303.St6Oti5sp6@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1690D245C5
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 16:33:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3256303.St6Oti5sp6@barack>
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
Cc: alsa-devel@alsa-project.org, "Girdwood, Liam" <lrg@ti.com>, "Lopez Cruz,
	Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 09, 2011 at 10:29:22AM +0300, P=E9ter Ujfalusi wrote:
> On Wednesday 06 July 2011 20:18:05 Ujfalusi, Peter wrote:
> > The name contains invalid valid character (/), which
> > causes problems when trying to create the debugfs
> > directory structure:
> > ASoC: Failed to create Aux/FM Stereo In debugfs file

> Can you take a look at this patch?
> I think this shall go for 3.1 as a fix.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
