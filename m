From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Hammerfall DSP System Problems
Date: Thu, 05 Jun 2003 17:59:15 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19O2h2-00037N-00@sc8-sf-list1.sourceforge.net>
References: <7954491.1054848482159.JavaMail.java@localhost>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 05 Jun 2003 17:28:02 EDT."
             <7954491.1054848482159.JavaMail.java@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: frankgaetano@collegeclub.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>  I recently purchased a Hammerfall DSP system to use on Windows and 
>especially LINUX for use on Ardour. I have the multiface system. I 
>must say I am confused on the support of the newest version of this 
>pci card (I know that I have firmware version 11). I downloaded the 
>current CVS on alsa-dev and compiled it fine. However when I run 
>modprobe I get the following error: 

there are a number problems with the hdsp driver at present. fixing
them is mostly a matter of at least 1 of 3 people finding time to work
on it. however, your initial problems are different:
 
>Using /lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o 
>/lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o: unresolved 
>symbol snd_hammerfall_get_buffer_R5bab1fdf 

you don't have a version of the ALSA drivers compiled in a way that
will allow the kernel module system to work. you need to fix this
first. someone else will have to comment on how to do that. you should
probably specify which version of ALSA you are using since there are
many changes to ALSA all the time. it appears to me that you may have
a version of ALSA that doesn't build the rawmidi module that the hdsp
requires to support it. 

--p


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
