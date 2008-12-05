From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] tlv320aic3x: control additions and cleanups
Date: Fri, 5 Dec 2008 13:42:58 +0000
Message-ID: <20081205134257.GD10489@sirena.org.uk>
References: <20081204175121.GD21010@buzzloop.caiaq.de>
	<20081204183746.GB6628@sirena.org.uk>
	<bd7b27490812050445l6e94ccfbx9339d87b51d518c6@mail.gmail.com>
	<20081205130001.GB10489@sirena.org.uk>
	<bd7b27490812050521j735b088i874f3f7f3b476f66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2553C244DB
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 14:43:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <bd7b27490812050521j735b088i874f3f7f3b476f66@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: u.luckas@road.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 05, 2008 at 03:21:39PM +0200, Jarkko Nikula wrote:
> On Fri, Dec 5, 2008 at 3:00 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> > On Fri, Dec 05, 2008 at 02:45:04PM +0200, Jarkko Nikula wrote:

> > > 54f01916297bafc18bd7df4e2300a0544a84fce3? Change like

> > Several codecs do this - systems often end up doing things like using
> > the line inputs as unrelated mono paths rather than as a stereo path.
> > How likely that is to happen with this codec I don't know.

> Or did I read the idea of patch wrong? Before there were stereo contol for

> PGAL -> HPL
> PGAR -> HPR

> and now

> PGAL -> HPL
> PGAL -> HPR

> PGAR seems to be missing?

Hrm.  This looks like it just substitutes two single controls for one
stereo control, which seems reasonable and shouldn't loose any control:

> -       SOC_DOUBLE_R("HP PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
> -                    PGAR_2_HPROUT_VOL, 0, 0x7f, 1),
> +       SOC_SINGLE("HPL PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
> +                    0, 0x7f, 1),
> +       SOC_SINGLE("HPR PGA Bypass Playback Volume", PGAL_2_HPROUT_VOL,
> +                    0, 0x7f, 1),

Possibly the controls are mislabeled?

Daniel?
