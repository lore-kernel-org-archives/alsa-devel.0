From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: capture with non-interleaved mode
Date: Tue, 14 Oct 2003 08:19:28 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310141219.h9ECJShP002900@oud>
References: <1066132614.3f8be48663f25@webmail.utbm.fr>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 14 Oct 2003 13:56:54 +0200."
             <1066132614.3f8be48663f25@webmail.utbm.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Cyril.Coquilleau@UTBM.fr" <Cyril.Coquilleau@utbm.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Hi. I'm developping a signal processing program which needs to compute data 
>from each channel of soundcards separately. 
>After searches I found that I must open the soundcard with the 
>SND_PCM_ACCESS_RW_NONINTERLEAVED flag but it doesn't works well : for each 
>readn operation i get the -32 error code . Meanwhile, I tested capture in 
>interleaved mode and it works well.
>I had to use hw:x,y for the interleaved capture and plughw:x,y for the non-
>interleaved capture, I don't know if non-interleaved capture works with hw:x,y.

[ We need a FAQ ... ]

ALSA's "hw" devices can only be used with parameters that match
capabilities offered by the underlying hardware. There's not much
hardware out there that supports non-interleaved I/O, so as a result,
most "hw" devices can't do this. The Hammerfall and ice1712 series are
notable exceptions. But there is a corollary: if you were using a
hammerfall, the "hw" device cannot do interleaved I/O either.

as to your error, its probably a bug in your code. JACK uses
non-interleaved mode by default, and it works with both plughw and hw
models of many different kinds. if you posted the relevant parts of it
here, somebody can probably help you.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
