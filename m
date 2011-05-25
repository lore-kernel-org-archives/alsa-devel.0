From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: Fix dapm_is_shared_kcontrol so
 everything isn't shared
Date: Wed, 25 May 2011 17:52:02 +0300
Message-ID: <20110525175202.01ebfed2.jhnikula@gmail.com>
References: <1306278721-32742-1-git-send-email-swarren@nvidia.com>
	<20110525100155.04c8b5e1.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 996F01037EA
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 16:51:50 +0200 (CEST)
Received: by eyg5 with SMTP id 5so2828167eyg.38
	for <alsa-devel@alsa-project.org>; Wed, 25 May 2011 07:51:50 -0700 (PDT)
In-Reply-To: <20110525100155.04c8b5e1.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Hi Stephen

On Wed, 25 May 2011 10:01:55 +0300
Jarkko Nikula <jhnikula@gmail.com> wrote:

> On Tue, 24 May 2011 17:12:01 -0600
> Stephen Warren <swarren@nvidia.com> wrote:
> 
> > Commit af46800 ("ASoC: Implement mux control sharing") introduced
> > function dapm_is_shared_kcontrol.
> > 
> > When this function returns true, the naming of DAPM controls is derived
> > from the kcontrol_new. Otherwise, the name comes from the widget (and
> > possibly a widget's naming prefix).
> > 
> > A bug in the implementation of dapm_is_shared_kcontrol made it return 1
> > in all cases. Hence, that commit caused a change in control naming for
> > all controls instead of just shared controls.
> > 
> > Specifically, a control is always considered shared because it is always
> > compared against itself. Solve this by never comparing against the widget
> > containing the control being created.
> > 
> > I tested that with the Tegra WM8903 driver:
> > * Shared is now mostly 0 as expected, and sometimes 1.
> > * The expected controls are still generated after this change.
> > 
> > Howwever, I don't have any systems that have a widget/control naming
> > prefix, so I can't test that aspect.
> > 
> > Reported-by: Liam Girdwood <lrg@ti.com>
> > Root-caused-by: Jarkko Nikula <jhnikula@gmail.com>

I would rather see here Reported-by/Tested-by as I don't feel that I
broke here something :-)

> Hmm.. it seems this test is not enough with tlv320aic3x.c. It still
> classifies a lot of kcontrols to be shared. Will keep hunting.
> 
I managed to find why this didn't work with tlv320aic3x.c on rx51.c.

This triggered out that "[Left | Right] Line1[L | R]" Muxes in
tlv320aic3x were pointing to same mux controls which is wrong since
there are separate registers for them. I prepare a fix for this
hopefully tomorrow.

Then we must skip test for widgets that are in different dapm context,
i.e. we don't want to share mux controls if they are in different device
instance. Does it work for you if you add the dapm test below to your
patch?

@@ -334,6 +335,8 @@ static int dapm_is_shared_kcontrol(struct
snd_soc_dapm_context *dapm, *kcontrol = NULL;
 
 	list_for_each_entry(w, &dapm->card->widgets, list) {
+		if (w == kcontrolw || w->dapm != kcontrolw->dapm)
+			continue;

-- 
Jarkko
