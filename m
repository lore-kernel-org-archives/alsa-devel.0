From: "Dr. med. =?iso-8859-1?q?G=FCnther?= Montag" <Safari.Doktor@addcom.de>
Subject: Re: [Hfterm-hackers] Re: ham radio OSS duplex realtime mmap program.
Date: Tue, 30 Sep 2003 13:35:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309301335.20111.Safari.Doktor@addcom.de>
References: <200309251628.48034.Safari.Doktor@addcom.de> <3F74525B.4050805@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F74525B.4050805@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>, alsa-devel@lists.sourceforge.net, hfterm-hackers@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Freitag 26 September 2003 16:51 schrieb James Courtier-Dutton:
>
> I thought all ham radio was half duplex. i.e. You listen and decode, and
> then transmit if needed. i did not think the listen and transmit worked
> at the same time.
> So, in theory, one could have 2 threads.
> One receiving audio data, one decoding it, and if the decoder needs to
> transmit anything it stops the receiving thread, and starts a transmit
> thread. There is enough time to close and then open the sound device
> between receive and transmit, so the sound card should never have to
> work in full duplex mode.
>
> Cheers
> James
Hello James,
Yes, mostly it is so, but this program has 2 functions in it, one 
"hdx_driver", halfduplex, like You say above, for soundcards that can only do 
half duplex. It measures time for switching, with my soundblaster 16 about 32 
milliseconds, and tells me to make my tx delay a bit bigger.
The other, I posted it, does not switsch the soundcard, but keeps it open 
always, thus saving time for txdelay, which may be good for pactor in case of 
long distance if we have to calculate light speed (the window between 2 
packets is about 125 ms).

cheers

Safari.Doktor@addcom.de


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
