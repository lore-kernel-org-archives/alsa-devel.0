From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: access to GPLONLY symbol SNAFU?
Date: Tue, 04 Mar 2003 11:09:14 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18qEvh-0000x8-00@sc8-sf-list1.sourceforge.net>
References: <Pine.LNX.4.44.0303041646420.2089-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 04 Mar 2003 16:48:34 +0100."
             <Pine.LNX.4.44.0303041646420.2089-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>> module-init-tools 0.9.10
>  ^^^^^^^^^^^^^^^^^
>
>Probably bug in this package. I don't know the exact status of modules in 
>2.5 (it's dramaticaly changing), but all ALSA modules are GPLed, thus this 
>problem shouldn't occur.

good first guess, but no luck. i uninstalled it, reinstalled modutils
2.4.9, and the same problem occurs. i don't understand how this
happens: the kernel image contains only vmalloc_to_page, but
/proc/ksyms has only the GPL version. i was hoping that someone with
even more experience of this than i might have an idea what has gone
wrong. it all works under 2.5 BTW, but i can't use 2.5 right now
because the main serial driver is broken.


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
