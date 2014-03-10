From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Zoom R16
Date: Mon, 10 Mar 2014 20:28:41 +0000
Message-ID: <201403102028.41556.gineera@aspect135.co.uk>
References: <CAPrbH=vnQ-xXsRDoj30nra7hB_hDEaF6u3ov0XuDG_ZpFzb3bA@mail.gmail.com>
 <CAPrbH=uHUhWMYiGcHKLwFYiWwGhahNqAWjio1RKECM_dUnNN6A@mail.gmail.com>
 <CAPrbH=tQ3H1wUnK2417ap5jHSSO=y7vkBcCXBJqWn2V9sqbGHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip05ir2.opaltelecom.net (out1.ip05ir2.opaltelecom.net
 [62.24.128.241])
 by alsa0.perex.cz (Postfix) with ESMTP id D39D52602AD
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 21:29:15 +0100 (CET)
In-Reply-To: <CAPrbH=tQ3H1wUnK2417ap5jHSSO=y7vkBcCXBJqWn2V9sqbGHQ@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jason Mancine <jason@mancine.net>
List-Id: alsa-devel@alsa-project.org

On Monday 10 March 2014 14:36, Jason Mancine wrote:
> I am still working on trying to get the R16 to work for playback.

> So, the main question is how do I force ALSA to initialize this device at
> 24 bit integer?

Isn't the answer in Takashi's original reply...?

> >  On Dec 6, 2013 11:25 AM, "Takashi Iwai" <tiwai@suse.de> wrote:
> >> Do you mean the 24bit physical size, i.e. each frame is packed in 3
> >> bytes?  If so, you used a wrong format.  SNDRV_PCM_FMTBIT_S24_LE is
> >> for 24bit format packed in 32bit frame.  If you need a 3-bytes frame,
> >> use SNDRV_PCM_FMTBIT_S24_3LE instead.

Many USB devices have this...

>                                 .type = QUIRK_AUDIO_FIXED_ENDPOINT,
>                                 .data = & (const struct audioformat) {
>                                 .formats = SNDRV_PCM_FMTBIT_S24_LE,

                                 .formats = SNDRV_PCM_FMTBIT_S24_3LE,

instead.  That would apply for capture also.  Or is that what you have been 
trying?

Regards

Alan
