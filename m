From: karsten wiese <annabellesgarden@yahoo.de>
Subject: Re: usx2y nightmare
Date: Wed, 6 Oct 2004 11:11:25 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041006091125.83202.qmail@web12205.mail.yahoo.com>
References: <1097023122l.2120l.2l@Zeryn>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1097023122l.2120l.2l@Zeryn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Antonio Willy Malara <behappy@maialone.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Antonio Willy Malara <behappy@maialone.com> schrieb: 
> i've tried to apply the karsten's patches but i cant
> manage to get the  
> kernel compiling, here's what i've done:
> 
> * got vanilla 2.6.8.1
> * patched with patch-2.6.9-rc3
> * untarred the usx2y_0.8.2+linux-2.6.9-rc2-mm4-S7.tar.gz
> and copied
>   to the kernel tree
> * configured and compiled the kernel
> 
> but there's something i've missed, because:
> 
> [...]
>   LD [M]  sound/usb/snd-usb-lib.o
>   LD      sound/usb/usx2y/built-in.o
>   CC [M]  sound/usb/usx2y/usbusx2y.o
>   CC [M]  sound/usb/usx2y/usbusx2yaudio.o
>   CC [M]  sound/usb/usx2y/usX2Yhwdep.o
>   CC [M]  sound/usb/usx2y/usx2yhwdeppcm.o
>   LD [M]  sound/usb/usx2y/snd-usb-usx2y.o
> sound/usb/usx2y/usx2yhwdeppcm.o(.text+0x174c): In
> function  
> `usX2Y_audio_create':
> : multiple definition of `usX2Y_audio_create'
> sound/usb/usx2y/usbusx2yaudio.o(.text+0x174c): first
> defined here
> make[3]: *** [sound/usb/usx2y/snd-usb-usx2y.o] Error 1
> make[2]: *** [sound/usb/usx2y] Error 2
> make[1]: *** [sound/usb] Error 2
> make: *** [sound] Error 2
> 
> someone can help me having a clue with all those patches?
> :)
> 
The usx2y_0.8.2+linux-2.6.9-rc2-mm4-S7.tar.gz's Makefile
sound/usb/usx2y/Makefile is wrong.
Delete the "usbusx2yaudio.o" in its first line.
(That patch includes usbusx2yaudio.c in usx2yhwdeppcm.c,
thus an individual build of usbusx2yaudio.o is erm... too
much)

Best regards,
Karsten




	

	
		
___________________________________________________________
Gesendet von Yahoo! Mail - Jetzt mit 100MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
