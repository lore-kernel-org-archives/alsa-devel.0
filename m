From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: HDSP 9632 driver and expansion cards
Date: Wed, 21 Jan 2004 22:23:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <400EEDE9.80208@undata.org>
References: <1074650862.6893.10.camel@rivendell.home.local> <400E74F6.1040803@undata.org> <02f701c3e04e$1f39d2e0$5d40a8c0@FRiskMan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <02f701c3e04e$1f39d2e0$5d40a8c0@FRiskMan.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ed Wildgoose <Ed@Wildgooses.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ed Wildgoose wrote :
>>Florin Andrei wrote :
>>
>>>Anyone using the latest RME HDSP 9632 driver in ALSA, while also using
>>>the expansion cards? I mean, the newer AI4S-192 and/or AO4S-192 which
>>>are required to get the 192kHz sampling on all analogs.
>>>
>>>Do the latest expansion cards (192kHz) work with the latest ALSA driver?
>>>
>>>In general, are the ALSA drivers ready to support any kind of expansion
>>>cards on the HDSP 9632 / HDSP 9652?
>>>
>>
>>Hi Florin,
>>
>>Support is there, but as of today and as far as I know this is untested.
>>
>>Thomas
> 
> 
> Hi Thomas,
> 
> Thanks so much for your RME 9632 driver and your fantastic mixer utilities.
> I have a 9632 now and also the 4 port analogue expansion card.
> 
> I haven't had time to try and get any sound out of it yet!  However, it is
> detected correctly in the mixer, and the driver thinks that there are 4
> extra channels.  I need to get some jack socket convertors to get some sound
> out, but will let you know.
> 

Please do so, thanks.

> I have a few usability comments with regards to the drivers that I would
> like to share, will draft a fuller email later, but basically I am using it
> as a hifi input for music, nothing else, but I'm frequently getting very
> jittery & broken up audio (guessing that the default alsa buffer/latency
> size is really tiny?) and not many input formats are supported which means
> that the plug driver is usually required (not a huge problem though).  It
> would also be extremely nice to have some simple mixer controls available
> for compatibility with older/simpler apps.  In particular a fake master
> mixer which reduces all channels would be extremely desirable (I'm hoping to
> use the card for a surround sound output)
> 

For the "jittery & broken up audio" problem, are you running an 
optimized audio kernel (preempt + lowlatency patched) ?
How frequent is frequently ? Can you find any relation between the audio 
problems and external factors (disk access, heavy load, etc...) ?

For the supported formats, this is a limitation of the hardware. Plughw 
is indeed your friend here, or try to find a player that handles this 
natively (alsaplayer ?).

For the mixer controls : there were some in the past, but I removed them 
because I couldn't find any clean solution to deal with them while 
changing speed mode (because their number changes at this occasion). 
Maybe Jaroslav or Takashi have an idea on the subject ? When I last 
worked on this, the only solution I could find would have been to mess 
up with a semaphore held by the alsa-lib layer and although it would 
have worked, it would have been plain ugly.
Anyway I plan a massive redesign of the way the driver and userspace 
apps interact regarding the matrix mixer, mostly to enable several 
application to access the mixer at the same time in a cooperative way 
(how about an alsaseq client or a ladspa plugin accessing the matrix 
with the changes reflected in hdspmixer ? :). This is the prerequisite 
of some work I want to do with jack and ardour to handle hardware 
monitoring in a better way. I could indeed add a master volume control 
at this occasion.

> Thanks for your work on this, it is very much appreciated.
> 
Thanks for your kind words, they're very much appreciated these days...

Thomas




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
