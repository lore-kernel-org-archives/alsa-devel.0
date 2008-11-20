From: "naveen krishna ch" <naveenkrishna.ch@gmail.com>
Subject: Re: Kcontrols for ASoC TWL4030 CODEC
Date: Thu, 20 Nov 2008 19:31:15 +0530
Message-ID: <ef0d8a250811200601n5bcede89xb442dc26cb05fe8a@mail.gmail.com>
References: <ef0d8a250811200442j3146441cgc4650153974e62d6@mail.gmail.com>
	<20081120133644.GE4539@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 27B8124332
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 15:01:15 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so453160rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 06:01:15 -0800 (PST)
In-Reply-To: <20081120133644.GE4539@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 20, 2008 at 7:06 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> On Thu, Nov 20, 2008 at 06:12:56PM +0530, naveen krishna ch wrote:
>
> >  static const struct snd_kcontrol_new twl4030_snd_controls[] = {
> > -    SOC_DOUBLE_R("Master Playback Volume",
> > -         TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
> > -        0, 127, 0),
> > -    SOC_DOUBLE_R("Capture Volume",
> > -         TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
> > -        0, 127, 0),
> > +
> > +    /* Master Playback Volume Controls */
> > +        SOC_DOUBLE_R("Master PLayback Course Gain",
> > +                TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
> > +                6, 3, 0),
> > +
>
> Please see the comments I made in response to your original posting -
> there look to be problems with your indentation here and your control
> names should conform to the ALSA control naming standard in:

Sorry i could not solve the issue with the indentation i have attached the
patch  file.

>
>
>        Documentation/sound/alsa/ControlNames.txt

The standard names in the documentation does not gives the exact details of
the CODEC's feature so i used a part of the CODEC pin name to avoid
confusion at later stages.

Course and Fine controls are feature given by the CODEC so distinguish them
i named them against the features.
There is an internal and external speaker facility i name d them against
that.

However i will re submit the patch with some modifications in names.

-- 
Thanks,

(: Naveen Krishna Ch :)
