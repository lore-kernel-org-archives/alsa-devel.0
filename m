From: Paulo Cavalcanti <promac@gmail.com>
Subject: Re: idt blue jack patch
Date: Tue, 17 Feb 2009 23:04:31 -0300
Message-ID: <68720af30902171804t1ce547edx41ca120396e66e72@mail.gmail.com>
References: <68720af30902160113t5c0f206di4c63ecf801ce74ea@mail.gmail.com>
	<s5h4oyuirc5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 156571037F0
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 03:04:32 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id c5so2130777rvf.32
	for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2009 18:04:31 -0800 (PST)
In-Reply-To: <s5h4oyuirc5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 16, 2009 at 7:55 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 16 Feb 2009 06:13:35 -0300,
> Paulo Cavalcanti wrote:
> >
> > Hi,
> >
> > I received a patch form Fengguang that
> > made my Intel DG45ID (snd-hda-intel, codec IDT 92HD73E1X5)
> > behave the way it should, in my opinion.
> >
> > It just makes the blue jack behave as an input source by default (in alsa
> > 1.0.19 it is
> > an output jack).
> >
> > It is widespread that the green jack is output, the blue input and the
> pink
> > is mic.
> > Some cards allow reconfiguring the jacks in alsamixer, but the DG45ID
> > already has
> > an orange and black jacks for rear and center speakers, and a digital
> > output.
> >
> > Other people have also raised this problem some time ago:
> >
> >
> https://fcp.surfsite.org/modules/newbb/viewtopic.php?viewmode=threaded&order=ASC&topic_id=62855&forum=12&move=prev&topic_time=1224179600
> >
> > Fengguang suggested me to direct my request to the development list,
> > so the other developers could decide what to do.
> >
> > I would like to add that I can use the input source and the mic just fine
> > now
> > (the mic could be a bit louder, but it works fine with skype).
> >
> > The patch is very simple and is attached. This would conclude the fix
> > for this card, Takashi started with me some time ago (I just made the
> > tests).
>
> It's fine to put a quirk there.  But, you'd need to create a "model"
> for your device so that it won't interfere other devices.  That is,
> define a new model type, and call stac92xx_set_config_reg() with the
> check of spec->board_config.
>
>
This is easy. The problem is that I am already using model "no-jd",
remember?
In this case, if I used

        /* was 0x01113014 */
        if (spec->board_config > STAC_92HD73XX_NO_JD ) {
            stac92xx_set_config_reg(codec, 0x0c, 0x01813021);
        }

would be fine to me.

However, there is a possibility that all "stac92hd73xx" family needs
this quirk. In this case, no additional code is needed.

-- 
Paulo Roma Cavalcanti
LCG - UFRJ
