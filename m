From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: 2.5.50: sleeping function called from illegal context
Date: Tue, 03 Dec 2002 13:34:52 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18JHnw-0002ME-00@sc8-sf-list1.sourceforge.net>
References: <200212030657.45283.baldrick@wanadoo.fr>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 03 Dec 2002 06:57:45 +0100."
             <200212030657.45283.baldrick@wanadoo.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I guess another way of dealing with this kind of problem is to use a
>semaphore rather than a spinlock, and a workqueue: when the interrupt
>comes in, the call to snd_ctl_notify is put on the queue, where it will later
>be run in process context, and can safely take the semaphore.

can i get a pointer to some code that does this? we need to do this
for handling MIDI I/O in the hammerfall dsp driver. doing it from
the interrupt handler causes audio dropouts because the midi i/o is so
much slower.

--p


-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
