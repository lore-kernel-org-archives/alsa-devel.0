From: Thomas Klausner <tk@giga.or.at>
Subject: Re: portability patch: EBADF [was Re: feeding back
 pkgsrc changs]
Date: Wed, 24 Feb 2016 14:16:55 +0100
Message-ID: <20160224131655.GA22682@danbala.tuwien.ac.at>
References: <20160218154744.GA7454@danbala.tuwien.ac.at>
 <s5hy4ait3t8.wl-tiwai@suse.de>
 <20160223140906.GP19194@danbala.tuwien.ac.at>
 <sfid-H20160223-165403-+070.72-1@spamfilter.osbf.lua>
 <s5h4mczzals.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from danbala.ifoer.tuwien.ac.at (danbala.ifoer.tuwien.ac.at
 [128.130.168.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 80B582607F7
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 14:16:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h4mczzals.wl-tiwai@suse.de>
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


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 23, 2016 at 04:53:51PM +0100, Takashi Iwai wrote:
> On Tue, 23 Feb 2016 15:09:06 +0100,
> Thomas Klausner wrote:
> > Thanks for the answer.
> > 
> > On Thu, Feb 18, 2016 at 04:51:15PM +0100, Takashi Iwai wrote:
> > > On Thu, 18 Feb 2016 16:47:44 +0100,
> > > Thomas Klausner wrote:
> > > > I've just updated the pkgsrc packages for alsa-lib, alsa-utils and
> > > > alsa-plugins to 1.1.0 and noticed that there are quite a number of
> > > > local patches we have. I'd like to get them integrated.
> > > > 
> > > > When I visited the alsa-projects web page, I noticed that the link to
> > > > the bug tracker is dead.
> > > > 
> > > > What is the recommended method to provide the patches?
> > > 
> > > Just submit your patches to alsa-devel ML.  That's the best way to
> > > review and get merged.
> > 
> > I'll start with a straightforward one. Some operating systems don't
> > provide an errno 'EBADFD'; let's use EBADF there instead.
> > 
> > This patch adds the define in all files that need it, but if you
> > prefer to add it to a central place instead, please suggest one.
> 
> How about put this in include/local.h instead?  Then we need to put it
> only in one place, as this is supposed to be included by all codes.

Sounds good and works. New patch attached.
 Thomas

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Define-EBADFD-in-terms-of-EBADF-if-it-doesn-t-exist.patch"

>From ac054d580a774344adf2dcf198b50100a3f2967d Mon Sep 17 00:00:00 2001
From: Thomas Klausner <wiz@NetBSD.org>
Date: Wed, 24 Feb 2016 14:15:10 +0100
Subject: [PATCH] Define EBADFD in terms of EBADF if it doesn't exist.

For portability on FreeBSD, NetBSD and probably others.
---
 include/local.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/local.h b/include/local.h
index b429f5d..28ed106 100644
--- a/include/local.h
+++ b/include/local.h
@@ -53,6 +53,10 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
 
+#ifndef EBADFD
+#define EBADFD EBADF
+#endif
+
 #ifdef SUPPORT_RESMGR
 #include <resmgr.h>
 #endif
-- 
2.7.1


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--zYM0uCDKw75PZbzx--
