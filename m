From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: channel map for intel8x0
Date: Mon, 4 Nov 2013 20:52:38 +0800
Message-ID: <CAN8ccia7Jy1KwUZ13yOmMjUMcPnN-R8M7SAZB-JnEPw4tURvmQ@mail.gmail.com>
References: <CAN8cciYP8HU3YkxZO0ruM7BbDRTPmvrSRr0FQSyqsS9gd21xDg@mail.gmail.com>
 <s5hwqkor0zt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f52.google.com (mail-pb0-f52.google.com
 [209.85.160.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 28A3F261AEC
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 13:52:41 +0100 (CET)
Received: by mail-pb0-f52.google.com with SMTP id rr4so602284pbb.11
 for <alsa-devel@alsa-project.org>; Mon, 04 Nov 2013 04:52:40 -0800 (PST)
In-Reply-To: <s5hwqkor0zt.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> > Refer to patch ALSA: Implement channel maps for standard onboard AC97
> > drivers
> >
> > e36e3b86c78cee9c7435eb33e0ef8a788193e812<
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/intel8x0.c?id=e36e3b86c78cee9c7435eb33e0ef8a788193e812
> >
> >
> > It seem that channal map is not working when testing with
> > alsa-lib/test/chmap.c with the emulated intel8x0 inside virtualbox
>
> What doesn't work actually?  The lack of chmap for the capture?
> Please give a bit more explanations about your problem.
>
>
 /alsa-lib/test$ ./chmap -Dhw:0,0 query
Cannot query maps

>
> - if (rec->ac97_idx == ICHD_PCMOUT && rec->playback_ops)
> +if (device == 0 && rec->playback_ops) {
>

after change the above line

/alsa-lib/test$ ./chmap -Dhw:0,0 query
Type = FIXED, Channels = 2
  FL FR

is there any option to test the channel map of the capture device ?


 ./chmap

usage: chmap [options] query
       chmap [options] get
       chmap [options] set CH0 CH1 CH2...
options:
  -D device     Specify PCM device to handle
  -f format     PCM format
  -c channels   Channels
  -r rate       Sample rate
