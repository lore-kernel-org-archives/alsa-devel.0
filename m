From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: dmix plugin
Date: Wed, 12 Feb 2003 07:57:33 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302121253.NAA04985@alsa.alsa-project.org>
References: <Pine.LNX.4.44.0302121015420.14550-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail09.voicenet.com (mail09.voicenet.com [207.103.0.43])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id NAA04985
	for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2003 13:53:25 +0100
In-reply-to: Your message of "Wed, 12 Feb 2003 10:45:41 +0100."
             <Pine.LNX.4.44.0302121015420.14550-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>	a next step to get the lowlatency sharing of exclusive PCM devices 
>is in ALSA CVS - the dmix (direct mixing) plugin..
>	How it works? Basically, the playback in driver runs forewer
>without any xrun detection. The ring buffer (only just played areas) is
>also silenced in each interrupt. Then we have multiple clients and a
>process (server) which passes the file descriptor of playback devices to
>them. The server also takes care about freeing of used shm memory and
>semaphore.
>	The big step forward is that we share one mmaped ring buffer
>accross many processes and each process can add samples into it without
>any process<->kernel swaps. Also, each processes are independant, thus
>failing of one doesn't break others. It's not multithreaded, we don't need
>this mechanism.

this all sounds fabulous, but could you explain a little about what is
actually going on here? i'd like to understand the
architecture/mechanism a little more deeply in ways that reading the
source probably won't provide. 

this will be a godsend for consumer audio apps, thats for sure!

--p


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
