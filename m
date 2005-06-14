From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: emu10k1, sound blaster audigy two zs and digital output
Date: Tue, 14 Jun 2005 23:42:52 +0100
Message-ID: <42AF5D6C.4060502@superbug.co.uk>
References: <Pine.LNX.4.63.0506141947300.17981@localhost> <42AF208B.3020908@superbug.co.uk> <Pine.LNX.4.63.0506150013020.8393@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0506150013020.8393@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: edoardo <edoardo@lastorina.it>
Cc: alsa users list <alsa-user@lists.sourceforge.net>, alsa developers' list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

edoardo wrote:
> 
> hi gals, hi dudes : )
> 
> so now i seem to have found a way to connect my digital out to the dolby
> digtal system digital in. finally : ) what conerns me is xine. i set it
> up to use alsa and five point one dolby digital, but i ran a vob ac3
> test file and only the front left and front right speakers seem to work.
> so i played a dvd, and the audio seems pretty good. i mean, all of the
> speakers seem to work, including the subwoofer.
> 
> so i'm includin' my xine config file, in case you can point me out to
> the right tweaks i need to set up a good five point one dolby digital.
> thankyou! : )
> 
> ciao! : )
> 
> edoardo
> 
> 
> 
> # speaker arrangement
> # { Mono 1.0  Stereo 2.0  Headphones 2.0  Stereo 2.1  Surround 3.0  Surround 4.0  Surround 4.1  Surround 5.0  Surround 5.1  Surround 6.0  Surround 6.1  Surround 7.1  Pass Through }, default: 1
> audio.output.speaker_arrangement:Surround 5.1
> 

Set speaker-arrangement to Pass Through instead of Surround 5.1

5.1 is for 6 channel analog outputs, pass through is for toslink or
spdif digital output.



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
