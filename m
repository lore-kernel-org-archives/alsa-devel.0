From: Allan Klinbail <allank@labyrinth.net.au>
Subject: Re: MTP-AV problems (Re: intel8x0 sequencer & MTP-AV)
Date: 14 Feb 2003 14:26:19 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045193186.10268.392.camel@littlewolf2.littlewolf>
References: <1044258789.30428.61.camel@littlewolf2.littlewolf>
	<s5h3cn5ino4.wl@alsa2.suse.de>
	<1044273602.2013.6.camel@littlewolf2.littlewolf>
	<s5hheb8l05o.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hheb8l05o.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Takashi

This is fantastic news!! 

I haven't got a working build of MusE probably until later this weekend.
I have to go and engineer a gig later today and I'm sick today so I
can't seem myself doing much till tomorrow.  

Basically it seemed to receive timecode (MIDI CLOCK and MTC) okay from
our earlier testing.
It also would send MIDI to one output port. 
The device stopped seeing all messages when attempts at sending MIDI
output to more than one port occured.(this is where the initialisation
SYSEX probably comes into play)  
MIDI Input was not registering on the computer hence recording did not
work. 

cheers

Allan 


 




On Fri, 2003-02-14 at 01:34, Takashi Iwai wrote:
> Hi Allan,
> 
> recently a technical information about emagic unitor8 was revealed,
> and it includes a small desription about MTP, too.
> there, the initialization sysex is mentionted, so perhaps this may
> influence on the behavior of the device.  (also, the smpte sysex is
> described!)
> 
> before i start coding, i would like to ask you summarize the existing
> problems of mtpav driver (which most likely i forgot :)
> 
> i hope this time the bugs can be fixed, or at least improved...
> 
> 
> ciao,
> 
> Takashi




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
