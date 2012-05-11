From: Mark Hills <mark@pogo.org.uk>
Subject: Re: [RFC] usb-audio: Use a table of mixer controls
Date: Sat, 12 May 2012 00:21:14 +0100 (BST)
Message-ID: <alpine.LNX.2.01.1205120014250.23046@stax.localdomain>
References: <1336757328-22649-1-git-send-email-mark@pogo.org.uk>
	<s5hzk9ems3i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 151B21047A9
	for <alsa-devel@alsa-project.org>;
	Sat, 12 May 2012 01:21:16 +0200 (CEST)
In-Reply-To: <s5hzk9ems3i.wl%tiwai@suse.de>
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

On Fri, 11 May 2012, Takashi Iwai wrote:

[...]
> >  /*
> > + * Create a set of standard UAC controls from a table
> > + */
> > +static int snd_create_std_mono_table(struct usb_mixer_interface *mixer,
> > +				struct std_mono_table *t)
> > +{
> > +	int err;
> > +
> > +	while (t->name != NULL) {
> > +		err = snd_create_std_mono_ctl(mixer, t->unitid, t->control,
> > +				t->cmask, t->val_type, t->name, t->tlv_callback);
> > +		if (err < 0)
> > +			return err;
> 
> t++ is missing?

Hmm, yes. A clear indication that the code I must have not tested the 
correct code (originally I used ARRAY_SIZE)

I'll make sure to confirm this before I submit a proper patch.
 
[...]
> > +/*
> > + * The mixer units for Ebox-44 are corrupt, and even where they
> > + * are valid they presents mono controls as L and R channels of
> > + * stereo. So we create provide a good mixer here.
> > + */
> > +struct std_mono_table ebox44_table[] = {
> > +	{ 4, 1, 0x0, USB_MIXER_INV_BOOLEAN, "Headphone Playback Switch", NULL },
> > +	{ 4, 2, 0x1, USB_MIXER_S16, "Headphone A Mix Playback Volume", NULL },
> > +	{ 4, 2, 0x2, USB_MIXER_S16, "Headphone B Mix Playback Volume", NULL },
> > +
> > +	{ 7, 1, 0x0, USB_MIXER_INV_BOOLEAN, "Output Playback Switch", NULL },
> > +	{ 7, 2, 0x1, USB_MIXER_S16, "Output A Playback Volume", NULL },
> > +	{ 7, 2, 0x2, USB_MIXER_S16, "Output B Playback Volume", NULL },
> > +
> > +	{ 10, 1, 0x0, USB_MIXER_INV_BOOLEAN, "Input Capture Switch", NULL },
> > +	{ 10, 2, 0x1, USB_MIXER_S16, "Input A Capture Volume", NULL },
> > +	{ 10, 2, 0x2, USB_MIXER_S16, "Input B Capture Volume", NULL },
> > +
> > +	{ }
> 
> C99 style struct initialization is preferred.  Then NULL settings can
> be omittted.

Do you mean like this?

  ebox44_table[] = {
      {
          .unitid = 4,
          .control =  1
          .cmask = 0x0
          /* etc. */
      }

Because then it becomes a lot less concise and a lot less readable? Of 
course, if there are more optional params in the future, then maybe.

IIRC, I could omit the NULL anyway, because static memory is initialised 
to contain zeroes (hence the "{ }" works). Am I correct? It's late, I 
might be mistaken.

> Other than that, it looks fine to me.

Thanks for comments.

-- 
Mark
