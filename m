From: "Christian Kujau" <evil@g-house.de>
Subject: Re: Oops in 2.6.10-rc1
Date: Sun, 7 Nov 2004 14:10:34 +0100
Message-ID: <20041107130553.M49691@g-house.de>
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz> <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de> <418D7959.4020206@g-house.de> <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org>
Reply-To: evil@g-house.de
Mime-Version: 1.0
Content-Type: text/plain;
	charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261610AbUKGNKu@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Sat, 6 Nov 2004 23:02:28 -0800 (PST), Linus Torvalds wrote
>
> Since you seem to be a BK user, try doing a

s/BK user/BK beginner/

> 
> 	bk revtool sound/pci/ens1370.c
> 
> and see if you can find the change that caused your problem.

hm, i already found the ChangeSet (ChangeSet@1.2000.7.1), but it seems
the ChangeSets get renumbered when linux makes progress. the issuer of
this changeset did not comment yet.

> Of course, the real change might be somewhere else in the 
> sound driver initialization path, so it's not like just that 
> one file might be the cause. Regardöess, the more you can 
> pinpoint when the problem started, the better.

yes.

> 
> Also, if you enable frame pointers (under kernel debugging), 
> the traceback will look a bit better. As it is, your oops 

ah, ok, will do.

thank you for your time,
Christian.
-- 
BOFH excuse #206:

Police are examining all internet packets in the search for a
narco-net-trafficker
