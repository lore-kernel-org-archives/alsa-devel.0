From: Paul Davis <pbd@op.net>
Subject: Re: Re: alsalib symbol problem
Date: Tue, 17 Sep 2002 09:57:07 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17rIoq-0002eX-00@usw-sf-list1.sourceforge.net>
References: <87u1kolow9.fsf@zaphod.blackdown.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 17 Sep 2002 15:35:50 +0200."
             <87u1kolow9.fsf@zaphod.blackdown.de>
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

>> you probably are calling alsa from a shared object -- try 
>> 
>>   dlopen ("libasound.so", RTLD_LAZY | RTLD_GLOBAL);
>> 
>> in your module's init function.
>
>The need for RTLD_GLOBAL is somewhat ugly, usually one wants to load
>plugins with RTLD_LOCAL.  

the suggestion is not that *your* plugin should use RTLD_GLOBAL, but
that RTLD_GLOBAL needs to be used when alsa-lib is linked into the
address space.

if you don't use RTLD_GLOBAL, then the symbols in libasound are not
availble for subsequently-loaded dynamically linked code.

>Is there any reason ALSA can't do something like 
>
>   if (name == NULL) {
>       Dl_info dlinfo;
>       static int dummy;
>       dladdr((void *) &dummy, &dlinfo);
>       name = dlinfo.dli_fname;
>   }

perhaps because this implementation of dlopen is platform specific?
the dladdr function and the dlinfo structure are not present in
my version of glibc, at least not as far as i can tell.

--p


-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
