From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Debugging driver modules
Date: Sat, 30 Nov 2002 12:38:20 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18IBVD-0004hD-00@sc8-sf-list1.sourceforge.net>
References: <1038695263.19113.12.camel@vermin2.joe.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "30 Nov 2002 16:27:43 CST."
             <1038695263.19113.12.camel@vermin2.joe.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: sbahling@mudgum.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I have a STAudio DSP24 mkII and I have noticed that recent changes(after
>NOV 13) in the CVS creates an ICE1712 driver that locks up my kernel.
>Instead of just complaining about this problem I thought I might try to
>narrow down the location in the driver that is causing the lockup.
>
>Does anyone have any tips on debugging the driver modules? Is anyone
>using a debugger to do this? I have looked at UML, but I am not sure if
>there is a way to access the sound hardware with it.

use the "single" kernel option on the boot command line. this will
shorten start up times considerably. once you're at the shell prompt,
mount any necessary filesystems by hand, modprobe the drivers, and
test using a console window. i generally find that this shortens the
crash-reboot-edit-recompile-reboot-crash cycle by a factor of at least
three. mount any filesystems that don't need to be writable with the
"ro" option so that any crash leaves them untouched.

the debugging process i use for drivers and real-time threads makes
heavy use of binary search and print{k,f}

--p


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
