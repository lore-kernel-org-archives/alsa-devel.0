From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: conversion of opti93x driver to use cs4231-lib
Date: Tue, 8 Jan 2008 16:15:28 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801081613320.22730@tm8103.perex-int.cz>
References: <20080107200801.008a3cc1.krzysztof.h1@poczta.fm>
	<s5hlk707dj7.wl%tiwai@suse.de> <478385D9.1000402@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 66E1424B14
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 16:15:29 +0100 (CET)
In-Reply-To: <478385D9.1000402@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>
List-Id: alsa-devel@alsa-project.org

On Tue, 8 Jan 2008, Rene Herman wrote:

> On 08-01-08 12:38, Takashi Iwai wrote:
> 
> Jaroslav -- do you know/remember why opti93x didn't use cs4231-lib?
> 
> > At Mon, 7 Jan 2008 20:08:01 +0100,
> > Krzysztof Helt wrote:
> >> Hi,
> >>
> >> I posted some time ago two patches which converts opti93x driver to use cs4231-lib library. 
> >>
> >> The opti93x chips are almost compatible with the cs4231 differing mostly by mixer.
> >>
> >> This change greatly reduces the source of the opti drivers.
> >>
> >> Here are patches:
> >> [addition of opti93x details to the cs4231-lib]
> >> http://mailman.alsa-project.org/pipermail/alsa-devel/2007-September/003395.html
> >>
> >> and 
> >> [conversion of opti93x driver to use cs4231-lib]
> >> http://mailman.alsa-project.org/pipermail/alsa-devel/2007-September/003396.html
> >>
> >> I will rediff the second patch as there were some changes to opti93x driver after sending the patch.
> >>
> >> If it is not a good idea to do such conversion, please reply and drop patches.
> > 
> > The only concern is whether this breaks the workign opti9xx stuff.
> > If someone can confirm it's OK, then I'm 100% for these patches.
> > 
> > Added Rene to Cc to hear his opinion.
> 
> Missed this one originally. I'll look into this in some detail but will 
> need a few days. Obviously, if it works, it's desirable. Maybe Jaroslav 
> knows why it's not that way now?

I think that it was opti driver author decision, but I also don't see any 
problem to use common code (if verified to be working, of course).

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
