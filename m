From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.10-rc2 on VAIO laptop and PowerMac 8500/G3
Date: Sat, 20 Nov 2004 14:11:42 -0500
Message-ID: <1100977903.6879.56.camel@krustophenia.net>
References: <E1CVYZM-0000Fi-00@penngrove.fdns.net>
	 <20041120185100.GA1205@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S263164AbUKTT1d@vger.kernel.org>
In-Reply-To: <20041120185100.GA1205@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: John Mock <kd6pag@qsl.net>, linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Please cc: alsa-devel on ALSA issues (we now allow posts from non
subscribers! :-P).

On Sat, 2004-11-20 at 19:51 +0100, Pavel Machek wrote:
> Hi!
> 
> > The software suspend issue was long and tedious to narrow down.  Yep, as
> > you suspected, it appears to be specific a driver (or group thereof).  It
> > appears to happen when the sound subsystem is included.  Attached below 
> > is the .config and a 'diff' from the losing one to one which works.
> 
> Okay, this is for the alsa team then. Somewhere between 2.6.10-rc1 and
> 2.6.10-rc2, ALSA started breaking swsusp :-(.
> 								Pavel
> 
-- 
Lee Revell <rlrevell@joe-job.com>
