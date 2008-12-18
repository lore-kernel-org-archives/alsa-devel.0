From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [ASoC] TWL4030 underrun error
Date: Thu, 18 Dec 2008 14:21:09 +0200
Message-ID: <bd7b27490812180421s16f487a3k3ab55c4697544c30@mail.gmail.com>
References: <ef0d8a250812172119t4364194bw839d643c69fc5f3e@mail.gmail.com>
	<dfeb90390812172326w3a02227cicbfeb9d9b8a56db7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f20.google.com (mail-bw0-f20.google.com
	[209.85.218.20]) by alsa0.perex.cz (Postfix) with ESMTP id 046BA243E8
	for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2008 13:21:09 +0100 (CET)
Received: by bwz13 with SMTP id 13so1144219bwz.8
	for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2008 04:21:09 -0800 (PST)
In-Reply-To: <dfeb90390812172326w3a02227cicbfeb9d9b8a56db7@mail.gmail.com>
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
To: Arun KS <getarunks@gmail.com>
Cc: "naveenkrishna. ch" <naveenkrishna.ch@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 18, 2008 at 9:26 AM, Arun KS <getarunks@gmail.com> wrote:

> On Thu, Dec 18, 2008 at 10:49 AM, naveenkrishna. ch
> <naveenkrishna.ch@gmail.com> wrote:
> >
> > When i play with
> > aplay XXX.wav
> >
> > Rare but i used to get some underrun messages
> >  i found thses message are coming from aplay.
> >
> > underrun!!! (at least 10271.545 ms long)
> > underrun!!! (at least 904.663 ms long)
> > underrun!!! (at least 771.790 ms long)
> > underrun!!! (at least 3393.433 ms long)
> > underrun!!! (at least 777.314 ms long)
>
> Are you using nfs as filesystem?
> If yes, that may cause these errors. Try using flash and see whether
> you can reproduce.
>
>
Also "aplay /dev/zero" or "aplay /dev/urandom" are good sources for audio
testing :-)

Then you can exclude issues caused by the filesystem.


Jarkko
