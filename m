From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 MIDI record
Date: Fri, 11 Feb 2005 14:44:43 -0500
Message-ID: <1108151083.20365.9.camel@krustophenia.net>
References: <1106091073.24484.60.camel@krustophenia.net>
	 <1106672990.27843.7.camel@radium.gaugetheory.org>
	 <1106678585.10845.8.camel@krustophenia.net>
	 <1108148630.4267.28.camel@radium.gaugetheory.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <1108148630.4267.28.camel@radium.gaugetheory.org>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Brian L Scipioni <brian@gaugetheory.org>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

IIRC it should work.  Could be a driver bug though.  So the MPU-401 #1
(the port on the card) definitely works but MPU-401 #2 (on the
livedrive) does not?

Lee

On Fri, 2005-02-11 at 14:03 -0500, Brian L Scipioni wrote:
> All, sorry for the repost - I'm still trying to get an answer as to why
> I cannot record from my keyboard to MIDI in.
> 
> I have alsa-1.0.8
> 
> My Audigy 2 Platinum handles MIDI playback either through the MIDI out
> to an external keyboard or through any of the 4 internal synth ports. 
> However, I have not been able to see any response whatever from an
> external synth on the MIDI in (front drive panel).  Is this known to not
> yet be working?
> 
> The specific duplex device is Audigy MPU-401 #2.  aplaymidi produces
> sounds on all listed devices, but arecordmidi (and other MIDI recording
> tools) are not working for me.
> 
> [brian@radium music]$ aplaymidi -l
>  Port    Client name                      Port name
>  64:0    Audigy MPU-401 (UART)            Audigy MPU-401 (UART)
>  64:32   Audigy MPU-401 (UART)            Audigy MPU-401 #2
>  65:0    Emu10k1 WaveTable                Emu10k1 Port 0
>  65:1    Emu10k1 WaveTable                Emu10k1 Port 1
>  65:2    Emu10k1 WaveTable                Emu10k1 Port 2
>  65:3    Emu10k1 WaveTable                Emu10k1 Port 3
> 128:0    Client-128                       qjackctl
> 129:0    ardour                           seq
> 130:0    Rosegarden                       Rosegarden input
> [brian@radium music]$ arecordmidi -l
>  Port    Client name                      Port name
>  64:0    Audigy MPU-401 (UART)            Audigy MPU-401 (UART)
>  64:32   Audigy MPU-401 (UART)            Audigy MPU-401 #2
> 129:0    ardour                           seq
> 
> thanks,
> brian
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Alsa-user mailing list
> Alsa-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-user
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
