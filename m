From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH] tlv320aic3x: control additions and	cleanups
Date: Fri, 5 Dec 2008 16:11:03 +0100
Message-ID: <20081205151103.GC1821@buzzloop.caiaq.de>
References: <20081204175121.GD21010@buzzloop.caiaq.de>
	<20081204183746.GB6628@sirena.org.uk>
	<bd7b27490812050445l6e94ccfbx9339d87b51d518c6@mail.gmail.com>
	<20081205130001.GB10489@sirena.org.uk>
	<bd7b27490812050521j735b088i874f3f7f3b476f66@mail.gmail.com>
	<20081205134257.GD10489@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id C7F2924529
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 16:11:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081205134257.GD10489@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, u.luckas@road.de
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, Dec 05, 2008 at 01:42:58PM +0000, Mark Brown wrote:
> Hrm.  This looks like it just substitutes two single controls for one
> stereo control, which seems reasonable and shouldn't loose any control:
> 
> > -       SOC_DOUBLE_R("HP PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
> > -                    PGAR_2_HPROUT_VOL, 0, 0x7f, 1),
> > +       SOC_SINGLE("HPL PGA Bypass Playback Volume", PGAL_2_HPLOUT_VOL,
> > +                    0, 0x7f, 1),
> > +       SOC_SINGLE("HPR PGA Bypass Playback Volume", PGAL_2_HPROUT_VOL,
> > +                    0, 0x7f, 1),
> 
> Possibly the controls are mislabeled?

As this is commited already, I'd like to make the naming cleanup part of
the patch with the "DAC" string removals. Is that ok for you?

Apart from that, can the other one be applied?

Best regards,
Daniel
