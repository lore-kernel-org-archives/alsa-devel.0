From: Jason Mancine <jason@mancine.net>
Subject: Re: Zoom R16
Date: Tue, 11 Mar 2014 09:34:14 -0400
Message-ID: <CAPrbH=uWAULPkgaZD1PKR+i_LkJ4FZ0irw07Cfxi9AacoCT7Xg@mail.gmail.com>
References: <CAPrbH=vnQ-xXsRDoj30nra7hB_hDEaF6u3ov0XuDG_ZpFzb3bA@mail.gmail.com>
 <CAPrbH=uHUhWMYiGcHKLwFYiWwGhahNqAWjio1RKECM_dUnNN6A@mail.gmail.com>
 <CAPrbH=tQ3H1wUnK2417ap5jHSSO=y7vkBcCXBJqWn2V9sqbGHQ@mail.gmail.com>
 <201403102028.41556.gineera@aspect135.co.uk>
 <CAPrbH=ufH_S7+zK80jNp8O4croqE8qGjbVNQ7eVUsQgDtZU9qA@mail.gmail.com>
 <s5htxb5fbyk.wl%tiwai@suse.de>
 <CAPrbH=tP2zLQnNFdbQ2gMhndJ_0nA7RWw6WJvhMAy5raeqBXGg@mail.gmail.com>
 <s5hr469f8zr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com
 [74.125.82.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 1896226179C
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 14:34:15 +0100 (CET)
Received: by mail-we0-f169.google.com with SMTP id w62so10179124wes.0
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 06:34:14 -0700 (PDT)
In-Reply-To: <s5hr469f8zr.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> My question is how did you check that the 32bit format is used.
> And, don't do top-posting.
>
>
> Takashi

Sorry, i am unsure how to not top post when replying via email.

With capture and playback .formats set to SNDRV_PCM_FMTBIT_S24_3LE, jack
log shows:

ALSA: final selected sample format for playback:  32bit integer
little-endian

and

/proc/asound/R16/stream0  shows:

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S32_LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 44100, 48000, 88200, 96000
    Data packet interval: 125 us

Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: S32_LE
    Channels: 8
    Endpoint: 4 IN (SYNC)
    Rates: 44100, 48000, 88200, 96000
    Data packet interval: 125 us



> > On Mar 11, 2014 3:09 AM, "Takashi Iwai" <tiwai@suse.de> wrote:
> >
> > > At Mon, 10 Mar 2014 16:44:19 -0400,
> > > Jason Mancine wrote:
> > > >
> > > > Yes, I have tried those .formats with no luck...it still
initializes at
> > > 32
> > >
> > > How did you check it?
> > >
> > >
> > > Takashi
> > >
> > > > On Mar 10, 2014 4:29 PM, "Alan Horstmann" <gineera@aspect135.co.uk>
> > > wrote:
> > > >
> > > > > On Monday 10 March 2014 14:36, Jason Mancine wrote:
> > > > > > I am still working on trying to get the R16 to work for
playback.
> > > > >
> > > > > > So, the main question is how do I force ALSA to initialize this
> > > device at
> > > > > > 24 bit integer?
> > > > >
> > > > > Isn't the answer in Takashi's original reply...?
> > > > >
> > > > > > >  On Dec 6, 2013 11:25 AM, "Takashi Iwai" <tiwai@suse.de>
wrote:
> > > > > > >> Do you mean the 24bit physical size, i.e. each frame is
packed in
> > > 3
> > > > > > >> bytes?  If so, you used a wrong format.
 SNDRV_PCM_FMTBIT_S24_LE
> > > is
> > > > > > >> for 24bit format packed in 32bit frame.  If you need a
3-bytes
> > > frame,
> > > > > > >> use SNDRV_PCM_FMTBIT_S24_3LE instead.
> > > > >
> > > > > Many USB devices have this...
> > > > >
> > > > > >                                 .type =
QUIRK_AUDIO_FIXED_ENDPOINT,
> > > > > >                                 .data = & (const struct
audioformat)
> > > {
> > > > > >                                 .formats =
SNDRV_PCM_FMTBIT_S24_LE,
> > > > >
> > > > >                                  .formats =
SNDRV_PCM_FMTBIT_S24_3LE,
> > > > >
> > > > > instead.  That would apply for capture also.  Or is that what you
have
> > > been
> > > > > trying?
> > > > >
> > > > > Regards
> > > > >
> > > > > Alan
> > > > >
> > > > _______________________________________________
> > > > Alsa-devel mailing list
> > > > Alsa-devel@alsa-project.org
> > > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > > >
> > >
> > [2  <text/html; ISO-8859-1 (quoted-printable)>]
> >
