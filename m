From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: dmix plugin
Date: Mon, 17 Feb 2003 13:15:48 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18kpnN-0001LM-00@sc8-sf-list1.sourceforge.net>
References: <Pine.LNX.4.44.0302171422050.1054-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 17 Feb 2003 14:22:52 +0100."
             <Pine.LNX.4.44.0302171422050.1054-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Jaroslaw Sobierski <fycio@gucio.com>, "abramo.bagnara@libero.it" <abramo.bagnara@libero.it>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>> Still, don't we already *have* a feeding thread for the sound card? I mean
>> it doesn't just grab the memory buffer all by itself whenever it wants?
>
>Nope. The idea for the dmix plugin is that we share the DMA ring buffer 
>with more threads (processes). There is no "master" thread which operates 
>exclusively with the DMA buffer.

that would be called "JACK", right ?

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
