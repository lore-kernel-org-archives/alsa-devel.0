From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: pci/hda/patch_via.c - broken between 2.6.36 and
 2.6.37 (bisected)
Date: Mon, 21 Feb 2011 07:39:38 +0800
Message-ID: <AANLkTikrdA4TM8oVddrgMRLcYJqSJvk5tW=9eY9L7oiY@mail.gmail.com>
References: <ijqrmf$tlg$1@dough.gmane.org>
	<AANLkTim-SMpK7ZFV1dn99v_KFeGYy2xNzLyzGzBuG-XC@mail.gmail.com>
	<201102201439.54277.wolfgang.scheicher@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f178.google.com (mail-ey0-f178.google.com
	[209.85.215.178])
	by alsa0.perex.cz (Postfix) with ESMTP id DD7892456A
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 00:39:39 +0100 (CET)
Received: by eya25 with SMTP id 25so802978eya.9
	for <alsa-devel@alsa-project.org>; Sun, 20 Feb 2011 15:39:39 -0800 (PST)
In-Reply-To: <201102201439.54277.wolfgang.scheicher@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/2/20 Wolfgang Scheicher <wolfgang.scheicher@gmail.com>

> On Sunday 20 February 2011 14:27:52 you wrote:
> > 2011/2/20 Wolfgang Scheicher <wolfgang.scheicher@gmail.com>
> >
> >> After the mentioned Kernel upgrade quite a view things went wrong on my
> >> hardware ( http://www.asrock.com/mb/overview.asp?Model=890GM%20Pro3 ):
> >>
> >> * Microphone doesn't work anymore. neither the front mic nor the rear
> >> one. Tried all thinkable settings.
> >>
> >> * Increasing Microphone levels leads to some strange internal feedback.
> >> That
> >> means, at some point when the feedback starts, it just starts, but i
> have
> >> no
> >> clue what audio source did actually trigger it.
> >>
> >> * Touching the mixer channel "Smart 5.1" in alsamixer makes alsamicer
> >> crash.
> >
> > Refer to the user manual , the motherboard has 5 audio jacks in rear
> panel,
> >
> > 7.1 need retasking of Line in (blue jacks) as side
> >
> > Audio Output Channels Front Speaker Rear Speaker Central / Bass Line In
> >                         (No. 9)       (No. 6)      (No. 5)     (No. 8)
> >         2                  V             --           --          --
> >         4                  V             V            --          --
> >         6                  V             V            V           --
> >         8                  V             V            V           V
>
> Forgive me, but i don't understand.
> I hope this doesn't mean i have to solder on my Mainboard if i intend to
> use a
> newer kernel.
>
> If there is something i can do, please explain in more detail.
>
> --
> Worf
>


http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=1564b2878f5cf160f60af99d4dbca1dd7809ee8a

Smart 5.1 is for 3-jacks model, to reuse input pins as outputs.
While off, they act as "line out" / "line in" / "mic in".
While on, they acts as "line out" / "back left/right" / "center/lfe".

If the driver use "Smart5.1 switch" for those 5-jacks model, you will need
to modify the function is_smart51_pins()


static int is_smart51_pins(struct via_spec *spec, hda_nid_t pin)
{
	const struct auto_pin_cfg *cfg = &spec->autocfg;
	int i;
        if (cfg->line_outs == 4)
            return 0;
	for (i = 0; i < cfg->num_inputs; i++) {
		if (pin == cfg->inputs[i].pin) {
                        switch(cfg->inputs[i].type){
			case AUTO_PIN_LINE_IN:
			        return (cfg->line_outs == 3 || cfg->line_outs == 1);
                        case AUTO_PIN_MIC:
                                if (
strncmp(hda_get_autocfg_input_label(spec->codec,cfg,i),"Rear Mic",8)
== 0 )
			           return (cfg->line_outs == 1);
                        }
                }
	}
	return 0;
}
