From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [alsa-cvslog] alsa-kernel: Official ALSA project
	GIT repository for Linux 2.6 branch,
	master now at v2.6.31-rc8-407-gfc9e4a3
Date: Thu, 25 Feb 2010 19:22:11 +0800
Message-ID: <4f3252891002250322j4b52791dgc659a2a60edff0e6@mail.gmail.com>
References: <20091006063609.B06E110381F@alsa0.perex.cz>
	<s5hab05role.wl%tiwai@suse.de> <4ACAF4AC.3000608@ladisch.de>
	<s5h4oqdrlys.wl%tiwai@suse.de> <4ACDCAAB.2060609@ladisch.de>
	<s5h1vlexesm.wl%tiwai@suse.de> <4ACDDD22.1050309@ladisch.de>
	<4B84EE72.4060707@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A0F6103962
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 12:22:12 +0100 (CET)
Received: by pvg16 with SMTP id 16so431035pvg.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 03:22:11 -0800 (PST)
In-Reply-To: <4B84EE72.4060707@ladisch.de>
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
List-Id: alsa-devel@alsa-project.org

> > > > jmal8295 wrote:
> > > > > And I _will_ be regarding it as regression if I lose possibility to
> > > > > change volume of the four streams independently.
> >
> > Okay, I'll see if I can extend alsamixer ...
>

you can try iface_pcm_v2.c in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1835

I only tested it  with the patched au88x0 driver
