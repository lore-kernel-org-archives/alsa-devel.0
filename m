From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH] tlv320aic3x: control additions and cleanups
Date: Fri, 5 Dec 2008 15:21:39 +0200
Message-ID: <bd7b27490812050521j735b088i874f3f7f3b476f66@mail.gmail.com>
References: <20081204175121.GD21010@buzzloop.caiaq.de>
	<20081204183746.GB6628@sirena.org.uk>
	<bd7b27490812050445l6e94ccfbx9339d87b51d518c6@mail.gmail.com>
	<20081205130001.GB10489@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E0FD244C2
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 14:21:40 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id l35so2356017waf.16
	for <alsa-devel@alsa-project.org>; Fri, 05 Dec 2008 05:21:39 -0800 (PST)
In-Reply-To: <20081205130001.GB10489@sirena.org.uk>
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
To: Mark Brown <broonie@sirena.org.uk>
Cc: u.luckas@road.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 5, 2008 at 3:00 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> On Fri, Dec 05, 2008 at 02:45:04PM +0200, Jarkko Nikula wrote:
> > On Thu, Dec 4, 2008 at 8:37 PM, Mark Brown <broonie@sirena.org.uk>
> wrote:
>
> > > I can't help thinking that it'd be easier to just use "Left Line" and
> > > "Right Line" but that's an existing issue in the driver.
>
> > Yeah, same thoughts. Started to look only now, but what's the idea to
> > separate stereo control into two mono control in commit
> > 54f01916297bafc18bd7df4e2300a0544a84fce3? Change like
>
> Several codecs do this - systems often end up doing things like using
> the line inputs as unrelated mono paths rather than as a stereo path.
> How likely that is to happen with this codec I don't know.
>

Or did I read the idea of patch wrong? Before there were stereo contol for

PGAL -> HPL
PGAR -> HPR

and now

PGAL -> HPL
PGAL -> HPR

PGAR seems to be missing?

-       SOC_DOUBLE_R("HP PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
-                    PGAR_2_HPROUT_VOL, 0, 0x7f, 1),
+       SOC_SINGLE("HPL PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
+                    0, 0x7f, 1),
+       SOC_SINGLE("HPR PGA Bypass Playback Volume", PGAL_2_HPROUT_VOL,
+                    0, 0x7f, 1),

Codec itself can route all Line2[L | R], PGA [L | R], DAC [L | R] into all
seven output stages. Which are Mono, Line [L |R] and HP [H |L] with HP
having own volumes for HP positive and negative.


Jarkko
