From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: underruns and strange code in pcm_rate.c
Date: Fri, 9 Nov 2007 15:11:12 -0500
Message-ID: <75b66ecd0711091211o9e1297em391d7091c5d51931@mail.gmail.com>
References: <472E5A64.6010705@aknet.ru> <4732097E.3040401@aknet.ru>
	<s5htznx9znk.wl%tiwai@suse.de> <4732C455.7040503@aknet.ru>
	<s5hd4ulthy3.wl%tiwai@suse.de> <473488CA.7050308@freescale.com>
	<4734A448.7000909@aknet.ru> <4734BA93.6040900@freescale.com>
	<4734BC5F.8040800@aknet.ru> <4734BDD1.9080103@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (unknown [209.85.198.185])
	by alsa0.perex.cz (Postfix) with ESMTP id B1ACE243E1
	for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2007 21:11:14 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so451196rvb
	for <alsa-devel@alsa-project.org>; Fri, 09 Nov 2007 12:11:12 -0800 (PST)
In-Reply-To: <4734BDD1.9080103@freescale.com>
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
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Nov 9, 2007 3:06 PM, Timur Tabi <timur@freescale.com> wrote:
> Stas Sergeev wrote:
> > Timur Tabi wrote:
> >> How can I tell that my /etc/asound.conf is actually loaded and used?
> > Write some total crap into it, and
> > if the sound stops working, then it
> > is definitely used. :)
>
> It looks like it's not being used.  I also tried ~/.asoundrc and that didn't
> make a difference either.  When is /etc/asound.conf supposed to be loaded?  I
> must be missing something fundamental here.  I'm running ALSA 1.0.14 and my
> libasound is 2.0.0.

Did you install all of libasound properly including the config files
in /usr/share/alsa?

How are you testing?

Lee
