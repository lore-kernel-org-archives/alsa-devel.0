From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 2/4] ASoC: omap-mcbsp: Only print
 warning if the st_data is missing for the port
Date: Fri, 24 Aug 2012 14:23:28 +0300
Message-ID: <50376430.2060301@ti.com>
References: <1345630303-26291-1-git-send-email-peter.ujfalusi@ti.com>
 <1345630303-26291-3-git-send-email-peter.ujfalusi@ti.com>
 <503735EA.5080907@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog134.obsmtp.com (na3sys009aog134.obsmtp.com
 [74.125.149.83])
 by alsa0.perex.cz (Postfix) with ESMTP id A230B265CBD
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2012 13:23:29 +0200 (CEST)
Received: by obbtb18 with SMTP id tb18so5219763obb.21
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2012 04:23:27 -0700 (PDT)
In-Reply-To: <503735EA.5080907@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 08/24/2012 11:06 AM, Jarkko Nikula wrote:
> I acked the set but a little note here: I guess this is something what
> only developer can hit, by calling omap_mcbsp_st_add_controls for a port
> not having the sidetone, so would blocking the probe be better than warni=
ng?

I was hesitating when I did this patch but at the end only developers can h=
it
this - either trying to enable the ST on McBSP which does not physically ha=
ve
ST block, or as of now booting their kernel with DT.
I'm rolling several patches for omap-twl4030 machine driver (support for Mc=
BSP
master configuration, ST support, etc). It is really annoying when you test=
 a
change which is not ST related and when you boot with DT there is no card ->
so you need to modify the kernel between DT boot and non DT boot.

We have the warning about it, we do not add the ST controls but the audio
otherwise works.

The ST controls are not part of DAPM so the audio routing is not affected.

For us, developers it is better this way and for the users this does not
really matter.

-- =

P=E9ter
