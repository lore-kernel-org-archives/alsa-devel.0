From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: matrix mixer control (Re: Complex mixer questio
Date: Wed, 02 Apr 2003 12:39:33 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E190m6v-0005aI-00@sc8-sf-list1.sourceforge.net>
References: <Pine.LNX.4.44.0304021916210.3649-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 02 Apr 2003 19:18:34 +0200."
             <Pine.LNX.4.44.0304021916210.3649-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Abramo Bagnara <abramo.bagnara@libero.it>, Giuliano Pochini <pochini@shiny.it>, alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

>On Wed, 2 Apr 2003, Paul Davis wrote:
>
>> >Ortogonally to that, IMO the increasing numbers of controls in modern 
>> >professional hardware justify the choice of hash table access to 
>> >controls (try to imagine a 26 channel hardware level meter that need to 
>> >be polled 50 times per second).
>> 
>> TotalMix for the HDSP will not do that. Thomas is working on mapping
>> the meters into user space. Its not reasonable to do this via system
>> calls if you want to access them in an RT thread. As a fill-in measure
>> until that is done, I think he created a control that gets all the
>> values in a single system call.
>
>Why peak reading requires a RT-task? It's not time critical operation.

We're not talking about "metering" in the sense of visual display -
that's definitely not a real-time issue. But using the meter value can
be.  For example, JACK now makes port meter values available to
clients in their process() callbacks. Other native-ALSA applications
may want to use current meter values to affect their RT thread's
operation (e.g. threshold-gated recording initiation).

--p




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
