From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: access to GPLONLY symbol SNAFU?
Date: Tue, 04 Mar 2003 11:44:03 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18qFTV-0004q2-00@sc8-sf-list1.sourceforge.net>
References: <s5hptp7f61l.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 04 Mar 2003 17:30:30 +0100."
             <s5hptp7f61l.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>> good first guess, but no luck. i uninstalled it, reinstalled modutils
>> 2.4.9, and the same problem occurs.
>
>modutils-2.4.9 is fairly old..  isn't it 2.4.19?

GACK!! this is what happens when the output of ftp's "ls" command
scrolls off the screen, and you conclude that 2.4.9 is the latest. 

reinstalling 2.4.19 fixes the problem. thanks takashi!

--p


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
