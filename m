From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
Subject: Re: Occasional metallic sound when recording (cs46xx)
Date: Thu, 23 Oct 2003 20:37:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F981FF3.4040902@gmx.at>
References: <200310221739.h9MHd0m1024945@oud.linuxaudiosystems.com>
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
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: "Eloy A. Paris" <peloy@chapus.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
>>This problem happens randomly but is very annoying, specially if I
>>program my PVR (MythTV) to automatically record a show - the show can
>>get recorded with metallic sound, which makes it very hard to understand
>>during playback.
>>
>>This is not MythTV-specific since I have been able to reproduce the
>>problem using other applications, like the Gnome sound recorder. It is
>>unrelated to full-duplex operation since when recording a show MythTV
>>doesn't open /dev/dsp for writing.
>>
>>I really have no idea about how to troubleshoot this. I don't think
>>the problem is hardware, but is driver-related instead.
> 
> 
> its almost certainly a software problem in mythTV and gnome sound
> recorder. i've written code that does this several times - every time
> it takes me ages to figure out why, and then i can never remember when
> i do it the next time. its related to off-by-1 errors in processing
> incoming audio.

i also have the same problem with speakfreely with my cs46xx. it does 
not look like the metallic sound is triggered by any specific event 
(load, I/O,...). out of the sudden somethings goes wrong. i think i also 
experienced it with the kde sound recorder. but i have not updated the 
alsa driver for a while (still 0.9.5 or so). toggleing the ADC sounds 
like a good idea. i have not tried that yet but reloading the modules 
works too.

> 
> not necessarily, of course, just a point of view.

hmm, what makes something sound metallic anyway? echo?

bye,
wilfried




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
