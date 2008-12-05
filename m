From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH] tlv320aic3x: control additions and cleanups
Date: Fri, 5 Dec 2008 14:45:04 +0200
Message-ID: <bd7b27490812050445l6e94ccfbx9339d87b51d518c6@mail.gmail.com>
References: <20081204175121.GD21010@buzzloop.caiaq.de>
	<20081204183746.GB6628@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by alsa0.perex.cz (Postfix) with ESMTP id BF36910380F
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 13:45:06 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 24so4675354wfg.23
	for <alsa-devel@alsa-project.org>; Fri, 05 Dec 2008 04:45:05 -0800 (PST)
In-Reply-To: <20081204183746.GB6628@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>, alsa-devel@alsa-project.org, u.luckas@road.de
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 4, 2008 at 8:37 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> On Thu, Dec 04, 2008 at 06:51:21PM +0100, Daniel Mack wrote:
>
> > - split "Line Playback Switch" into "LineL Playback Switch" and "LineR
> >   Playback Switch"
> > - split "Line PGA Bypass Playback Volume" into "LineL Left PGA Bypass
> >   Playback Volume" and "LineR Right PGA Bypass Playback Volume"
>
> I can't help thinking that it'd be easier to just use "Left Line" and
> "Right Line" but that's an existing issue in the driver.
>

Yeah, same thoughts. Started to look only now, but what's the idea to
separate stereo control into two mono control in commit
54f01916297bafc18bd7df4e2300a0544a84fce3? Change like

-       SOC_DOUBLE_R("HP PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
-                    PGAR_2_HPROUT_VOL, 0, 0x7f, 1),
+       SOC_SINGLE("HPL PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
+                    0, 0x7f, 1),
+       SOC_SINGLE("HPR PGA Bypass Playback Volume", PGAL_2_HPROUT_VOL,
+                    0, 0x7f, 1),


Jarkko
