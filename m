From: "Ivan N. Zlatev" <contact@i-nz.net>
Subject: Re: Intel HD SigmaTel STAC9221 - Wrong input after
	output change
Date: Tue, 29 May 2007 16:43:37 +0100
Message-ID: <3db1ec7f0705290843k7ef82381g3c76dc9b42d27583@mail.gmail.com>
References: <3db1ec7f0705271533m440de9bci6513c4c6453c5e16@mail.gmail.com>
	<s5h8xb71xgi.wl%tiwai@suse.de> <s5h3b1f1wbv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id AF18324393
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 17:43:42 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so575861ana
	for <alsa-devel@alsa-project.org>; Tue, 29 May 2007 08:43:38 -0700 (PDT)
In-Reply-To: <s5h3b1f1wbv.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On 5/29/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 29 May 2007 17:06:05 +0200,
> I wrote:
> >
> > At Sun, 27 May 2007 23:33:27 +0100,
> > Ivan N. Zlatev wrote:
> > >
> > > Hello,
> > >
> > > I am on an iMac ("*imac-20" model/pinconfig) with a Intel HD card with
> > > the SigmaTel STAC9221 codec. I have attached the inital codec info
> > > after modprobe. When I plug in and then unplug my speakers the
> > > microphone stops working. Reproduction steps with codec dump diffs as
> > > follows
> >
> > I guess you can restore the status via toggling "Line In as Output
> > Switch" and "Mic as Output Switch" mixer elements.  The problem looks
> > like the unsolicited event handling.  It doesn't cope with the shared
> > input jacks well.
>
> In case my guess is correct, the patch below should fix the problem.
> Give it a try.
>

*Thumbs up!* Works, thanks!

-- 
Ivan N. Zlatev

Web: http://www.i-nZ.net
"It's all some kind of whacked out conspiracy."
