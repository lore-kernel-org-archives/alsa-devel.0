From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: matrix mixer control (Re: Complex mixer questio
Date: Wed, 02 Apr 2003 12:40:54 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E190m8C-0005yb-00@sc8-sf-list1.sourceforge.net>
References: <3E8B1B70.2060505@libero.it>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 02 Apr 2003 19:18:40 +0200."
             <3E8B1B70.2060505@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Jaroslav Kysela <perex@suse.cz>, Giuliano Pochini <pochini@shiny.it>, alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

>Paul Davis ha scritto:
>>>Ortogonally to that, IMO the increasing numbers of controls in modern 
>>>professional hardware justify the choice of hash table access to 
>>>controls (try to imagine a 26 channel hardware level meter that need to 
>>>be polled 50 times per second).
>> 
>> 
>> TotalMix for the HDSP will not do that. Thomas is working on mapping
>> the meters into user space. Its not reasonable to do this via system
>> calls if you want to access them in an RT thread. As a fill-in measure
>> until that is done, I think he created a control that gets all the
>> values in a single system call.
>
>This open a more general problem for generic mmap support for controls, 
>but I think this is postponible.

or even just forgettable. i think that attempts to generalize this
stuff can go too far. whether this would be too far, i don't know.



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
