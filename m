From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Problem with RME 9632 and Plug
Date: Tue, 03 Aug 2004 13:32:29 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408031732.i73HWTYg006521@localhost.localdomain>
References: <410FBB6E.5010003@wildgooses.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 03 Aug 2004 17:21:02 BST."
             <410FBB6E.5010003@wildgooses.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ed Wildgoose <lists@wildgooses.com>
Cc: alsa-devel@lists.sourceforge.net, thomas@undata.org
List-Id: alsa-devel@alsa-project.org

>Hmm, looking through the 9632 driver code I notice things like:
>
>static snd_pcm_hardware_t snd_hdsp_playback_subinfo =
>{
> ..snip ...
>        .periods_min =          2,
>        .periods_max =          2,
>
>
>Hmm, oh dear.  Perhaps this driver only allows two periods...?  I could 
>have sworn that I was using more than this before though..?  Is there 
>any kind of fixup performed at the alsa level which emulates having more 
>periods than this...?

just test "plughw:0" assuming the 9632 is your initial card, or
"plughw:N" for others.

yes, the "hw" device requires 2 and only 2 periods. its a h/w design.

--p




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
