From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/3] ALSA: usb: move ua101 driver
Date: Mon, 1 Mar 2010 15:18:48 +0100
Message-ID: <20100301141848.GJ28972@buzzloop.caiaq.de>
References: <1267194883-6854-1-git-send-email-daniel@caiaq.de>
	<1267194883-6854-2-git-send-email-daniel@caiaq.de>
	<4B8BA4A3.1060506@ladisch.de>
	<20100301140129.GI28972@buzzloop.caiaq.de>
	<s5haaus16gu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B5F6103863
	for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2010 15:18:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5haaus16gu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 01, 2010 at 03:06:57PM +0100, Takashi Iwai wrote:
> At Mon, 1 Mar 2010 15:01:29 +0100,
> Daniel Mack wrote:
> > 
> > Ok, will do. However, I wonder which way is best to do that. Given that
> > you posted patches on top of mine, can I take this as a general
> > agreement to my changeset? If so, I will just provide a patch on top to
> > do the ua101 -> misc rename, because otherwise, I would have to rebase
> > all three patches for that.
> 
> Well, honestly, I prefer seeing the fixes by Clemens based on the
> current code, and merge Daniel's refactoring patches after 2.6.34
> merge window. 

Clemens fixes only make sense for v2 of the USB audio spec, which isn't
fully supported yet. IOW, the code as it will go into 2.6.34 is not able
to support that, with or without my refactoring. So rebasing them
doesn't make sense IMO.

> Refactoring is a good thing but it can easily introduce any careless
> bugs (like copy&paste error), and this split action makes really hard
> to track the changes.  Thus I'd like to keep this well ripened before
> reaching to the Linus tree, not only for a few days.

Yes, certainly. I didn't expect that to be taken for .34.

I would be fine with having it in a branch on your side, and getting
it merged to your for-next after any .34 issues are sorted out.

There will be quite some more patches to fully support the most common
features, but they won't be as intrusive and big of course.

Daniel
