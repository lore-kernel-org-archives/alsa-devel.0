From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Could we get the card name in
	/sys/clas/sound/card0/name?
Date: Tue, 20 Jan 2009 10:03:03 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0901200959530.8466@tm8103.perex-int.cz>
References: <20090120024123.GA30218@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id B62ED103800
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 10:03:03 +0100 (CET)
In-Reply-To: <20090120024123.GA30218@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Jan 2009, Lennart Poettering wrote:

> Heya!
> 
> Hmm, it would be nifty if we could get the alsa card name (i.e. the
> one shown in [] in /proc/pcm/cards) as an attribute file in
> /sys/class/sound/cardX/name. Even more useful would be if this
> property would be writable so that the cards may be renamed during
> runtime.
> 
> This could be very useful to establish stable card names via udev
> rules, similar to what is already done to network interface names
> ("eth0", ...).
> 
> Would such a change be acceptable?

It's already implemented in our recent repositories (the change will be 
in 2.6.29):

Author: Jaroslav Kysela <perex@perex.cz>
Date:   Tue Nov 11 16:51:02 2008 +0100

    ALSA: add /sys/class/sound/card#/id (r/w) and card#/number (r/o) files

    For udev, we need a way to rename soundcard names. The soundcard numbers
    (indexes) are hardwired but we have a text identification which can be
    changed at run-time. The ALSA user space tools already allow using of
    this text identification.

    Signed-off-by: Jaroslav Kysela <perex@perex.cz>
    Signed-off-by: Takashi Iwai <tiwai@suse.de>

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
