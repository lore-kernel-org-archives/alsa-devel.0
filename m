From: Pavel Machek <pavel@suse.cz>
Subject: Re: driver model type fixes for ALSA
Date: Sat, 29 Jan 2005 01:04:40 +0100
Message-ID: <20050129000439.GA11050@elf.ucw.cz>
References: <20050128183559.GA9199@elf.ucw.cz> <s5hfz0lmij3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from amd.ucw.cz (gprs223-159.eurotel.cz [160.218.223.159])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 211671F9
	for <alsa-devel@alsa-project.org>; Sat, 29 Jan 2005 01:04:50 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <s5hfz0lmij3.wl@alsa2.suse.de>
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
Cc: perex@suse.cz, alsa-devel@alsa-project.org, linux-pm@osdl.org
List-Id: alsa-devel@alsa-project.org

Hi!

> > suspend() routines no longer get u32 as their parameter (they get
> > pm_message_t, which is u32 for now, but will change in 2.6.12 or
> > so). This fixes ALSA to notice this, and uses constants with right
> > types where appropriate. It results in no code changes. [Best results
> > will be when patching against latest -mm, you may get some warnings if
> > you patch it into older kernel, but it should still do the right
> > thing.] Please apply,
> 
> Thanks, I changed the whole ALSA tree based on your patch.

Thanks.

> But the fix to OSS drivers (sound/oss/*) is out of my hands.
> Could you split it out and pass it separately?

Okay, no problem, that means it goes directly to akpm...
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
