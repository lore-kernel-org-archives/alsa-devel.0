From: Benny Sjostrand <gorm@cucumelo.org>
Subject: [Fwd: Re: Occasional metallic sound when recording (cs46xx)]
Date: Fri, 07 Nov 2003 00:36:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FAADAE2.9020106@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  Ops! my intention was to send this reply to the alsa-devel list!

/Benny

-------- Original Message --------
Subject: Re: [Alsa-devel] Occasional metallic sound when recording (cs46xx)
Date: Thu, 06 Nov 2003 23:11:21 +0100
From: Benny Sjostrand <gorm@cucumelo.org>
To: Takashi Iwai <tiwai@suse.de>
References: <200310221739.h9MHd0m1024945@oud.linuxaudiosystems.com> 
<3F981FF3.4040902@gmx.at> <87oew7g4m9.fsf@canaima.chapus.net> 
<s5h7k2u93l7.wl@alsa2.suse.de>



>
>
>then it sounds like the specific problem for cs46xx driver.
>i guess some drift occured during the sample rate conversion or so.
>please check whether the same symptom happens on 48000Hz ?
>
>  
>
Sorry that I've been lost from the list from a long time ...

Your right this sympton may be specific for the cs46xx, I've
been experiencing this sympton with JACK and Ardour several
times.

The sample rate should not matter.
My guess is that internal buffers occasionally get unsynchronized inside 
the DSP,  
may happen on playback too.

The only I've found to get around the problem when it happens is to
restart the playback or capturing process.

/Benny





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
