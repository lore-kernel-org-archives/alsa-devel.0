From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Problem with RME 9632 and Plug
Date: Tue, 03 Aug 2004 20:18:29 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408040018.i740ITg5017942@localhost.localdomain>
References: <4110260F.3090705@wildgooses.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 04 Aug 2004 00:55:59 BST."
             <4110260F.3090705@wildgooses.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ed Wildgoose <lists@wildgooses.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>However, quick question.  Is it possible to create a virtual device 
>which will effectively change the default for period size if the app 
>doesn't specifically ask for something different (some asound.conf 
>magic?).  

as i mentioned, try using the pcm device name "plughw:N" where N
appropriate. 

	   Also is it possible to influence the defaults for the OSS 
>emulation...?

yes. but there are at two ways to do it. if mplayer or whatever has
ALSA support, better to get that working.

--p


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
