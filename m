From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [RFC] re-queuing usx2y-fw
Date: Fri, 1 Apr 2005 12:26:12 +0200
Message-ID: <20050401102612.GA7037@tuba>
References: <20050328155151.GA3552@tuba> <s5hfyyeijh8.wl@alsa2.suse.de> <20050329165816.GA2696@tuba> <s5h7jjqidv3.wl@alsa2.suse.de> <20050331115848.GA13462@tuba> <s5hvf77erzo.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 19957239
	for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2005 12:25:30 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <s5hvf77erzo.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 31, 2005 at 05:48:27PM +0200, Takashi Iwai wrote:
> At Thu, 31 Mar 2005 13:58:48 +0200,
> Martin Langer wrote:
> > On Tue, Mar 29, 2005 at 07:03:12PM +0200, Takashi Iwai wrote:
> > > At Tue, 29 Mar 2005 18:58:16 +0200,
> > > Martin Langer wrote:
> > > > On Tue, Mar 29, 2005 at 05:01:55PM +0200, Takashi Iwai wrote:
> > > > > At Mon, 28 Mar 2005 17:51:51 +0200,
> > > > > Martin Langer wrote:
> > > > > > 
> > > > > > The code still depends on as31 (8031/8051 
> > > > > > crosss-assembler) which still isn't available as .rpm or .deb, at least 
> > > > > > newer versions since 2.1. Should we care about it?
> > > > > 
> > > > > For convenience, we may include both the firmware source and binary in
> > > > > the CVS repository, so that one can install even without as31.
> > > > 
> > > > Yep. I will try to introduce a new configure option like 
> > > > '--enable-buildfw' for it, or any similar solution.
> > > 
> > > That'll be nice.
> > 
> > Here it is. The new configure option for alsa-firmware is called 
> > '--enable-buildfw'. If you want to build it from source you have to 
> > install one of the latest versions of as31, which you can find at
> > 
> > http://wiki.erazor-zone.de/doku.php?id=wiki:projects:linux:as31
> > 
> > (e.g. version 2.3.0 is fine)
> 
> Thanks, I added it to CVS now.
> 
> Could you prepare some document about as31?
> Just mention the above in README of usx2yloader would suffice.

Of course, also including a small GPL copyright note.

martin

Summary: text added for building usx2y-fw from source file
Signed-off-by: Martin Langer <martin-langer@gmx.de>

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="readme.patch"

Index: README
===================================================================
RCS file: /cvsroot/alsa/alsa-firmware/usx2yloader/README,v
retrieving revision 1.2
diff -u -r1.2 README
--- README	8 Apr 2004 16:48:46 -0000	1.2
+++ README	1 Apr 2005 10:15:13 -0000
@@ -5,8 +5,26 @@
 utility in alsa-tools package.  Install this with the same prefix
 option as you used for alsa-tools.
 
+BUILDING FIRMWARE FROM SOURCE
+=============================
+
+Building the firmware from source is possible, if you use the 
+configure option --enable-buildfw. Also, it requires the 8031/8051
+cross-assembler as31. As31 version 2.3.0 is fine for this job, but 
+every version since 2.2 should do it.
+
+As31 is available from:
+http://wiki.erazor-zone.de/doku.php?id=wiki:projects:linux:as31
+
+At the moment it's only possible to build tascam_loader.ihx from 
+source.
+
 COPYRIGHT
 =========
 
+tascam_loader.ihx, tascam_loader.asm and an2131.asm:
+Available under GPL without restrictions.
+
+other firmware files:
 Copyright (c) 2003 Tascam / TEAC Corporation.
 Distributable under GPL.

--3MwIy2ne0vdjdPXF--


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
