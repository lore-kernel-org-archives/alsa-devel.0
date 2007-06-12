From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: Shutdown() vector in ALSA
Date: Tue, 12 Jun 2007 16:01:13 +0530
Message-ID: <8d6898730706120331p52939770o9cbf4aa8a10bec56@mail.gmail.com>
References: <8d6898730706120156v6e8e95c6xb2d3878078465f08@mail.gmail.com>
	<s5hwsy9pmfa.wl%tiwai@suse.de> <466E644C.4030405@superbug.co.uk>
	<s5htztdpm11.wl%tiwai@suse.de>
	<8d6898730706120257u155e0124k75f6e00f19c0e996@mail.gmail.com>
	<466E7507.6060101@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by alsa0.perex.cz (Postfix) with ESMTP id BE570103844
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2007 12:31:14 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so1441638nzf
	for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2007 03:31:13 -0700 (PDT)
In-Reply-To: <466E7507.6060101@superbug.co.uk>
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
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

If that is the case then i feel it is better to implement shutdown() vector.

On 6/12/07, James Courtier-Dutton <James@superbug.co.uk> wrote:
> Nobin Mathew wrote:
> > In ubuntu this script mutes all mixer controls.
> >
> > So there will be no noise (pop/clicks) during shutdown.
> >
>
> That is not always true. Sound cards can still pop/clicks on power down,
> even with muted mixer controls.
>
> James
>
