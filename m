From: Justin Cormack <justin@street-vision.com>
Subject: Re: HDSP + multiface "freezing" patch
Date: 07 Mar 2003 15:39:55 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1047051601.3002.30.camel@lotte>
References: <200303071422.h27EMl515775@tench.street-vision.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200303071422.h27EMl515775@tench.street-vision.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Thomas Charbonnel <thomas@undata.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Its not a version thing - I have just check and it seems to work with
Digiface, the error seems to be hdsp9652 specific...

Justin


On Fri, 2003-03-07 at 14:28, Paul Davis wrote:
> >> >ok, I am trying to test Paul's patch on the HDSP9652, but I cant get it
> >> >to play anything. I applied it to 0.9.0rc8b, but aplay just returns
> >> 
> >> which PCM device are you using?
> >
> >plughw:0,0
> >
> >(hw:0,0 gives the same error though. It should play 26 channels shouldnt
> >it)
> 
> works here with the current HDSP driver but older ALSA CVS:
> ----------------------------------------------------------------------
> paul[21]>cat /proc/asound/cards
> 0 [card0          ]: TRID4DWAVENX - Trident TRID4DWAVENX
>                      Trident TRID4DWAVENX PCI Audio at 0xe400, irq 10
> 1 [card1          ]: RME9652 - RME Digi9652 (Rev 1.5)
>                      RME Digi9652 (Rev 1.5) at 0xfd000000, irq 11
> 2 [hdsp           ]: H-DSP - Hammerfall DSP
>                      RME Hammerfall DSP + Digiface at 0xfebe0000, irq 14
> paul[22]>sync 
> paul[23]>sync
> paul[24]>sync
> paul[25]>aplay -D plughw:1 /usr/local/music/cdstage/corner.wav 
> Playing WAVE '/usr/local/music/cdstage/corner.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> Aborted by signal Interrupt...
> paul[26]>aplay -D plughw:2 /usr/local/music/cdstage/corner.wav  
> Playing WAVE '/usr/local/music/cdstage/corner.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> Aborted by signal Interrupt...
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
