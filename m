From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp multiface pci.
Date: Wed, 22 Jan 2003 13:19:16 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301221814.h0MIEnx0013504@spider.tela.com>
References: <m3znpvhi19.fsf@grouper.coelacanth.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "20 Jan 2003 12:01:38 EST."
             <m3znpvhi19.fsf@grouper.coelacanth.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Roger Williams <raw@qux.com>
Cc: markknecht@attbi.com, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>This would explain why snd_hdsp works (i.e. you can playback and
>record through the default I/O), although amixer doesn't do anything:
>the driver doesn't have to set up any default connections, because
>those are part of the FPGA reset state.  I would be surprised if

actually, the driver does have to set up default connections, which
are zero gain for every possible routing unless the line_outs_monitor
option is set to a non-zero value. in that case, all h/w input streams
and all s/w playback streams are routed at unity gain to the two line
out channels, with stereo assignment following an odd->left,
even->right mapping.

as i've told mark independently, the hdsp-9652 has different register
assignments for the mixer, and until recently i did not have that
information from rme. the hdsp-9652 effectively has no mixer at this
time on linux.

--p


-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
