From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 4/4] ASoC: twl6040: Simplify code in
	out_drv_event for pending work check
Date: Thu, 29 Sep 2011 15:11:45 +0300
Message-ID: <4457991.kWPjLAY5J8@barack>
References: <1317208593-21142-1-git-send-email-peter.ujfalusi@ti.com>
	<1317208593-21142-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75]) by alsa0.perex.cz (Postfix) with ESMTP id 89F37244E6
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Sep 2011 14:11:37 +0200 (CEST)
Received: by mail-bw0-f42.google.com with SMTP id r4so1254614bka.1
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2011 05:11:35 -0700 (PDT)
In-Reply-To: <1317208593-21142-5-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Wednesday 28 September 2011 14:16:33 Peter Ujfalusi wrote:
> Check for pending work before the DAPM event switch case, and return,
> if the work is pending.
> This way we can remove the two additional checks in POST_PMU, and
> PRE_PMD for non pending works.
> =

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Please ignore this patch.
For some reason this is the patch from the v1 series.

Sorry,
P=E9ter
