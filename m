From: Olek Poplavsky <woodenbits@gmail.com>
Subject: Re: [PATCH] sound/usb: Add Opus #3 to quirks for
	native DSD support
Date: Fri, 25 Jan 2019 14:14:44 -0500
Message-ID: <CAKgOoccLGUudn+kTRb-XW4QZ5YvF4n7KZYDAtPfqs9-mFx5Z6w@mail.gmail.com>
References: <CAKgOocdOAZuGH+-w6bh9AVKM642wWvhNP2HjPyWdSntz1QuDqg@mail.gmail.com>
 <s5hbm44zuk2.wl-tiwai@suse.de>
 <CAKgOocfiHFDhSJ7J1oaEA87bdMzLeNN4t6nKoF=DkJdCCR2pMA@mail.gmail.com>
 <s5hef90a8dx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by alsa0.perex.cz (Postfix) with ESMTP id B10032666B3
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 20:14:56 +0100 (CET)
Received: by mail-lf1-f66.google.com with SMTP id c16so7703610lfj.8
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 11:14:56 -0800 (PST)
In-Reply-To: <s5hef90a8dx.wl-tiwai@suse.de>
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

Sounds like a great plan, Takashi!

Yes, relationship between 'The Bit' and Eratech is very unclear... the
best I was able to find by searching around is that head of R&D at
'The Bit' seems to have been CEO of Eratech in the past...

Thank you!

-- Olek

On Fri, Jan 25, 2019 at 1:40 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 25 Jan 2019 19:30:03 +0100,
> Olek Poplavsky wrote:
> >
> > Thank you for your response, Takashi!
> >
> > Yes, the patch you are suggesting will work as well, it was actually
> > the first patch I tried. Both ways I was able to use native DSD
> > capability of my DAP/DAC.
> > The reason I went with more 'targeted' patch is that I am not sure if
> > 0x10cb is describing a family of similar devices, like 0x20b1
> > describes XMOS.
> > In cases like this I prefer to err on the side of caution, and
> > generalize only when there are two or three cases known to be in the
> > same family.
>
> OK, 10cb seems to be Eratech, which doesn't match with the vendor of
> your actual device.  It might be OK to put in the whitelist, but maybe
> at this time we can put to the explicit quirk entry.
>
> But then we should mark it to be whitelist-able, in case we'd want to
> move to there.
>
> I'll apply your patch with the update of the comment indicating it.
>
>
> thanks,
>
> Takashi
