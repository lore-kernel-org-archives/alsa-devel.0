From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problem with RME 9632 and Plug
Date: Wed, 4 Aug 2004 09:39:08 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408040935080.1857@pnote.perex-int.cz>
References: <200408040018.i740ITg5017942@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200408040018.i740ITg5017942@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Ed Wildgoose <lists@wildgooses.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 3 Aug 2004, Paul Davis wrote:

> >However, quick question.  Is it possible to create a virtual device 
> >which will effectively change the default for period size if the app 
> >doesn't specifically ask for something different (some asound.conf 
> >magic?).  
> 
> as i mentioned, try using the pcm device name "plughw:N" where N
> appropriate. 

It won't help. We don't convert count of periods in the plug plugin.
The only one solution is that the application will start using
an external timing source for PCM (see set/get_tick_time functions)
- or another timer available for applications - in this case when 
hardware has this constraint.

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
