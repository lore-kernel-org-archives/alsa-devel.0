From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: How to open a device using ALSA API
Date: Fri, 02 Jul 2004 13:37:14 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407021737.i62HbEDr012850@localhost.localdomain>
References: <20040702171648.91434.qmail@web50402.mail.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 02 Jul 2004 10:16:48 PDT."
             <20040702171648.91434.qmail@web50402.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Guild Jackson <guildjackson@yahoo.com>
Cc: alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>#define AUDIO_DEVICE "/dev/dsp"

/dev/dsp and friends belong to the old OSS device drivers. try to
forget about them.

>err = snd_pcm_open(&audio_fd_repp, 
>			 (char*)device_name.c_str(),
>			 pcm_stream_rep,
>			 SND_PCM_NONBLOCK);
>
>I tried to figure out what is the device_name.c_str()

its the name of an ALSA device defined in either a system-wide or
per-user configuration file. typical system wide names:
	 
	 hw:0 = the first audio interface, accessed with only
	          the hw-supported capabilities of the device
         plughw:0 = the first audio interface, accessible with
	                more or less any parameters you request

         hw:1 = the second audio interface

there are many others. see asound.conf (use locate(1) to find it on
your system) and/or ~/.asoundrc.

btw: your program should *never* code the device name to be used. it
should always be left to the user to specify, and use "default" if
they do not specify anything.

--p

	 		  


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
