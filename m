From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 10/10] wss_lib: use wss detection code
 instead of ad1848 one
Date: Thu, 24 Jul 2008 07:26:20 +0200
Message-ID: <20080724072620.4197510c.krzysztof.h1@poczta.fm>
References: <20080718215126.7128a6f9.krzysztof.h1@poczta.fm>
	<4883632A.8090106@keyaccess.nl> <4887A28F.90506@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id E8C7F248F6
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 07:21:28 +0200 (CEST)
In-Reply-To: <4887A28F.90506@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 23 Jul 2008 23:28:47 +0200
Rene Herman <rene.herman@keyaccess.nl> wrote:

> On 20-07-08 18:09, Rene Herman wrote:
> 
> > For anyone interested, I have placed the complete series as I have it 
> > here at:
> > 
> > http://members.home.nl/rene.herman/wss/
> > 
> > It's against current ALSA. I'll give this a proper review early this 
> > coming week. Takashi was away for the week so that should get things 
> > looked at before he returns.
> 
> *** 0001-wss_lib-move-cs4231_lib-into-wss_lib.patch
> 
> Acked-by: Rene Herman <rene.herman@gmail.com>
> 
> *** 0002-wss_lib-rename-cs4231.h-into-wss.h.patch
> 
> Acked-by: Rene Herman <rene.herman@gmail.com>
> 

If you have done so detailed review of patches as below
you can add: Reviewed-by which gives you credits 
for your effort (and is considered stronger by Andrew
Morton at least).

> *** 0003-wss-rename-cs4321_foo-to-wss_foo.patch
> 
> > -#define CS4231_HW_DETECT        0x0000 /* let CS4231 driver detect chip */
> [ ... ]
> > +#define WSS_HW_DETECT        0x0000    /* let CS4231 driver detect chip */
> 
> The comment likes to be "let WSS driver [ ... ]". But please don't even 
> think of actually changing that. Only pointed out to dazzle you with my 
> unrelenting eye for detail.
> 

This series of patches gives unification. I found few issues in the wss_lib
which can be improved but I didn't want to mix them up with
these patches.

> > diff --git a/sound/isa/ad1848/ad1848.c b/sound/isa/ad1848/ad1848.c
> > index 5f5271e..3500548 100644
> > --- a/sound/isa/ad1848/ad1848.c
> > +++ b/sound/isa/ad1848/ad1848.c
> > @@ -70,15 +70,15 @@ static int __devinit snd_ad1848_match(struct device *dev, unsigned int n)
> >                 return 0;
> >  
> >         if (port[n] == SNDRV_AUTO_PORT) {
> > -               snd_printk(KERN_ERR "%s: please specify port\n", dev->bus_id);
> > +               snd_printk(KERN_ERR "%s: please specify port\n", dev_name(dev));
> >                 return 0;
> >         }
> 
> The comment in dev_name() makes me wonder a bit but I guess we'll deal 
> with it then if there's anything to deal with.
> 

This is not my change. It is probably diff between some -mm kernel version and alsa-driver. 
It should not be there as the ad1848.c is going to be deleted.

> > -CS4236_DOUBLE("Master Digital Playback Switch", 0, CS4236_LEFT_MASTER, CS4236_RIGHT_MASTER, 7, 7, 1, 1),
> > -CS4236_DOUBLE("Master Digital Capture Switch", 0, CS4236_DAC_MUTE, CS4236_DAC_MUTE, 7, 6, 1, 1),
> > +CS4236_DOUBLE("Master Digital Playback Switch", 0,
> > +               CS4236_LEFT_MASTER, CS4236_RIGHT_MASTER, 7, 7, 1, 1),
> > +CS4236_DOUBLE("Master Digital Capture Switch", 0,
> > +               CS4236_DAC_MUTE, CS4236_DAC_MUTE, 7, 6, 1, 1),
> 
> I can't say I'm personally a fan of these kinds of changes. The point of 
> them would supposedly be to make the code more readable but as far as I 
> am concerned it does the reverse.
> 
> I know that Takashi can be an 80-column fundamentalist so I'll not 
> object I guess. I'd personally like these (all) restored to a single 
> line but if he doesn't, so be it.
> 

Exactly. It was done for Takashi.

> > --- a/sound/isa/wss/wss_lib.c
> > +++ b/sound/isa/wss/wss_lib.c
> 
> [ ... ]
> 
> > -static inline void cs4231_outb(struct snd_cs4231 *chip, u8 offset, u8 val)
> > +static inline void wss_outb(struct snd_wss *chip, u8 offset, u8 val)
> >  {
> >         outb(val, chip->port + offset);
> >  }
> > +EXPORT_SYMBOL(snd_wss_out);
> 
> This EXPORT_SYMBOL() is in the wrong spot (ie, not after snd_wss_out).
> 

Ok.

> > +static void snd_wss_debug(struct snd_wss *chip)
> > +{
> > +       printk(KERN_DEBUG "CS4231 REGS:      INDEX = 0x%02x  ",
> > +               wss_inb(chip, CS4231P(REGSEL)));
> > +       printk(KERN_DEBUG "                 STATUS = 0x%02x\n",
> > +               wss_inb(chip, CS4231P(STATUS)));
> 
> This is an even worse example of the 80-column change here. Just makes 
> it worse as it destroys the What You Write Is What You Get format.
> 

Again. It was done for Takashi. I was unsure how to proceed in case of
renaming constants in lines like these. They could be left one-line
because it was not regression.

> > +static void snd_wss_playback_format(struct snd_wss *chip,
> 
> [ ... ]
> 
> > -                       snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT, chip->image[CS4231_PLAYBK_FORMAT] = pdfr);
> > +                       chip->image[CS4231_PLAYBK_FORMAT] = pdfr;
> > +                       snd_wss_out(chip, CS4231_ALT_FEATURE_1,
> > +                                   chip->image[CS4231_ALT_FEATURE_1] &= ~0x10);
> 
> [ .. ]
> 
> >         if (full_calib) {
> > -               snd_cs4231_mce_up(chip);
> > +               snd_wss_mce_up(chip);
> >                 spin_lock_irqsave(&chip->reg_lock, flags);
> > -               if (chip->hardware != CS4231_HW_INTERWAVE && !chip->single_dma) {
> > -                       snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT,
> > +               if (chip->hardware != WSS_HW_INTERWAVE && !chip->single_dma) {
> > +                       snd_wss_out(chip, CS4231_PLAYBK_FORMAT,
> >                                         (chip->image[CS4231_IFACE_CTRL] & CS4231_RECORD_ENABLE) ?
> >                                         (pdfr & 0xf0) | (chip->image[CS4231_REC_FORMAT] & 0x0f) :
> > -                                       pdfr);
> > +                                       pdfr);
> >                 } else {
> > -                       snd_cs4231_out(chip, CS4231_PLAYBK_FORMAT, chip->image[CS4231_PLAYBK_FORMAT] = pdfr);
> > +                       snd_wss_out(chip, CS4231_PLAYBK_FORMAT,
> > +                                   chip->image[CS4231_PLAYBK_FORMAT] = pdfr);
> >                 }
> 
> As long as you're at it... could you split this assignment same as you 
> did above?
> 

Ok. I did it above because otherwise the line was too long ...

> > +static int snd_wss_timer_stop(struct snd_timer *timer)
> >  {
> >         unsigned long flags;
> > -       struct snd_cs4231 *chip = snd_timer_chip(timer);
> > +       struct snd_wss *chip = snd_timer_chip(timer);
> >         spin_lock_irqsave(&chip->reg_lock, flags);
> > -       snd_cs4231_out(chip, CS4231_ALT_FEATURE_1, chip->image[CS4231_ALT_FEATURE_1] &= ~CS4231_TIMER_ENABLE);
> > +       snd_wss_out(chip, CS4231_ALT_FEATURE_1,
> > +                   chip->image[CS4231_ALT_FEATURE_1] &= ~CS4231_TIMER_ENABLE);
> >         spin_unlock_irqrestore(&chip->reg_lock, flags);
> >         return 0;
> >  }
> 
> Same.

Ok.

> 
> > -static snd_pcm_uframes_t snd_cs4231_playback_pointer(struct snd_pcm_substream *substream)
> > +static snd_pcm_uframes_t snd_wss_playback_pointer
> > +               (struct snd_pcm_substream *substream)
> > 
> 
> Please don't split function names quite like that. If the 80-column 
> thing must be at least keep the opening brace on the same line.
> 
> Same thing for snd_wss_capture_pointer() just below that one.

Ok.

> 
> > @@ -1475,32 +1568,36 @@ int snd_cs4231_create(struct snd_card *card,
> >         chip->dma2 = -1;
> >  
> >         if ((chip->res_port = request_region(port, 4, "CS4231")) == NULL) {
> > -               snd_printk(KERN_ERR "cs4231: can't grab port 0x%lx\n", port);
> > -               snd_cs4231_free(chip);
> > +               snd_printk(KERN_ERR "wss: can't grab port 0x%lx\n", port);
> > +               snd_wss_free(chip);
> >                 return -EBUSY;
> >         }
> >         chip->port = port;
> >         if ((long)cport >= 0 && (chip->res_cport = request_region(cport, 8, "CS4232 Control")) == NULL) {
> 
> You've left these two if assignments in. You do all the others so I 
> assume you forgot.
> 

I could miss them. I used the checkpatch script and it is not checking context lines
as new lines.

> > +static struct snd_kcontrol_new snd_wss_controls[] = {
> > +WSS_DOUBLE("PCM Playback Switch", 0,
> > +          CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
> 
> Same comment about the split.
> 
> > +module_init(alsa_wss_init)
> > +module_exit(alsa_wss_exit)
> 
> Can you add a ";" after these? These macros should've not included them. 
> Just makes for an odd special case to remember (yes, I know there are 
> more of them in the tree, but I myself fix it when I get close also).
> 

Ok.

> ...
> 
> Right-o. That was a 4000+ line patch and I ran out of evening. Rest will 
> have to wait for tomorrow then. If you make changes, could you very 
> specifically indicate those changes so that I might be able to get away 
> with not reading the entire thing again? :-/
> 

Yes.

> Rene.
> 
Thank you for your review and time.
Krzysztof

----------------------------------------------------------------------
Rowerem po Roztoczu.
Zobacz relacje >>> http://link.interia.pl/f1e65
