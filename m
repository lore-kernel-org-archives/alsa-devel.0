From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Minor bug(s) in hdsp.c (RME HDSP driver)
Date: Mon, 21 Jul 2003 20:27:20 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19ekuS-0007lL-00@sc8-sf-list1.sourceforge.net>
References: <1058825453.3f1c64ed6de45@scorpio.lunarpages.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 21 Jul 2003 15:10:53 PDT."
             <1058825453.3f1c64ed6de45@scorpio.lunarpages.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@robdye.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Quoting Paul Davis <paul@linuxaudiosystems.com>:
>
>> >I also think that the behaviour of hdsp_set_rate() should change. If the 
>> >card is set to AutoSync, and there is no input signal, hdsp_set_rate() 
>> >will fail on line 888. In this case, I think the proper behaviour would 
>> >be to set the card in Master mode with the given rate.
>> 
>> seems sensible.
>> 
>
>I disagree.  If the card is set to AutoSync and there is no input

on 2nd thoughts, so do i. more concisely, if the sync source is
AutoSync, then any call to hdsp_set_rate(0 should fail, independently
of whether there is a sync-able input signal or not.

--p


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
