From: Rick Wright <riwright@vt.edu>
Subject: Re: potential emu10k1 bug/issue for Audigy2 ZS Platinum Pro
Date: Fri, 11 Feb 2005 10:18:11 -0500
Message-ID: <420CCCB3.7010104@vt.edu>
References: <420B8B23.2090404@vt.edu> <1108067206.10310.7.camel@krustophenia.net> <420BD024.8040602@vt.edu> <1108073563.11177.1.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------040202050008030701070302"
In-Reply-To: <1108073563.11177.1.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040202050008030701070302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Lee Revell wrote:

>On Thu, 2005-02-10 at 16:20 -0500, Rick Wright wrote:
>  
>
>>>>The real problem is that the PCM output volume control sliders are 
>>>>backwards (or perhaps the remapping the channels to L/R, rather than R/L 
>>>>will fix this).  For example: PCM Front L slider controls the volume of 
>>>>playback_9 which is the RIGHT Front signal, PCM Front R slider controls 
>>>>playback_10 which is the LEFT Front signal.  This is true for all of the 
>>>>Stereo Output channel pairs.  If you think about it, the PCM sliders are 
>>>>actually controlling the correct physical L & R outputs on the card, but 
>>>>the alsa_pcm:playback signals being routed to those physical channels 
>>>>are reversed, make sense?
>>>>
>>>>Is this a bug?  If so, what is the proper place/way to report it so that 
>>>>I don't use any more of your time?  Has it already been fixed?  I know 
>>>>you mentioned v008 still had problems...
>>>>
>>>>    
>>>>        
>>>>
>>>ISTR that this is a hardware bug, and the kX driver works around it.  I
>>>will look into it.
>>>
>>>Are the channels reversed if you use JACK with the default stereo PCM,
>>>hw:0,0?
>>>
>>>  
>>>      
>>>
>>Using hw:0,0 for BOTH the Input & Output devices in QJackCtl:
>>(actually, input probably doesn't matter, huh?)
>>playback_1 maps to Stereo Output #1 RIGHT and volume is controlled by
>>the PCM LEFT slider
>>playback_2 maps to Stereo Output #1 LEFT and volume is controlled by
>>the PCM RIGHT slider
>>
>>In this case, it seems that slider is controlling the correct
>>playback_x stream, but the stream is mapped to the wrong stereo
>>channel of the soundcard.
>>    
>>
>
>This does look like an upstream bug.  Can you verify that the channels
>are still reversed without my patch?
>
>Lee
>
>
>  
>
Using a stock (unpatched) alsa-driver-1.0.8 (verified that hw:0,3 is not 
available), here are the 2ch stereo output (using output device hw:0,0 
in qjackctl) results:

playback_1 maps to Stereo Output #1 RIGHT and volume is controlled by 
Front (NOT PCM Front) LEFT slider
playback_2 maps to Stereo Output #2 LEFT and volume is controlled by 
Front (NOT PCM Front) RIGHT slider

PCM Front sliders have no effect.  However, a slider named PCM (there 
are two of these, I'm talking about the one on the right, next to PCM 
Center....I believe the one on the left controls feedthrough?) behaves 
exactly like the Front sliders described above, but seems to supercede 
the Front sliders.

Again in this unpatched case, the sliders seem to control the correct 
playback_x channel (assuming L-comes-first), but the playback_x channels 
are being routed to the sound card's physical output channels 
incorrectly (L/R backwards).

-Rick

--------------040202050008030701070302
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Lee Revell wrote:
<blockquote cite="mid1108073563.11177.1.camel@krustophenia.net"
 type="cite">
  <pre wrap="">On Thu, 2005-02-10 at 16:20 -0500, Rick Wright wrote:
  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">The real problem is that the PCM output volume control sliders are 
backwards (or perhaps the remapping the channels to L/R, rather than R/L 
will fix this).  For example: PCM Front L slider controls the volume of 
playback_9 which is the RIGHT Front signal, PCM Front R slider controls 
playback_10 which is the LEFT Front signal.  This is true for all of the 
Stereo Output channel pairs.  If you think about it, the PCM sliders are 
actually controlling the correct physical L &amp; R outputs on the card, but 
the alsa_pcm:playback signals being routed to those physical channels 
are reversed, make sense?

Is this a bug?  If so, what is the proper place/way to report it so that 
I don't use any more of your time?  Has it already been fixed?  I know 
you mentioned v008 still had problems...

    
        </pre>
      </blockquote>
      <pre wrap="">ISTR that this is a hardware bug, and the kX driver works around it.  I
will look into it.

Are the channels reversed if you use JACK with the default stereo PCM,
hw:0,0?

  
      </pre>
    </blockquote>
    <pre wrap="">Using hw:0,0 for BOTH the Input &amp; Output devices in QJackCtl:
(actually, input probably doesn't matter, huh?)
playback_1 maps to Stereo Output #1 RIGHT and volume is controlled by
the PCM LEFT slider
playback_2 maps to Stereo Output #1 LEFT and volume is controlled by
the PCM RIGHT slider

In this case, it seems that slider is controlling the correct
playback_x stream, but the stream is mapped to the wrong stereo
channel of the soundcard.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
This does look like an upstream bug.  Can you verify that the channels
are still reversed without my patch?

Lee


  </pre>
</blockquote>
Using a stock (unpatched) alsa-driver-1.0.8 (verified that hw:0,3 is
not available), here are the 2ch stereo output (using output device
hw:0,0 in qjackctl) results:<br>
<br>
playback_1 maps to Stereo Output #1 RIGHT and volume is controlled by
Front (NOT PCM Front) LEFT slider<br>
playback_2 maps to Stereo Output #2 LEFT and volume is controlled by
Front (NOT PCM Front) RIGHT slider<br>
<br>
PCM Front sliders have no effect.&nbsp; However, a slider named PCM (there
are two of these, I'm talking about the one on the right, next to PCM
Center....I believe the one on the left controls feedthrough?) behaves
exactly like the Front sliders described above, but seems to supercede
the Front sliders.<br>
<br>
Again in this unpatched case, the sliders seem to control the correct
playback_x channel (assuming L-comes-first), but the playback_x
channels are being routed to the sound card's physical output channels
incorrectly (L/R backwards).<br>
<br>
-Rick<br>
</body>
</html>

--------------040202050008030701070302--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
