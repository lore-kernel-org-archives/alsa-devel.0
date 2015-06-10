From: Adam Goode <agoode@google.com>
Subject: Re: [PATCH - alsa-lib 1/1] Introduce
 snd_seq_client_info_get_card_number,
 for getting the card number of a seq client on recent kernels
Date: Wed, 10 Jun 2015 13:09:05 -0400
Message-ID: <CAOf41N=vag=z1UA-GEUCbOJdq5=aMG=YV_08fmJTOh+fvONODA@mail.gmail.com>
References: <1433466312-31444-1-git-send-email-agoode@google.com>
 <557146C5.90209@ladisch.de> <s5hy4jrn95j.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f44.google.com (mail-vn0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id B4D75265CBA
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 19:09:27 +0200 (CEST)
Received: by vnbg7 with SMTP id g7so9157171vnb.10
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 10:09:26 -0700 (PDT)
In-Reply-To: <s5hy4jrn95j.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 10, 2015 at 6:35 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Fri, 05 Jun 2015 08:50:45 +0200,
> Clemens Ladisch wrote:
> >
> > Adam Goode wrote:
> > >  /**
> > > + * \brief Get the card number of a client_info container
> > > + * \param info client_info container
> > > + * \return the card number, -1 if no card associated with this
> client, or -ENOSYS if the
> > > + *         kernel does not support reporting this field
> > > + */
> >
> > -1 is used as an out-of-range value when enumerating cards.  However,
> > I don't think this convention can be applied here, because the return
> > value is also used for error codes, and -1 would correspond to -EPERM.
> >
> > Squashing all error codes into -1 is not a good idea, so I think the
> > value -1 should be converted into an appropriate error code, probably
> > -ENXIO.
>
> Agreed.
>
> Also, please don't include irrelevant changes in configure.ac.
>
>
> thanks,
>
> Takashi
>


Thanks for the feedback, I should have time this week to get back to you.


Adam
