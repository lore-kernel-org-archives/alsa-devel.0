From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problem with RME 9632 and Plug
Date: Wed, 4 Aug 2004 12:53:53 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408041252140.1857@pnote.perex-int.cz>
References: <200408040018.i740ITg5017942@localhost.localdomain>
 <Pine.LNX.4.58.0408040935080.1857@pnote.perex-int.cz> <s5h8ycvqltj.wl@alsa2.suse.de>
 <Pine.LNX.4.58.0408041218030.1857@pnote.perex-int.cz> <4110BAE0.6070309@wildgooses.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4110BAE0.6070309@wildgooses.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ed Wildgoose <lists@wildgooses.com>
Cc: Takashi Iwai <tiwai@suse.de>, Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 4 Aug 2004, Ed Wildgoose wrote:

> Ahh, yes, I see now.  The max period size SHOULD be 8192.  For some 
> reason when I request anything larger than 2048, I only get 2048...  I 
> have tried asking for exactly 8192, and "_near" 8192 with the same results.
> 
> I will try giving the machine a reboot in case something has grabbed the 
> card and it's ended up in a funny state which might be causing this.  
> However, I can currently happily choose 512, 1024, and 2048 period 
> sizes, but nothing larger.

It's better to send us a dump from /proc/asound/card0/pcm0p/sub0/* files
to verify the correct values. But I guess that resampling might be 
involved, so the final frame count is smaller from the application view.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
