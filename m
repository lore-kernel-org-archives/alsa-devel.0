From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: HDSP 9632 driver and expansion cards
Date: Fri, 23 Jan 2004 11:20:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4010F57E.7070207@undata.org>
References: <1074650862.6893.10.camel@rivendell.home.local> <400E74F6.1040803@undata.org> <02f701c3e04e$1f39d2e0$5d40a8c0@FRiskMan.com> <400EEDE9.80208@undata.org> <013301c3e0fc$f4ea92e0$5d40a8c0@FRiskMan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <013301c3e0fc$f4ea92e0$5d40a8c0@FRiskMan.com>
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
>>>I haven't had time to try and get any sound out of it yet!  However, it
> 
> is
> 
>>>detected correctly in the mixer, and the driver thinks that there are 4
>>>extra channels.  I need to get some jack socket convertors to get some
> 
> sound
> 
>>>out, but will let you know.
>>>
>>
>>Please do so, thanks.
> 
> 
> Hi Thomas,  I tested this, and it does seem to work ok!  I literally just
> squirted some sound through a single channel briefly, so this is nothing
> more than a "it works" test.  I will get some plugs over the next few days
> for better trials.  Thanks so much for your work on this!
> 
> 

Thanks, this is good news. Could you also please test hdspmixer with the 
expansion board and confirm there's no problem here either ?

>>For the "jittery & broken up audio" problem, are you running an
>>optimized audio kernel (preempt + lowlatency patched) ?
>>How frequent is frequently ? Can you find any relation between the audio
>>problems and external factors (disk access, heavy load, etc...) ?
> 
> 
> I'm using 2.6.1 mm-1 with the pre-empt option switched on.  With low system
> load I seem to be able to get JACK to work for short periods with 1.5ms
> latency!  3ms and up latency works with JACK, reasonably despite some
> processing with Brutefir going on as well...
> 
> I only tried it a couple of times, and I forget now whether I used both OSS
> emulation and ALSA devices, or just one?  However, the effect was something
> like when you are feeding an audio file to the card at a fixed rate, and
> it's playing it at a faster rate, you get continuous snatches of sound and
> underflows leaving a short gap before sound restarts (multiple times per
> second).
> 

Just to make it clear that this is a software problem and not the 
problem that Tim, Paul and Mark reported, could you please try to route 
an incoming signal (through analog or digital in) to your amp using 
hdspmixer and tell me if the routed sound suffers from the same audio 
corruption as the one being played back ? (this test should be done 
while you're playing back a stuttering software stream)

> I will try it again and document exactly which apps and what my setup is.
> Sorry for the vague problem report...  In the meantime I'm actually using
> the PAD card for general duties (ie watching TV)
> 
> 
> 
>>For the mixer controls : there were some in the past, but I removed them
>>because I couldn't find any clean solution to deal with them while
>>changing speed mode (because their number changes at this occasion).
>>Maybe Jaroslav or Takashi have an idea on the subject ? When I last
>>worked on this, the only solution I could find would have been to mess
>>up with a semaphore held by the alsa-lib layer and although it would
>>have worked, it would have been plain ugly.
>>Anyway I plan a massive redesign of the way the driver and userspace
>>apps interact regarding the matrix mixer, mostly to enable several
>>application to access the mixer at the same time in a cooperative way
>>(how about an alsaseq client or a ladspa plugin accessing the matrix
>>with the changes reflected in hdspmixer ? :). This is the prerequisite
>>of some work I want to do with jack and ardour to handle hardware
>>monitoring in a better way. I could indeed add a master volume control
>>at this occasion.
> 
> 
> I hear what you are saying.  Would it be possible to have a very badly
> behaved master mixer control which possibly has a rather confused view of
> min and max levels even?
> 
> The situation I would rather like to get to is that I could use the output
> mixers on each channel to set a maximum amplitude for that channel.  The
> physical analogue outputs are then likely to feed directly into power amps
> with no preamp (perhaps an attenuator in the way though).  The master
> control (lets call it a fader) will operate on all channels individually,
> and adjust them equally (in dB, not linearly), so that I effectively have a
> home theatre 5.1 output directly into the power amps.  The master fader
> control is effectively applying a 0-100% scaling on the output mixer,
> bearing in mind that each output channel may well have different absolute
> levels (depends how close each speaker is).
> 
> Does this sound easier?  Is it feasible?
> 
> 

This is more or less my plan. What you're asking for actually exists but 
is a totalmix/hdspmixer only software abstraction (the third row, i.e. 
"Outputs", one of the few features of the HDSP that is not directly 
reflecting the hardware). Any change on this third row is interpreted by 
hdspmixer and translated into standard matrix mixer calls. This prevents 
other applications to play nicely with hdspmixer as any change done to 
the matrix mixer's state by those applications will shortcut hdspmixer's 
representation and lead to an unsynchronised state. The idea is thus to 
implement this output layer in the driver and setup specific controls 
for it. My main concern at this point is performance, particularly with 
the new MADI driver Winfried Ritsch has been working on (64 channels...).

It would be very exciting if this could be made to work.  I suspect this
> feature alone would sell RME some sound cards... (not that you care, just an
> aside!)
> 

I think the nicest feature you'd get with this design is the ability to 
manipulate totalmix/hdspmixer's enhanced mixer (with this output stage) 
from several applications in a coherent way (hdspmixer, ladpsa plugin, 
script, midi automation, etc...), a feature that people constantly ask 
for on the RME forum. This could also very well "sell" a few linux 
installs to RME customers :)

> For what it is worth, the card will likely be fed by JACK via a Brutefir
> filter to do room correction based on a filter designed using Brutefir. (A
> very interesting project that is well worth experimenting with...)
> 
> Thanks so much for taking the time to listen - much appreciated
> 
> Ed W
> 

Thanks for testing and reporting !

Thomas





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
