From: Paul Davis <pbd@op.net>
Subject: Re: alsalib symbol problem
Date: Tue, 17 Sep 2002 10:22:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17rJDb-0004Qd-00@usw-sf-list1.sourceforge.net>
References: <87n0qgln86.fsf@zaphod.blackdown.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 17 Sep 2002 16:11:53 +0200."
             <87n0qgln86.fsf@zaphod.blackdown.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Juergen Kreileder <jk@blackdown.de>
Cc: Tim Goetze <tim@quitte.de>, Florian Bomers <Florian.Bomers@sun.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Paul Davis <pbd@op.net> writes:
>
>>>> you probably are calling alsa from a shared object -- try 
>>>> 
>>>>   dlopen ("libasound.so", RTLD_LAZY | RTLD_GLOBAL);
>>>> 
>>>> in your module's init function.
>>>
>>>The need for RTLD_GLOBAL is somewhat ugly, usually one wants to load
>>>plugins with RTLD_LOCAL.  
>> 
>> the suggestion is not that *your* plugin should use RTLD_GLOBAL, but
>> that RTLD_GLOBAL needs to be used when alsa-lib is linked into the
>> address space.
>
>Ah, I haven't tried to dlopen libasound in a plugin yet.  Up to now
>I've linked the plugin lib with -lasound, in that case you have dlopen
>the plugin lib with RTLD_GLOBAL.

the problem is that libasound itself calls dlopen(), and the initial
(non-RTLD_GLOBAL) linkage hasn't put libasound's symbol into the
global namespace. hence, libasound's own dlopen'ed code can't access
libasound itself.

that's why you either either need to use RTLD_GLOBAL on the plugin
lib, or make sure that libasound alone is linked with RTLD_GLOBAL.

dynamically linking code that is linked to other code that dynamically
links code is, ahem, a little complex ;)

--p


-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
