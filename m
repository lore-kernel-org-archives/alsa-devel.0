From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Minor bug(s) in hdsp.c (RME HDSP driver)
Date: Sat, 19 Jul 2003 13:47:54 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19dvjH-0001Qh-00@sc8-sf-list1.sourceforge.net>
References: <200307191924.15922.torger@ludd.luth.se>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sat, 19 Jul 2003 19:24:15 +0200."
             <200307191924.15922.torger@ludd.luth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: Thomas Charbonnel <thomas@undata.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>The function hdsp_set_rate() returns -1 on error, which equals -EPERM. 
>snd_hdsp_hw_params() returns the return value of hdsp_set_rate() on 
>failure, thus if hdsp_set_rate() cannot be set, then -EPERM is coming 
>out of alsa-lib.

will fix.

>I also think that the behaviour of hdsp_set_rate() should change. If the 
>card is set to AutoSync, and there is no input signal, hdsp_set_rate() 
>will fail on line 888. In this case, I think the proper behaviour would 
>be to set the card in Master mode with the given rate.

seems sensible.

>At the same time I'd like to ask a question. The card I have on my hands 
>is a HDSP 9652 PCI card. I have noticed that it has some DSP mixer, and 
>that there are volume control settings in the driver. I want the card 
>to work just like a good ol' RME9652 (that is no volume control no 
>mixing, what comes in comes in, what goes out goes out), will it do 
>that per default, or do I have to raise some volume controls and do 
>other stuff to deactivate the mixer?

i nearly added an option to let it run like an rme9652, but didn't. if
you don't activate the mixer, you get rme9652-like behaviour. i can
add this, or you can. its very simple.

--p


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
