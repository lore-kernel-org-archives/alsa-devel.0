From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: still losing with hdsp (me too)
Date: Tue, 3 Jun 2003 09:19:24 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGAEAJCGAB.mknecht@controlnet.com>
References: <200306031413.13936.Jaakko.Prattala@Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200306031413.13936.Jaakko.Prattala@Helsinki.FI>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?B?SmFha2tvIFBy5HR05Gzk?= <Jaakko.Prattala@Helsinki.FI>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

<SNIP>
> 
> Xilinx Corporation RME Hammerfall DSP (rev 0b)
> 0b hexadecimal == 11 decimal
> so, you have revision 11 firmware...
> 
> This looks like the problem I'm having that didn't go away by
> downgrading the firmware. Then again, I'm using the cardbus interface.
> Anyway, rev 10 firmware gets loaded and rev 11 doesn't. So
> maybe try downgrading?
> 
> ######## the (me too) part: ####################
> 
> Sorry to burn the devel-list bandwidth again.
> I'm still wishing that somewhere I'd get a hint of what's
> going on with my system. (The snd-hdsp module locks up
> when I try to use it. Start aplay or pd and wind up with a module
> that can't be rmmod'ed because of "device or resource busy".)

Jaakko,
   Hi. Sorry if this email doesn't help. I'm currently not using my
HDSP 9652 at all since the drivers just don't work, but in the 
meantime I tried using Alsa with my motherboard's sound chip - a
Via8235. I had similar problems as you with that chip. Often 
apps like aplay locked up for at least a minute or two, and some
game apps like Frozen Bubble would lock up forever as far as I could
tell. I have also seen the same 'device or resource busy' messages.

   Last evening I found that at least for aplay, if I specified the
specific hardware interface, such as 

aplay -D hw:0,1 wavefile.wav

then the system works fine, at least for aplay. However, just starting
aplay using

aplay wavefile.wav 

resulted in error messages. The system still hangs on Frozen
Bubble and many other games, so I need to know how to make
this -D hw:0,1 option the default. My .asoundrc file does not seem
to make that happen.

   Takashi-san said that some motherboards have BIOS problems. 
Possibly that's the cause in my case, but I'm not so sure. 

   Maybe you can try 

aplay -l

and get some info about the interface that will help.

   Again, sorry for probably wasting bandwidth.

cheers,
Mark




-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
