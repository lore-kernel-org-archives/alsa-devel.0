From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [alsa-devel] [patch] ALSA: seq_midi_emul: small array underflow
Date: Tue, 3 Mar 2015 14:38:48 +0300
Message-ID: <20150303113848.GD5437@mwanda>
References: <20150303093829.GA7685@mwanda>
 <54F5993E.7000109@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54F5993E.7000109@ladisch.de>
Sender: kernel-janitors-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 03, 2015 at 12:21:34PM +0100, Clemens Ladisch wrote:
> Dan Carpenter wrote:
> > In snd_opl3_calc_pitch() then the limit is:
> >
> > 	if (pitchbend > 0x1FFF)
> > 		pitchbend = 0x1FFF;
> >
> > But it can underflow meaning that segment can be as low as
> > SHORT_MIN / 0x1000 and we can read 6 elements before the start of the
> > opl3_note_table[] array.
> 
> > -	short midi_pitchbend;		/* Pitch bend amount */
> > +	unsigned short midi_pitchbend;	/* Pitch bend amount */
> 
> Pitch bend is a signed 14-bit value.  What is wrong is the missing
> check for the lower bound.
> 

Thanks for the review.  I will resend.

regards,
dan carpenter

