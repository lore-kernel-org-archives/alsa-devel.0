From: Fredrik Lingvall <fl@signal.uu.se>
Subject: Re: Aliasing on ALi5451
Date: Tue, 27 May 2003 15:09:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ED3638C.7090006@signal.uu.se>
References: <3ECF2AC9.8070503@signal.uu.se> <1053786705.876.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1053786705.876.11.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: manuel.jander@embedded.cl
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Manuel Jander wrote:

>As far as i know, using a fixed rate codec implies a fixed
>antialiasing filter too. So there is no need to adjust a 
>antialiasing filter.
>
Yes your right the sample rate converters should do the job.

> I think thats the really reason why 
>most audio card use AC97 codec with a samplerate converter
>instead of a programable codec, since the a varying antialiasing
>filter semes more costly to me than a samplerate coverter.
>
>While implementing the Aureal alsa driver, i found several situations
>where bad samplerate converter parameters caused strong aliasing.
>I would try to find the bug in the samplerate converter setup
>if any.
>On the other hand, there are some audio cards like the CMedia 8378
>that have nearly useless ADC's in their codec, because of too low
>samplerates. If the codec is a AC97, it should be fine, because
>they usually work at 48KHz, so there could only be problems with
>white noise (bad chip+board or preamp design).
>
Yes the codec is (should be) AC97 compatible. The sample rate
converters are controlled by two registers (2Ch and 32h) one for
the DAC:s and one for the ADC:s. The values of these registers
for the supported sample rates are:

      8000   1F40
    11050   2B11
    16000   3B80
    22050   5622
    32000   7D00
    44100   AC44
    48000   BB80

I have tried to find the code in the ALSA sources where these values are
set without success (any help appriciated). My idea is to set the sampling
rate to a fixed value, for example AC44 (44.1 kHz), recompile the alsa 
drivers,
and check if the problem dissapears.

Fredrik

>
>Best regards,
>
>Manuel Jander.
>
>On Sat, 2003-05-24 at 04:18, Fredrik Lingvall wrote:
>  
>
>>Hi!
>>
>>I've tried to do loadspeaker identification using the ALi5451 chipset
>>in my laptop. I saw a strong drop in the spectrum above ~2kHz when
>>a ran the ADC:s at 44100 (I used a high quality microphone and a mic
>>pre-amp). I then wired the audio output directly to the input with
>>the same result - strong attenuation above 2kHz (I used wideband
>>white noise as identication signal). Then I generated a chirp signal
>>(5 sec sine sweep from 0-24kHz using Matlab) at 48kHz sampling rate
>>which I recorded using Audacity at 8, 44.1, and 48 kHz. There was
>>clearly freqeuency folding (aliasing) for all sampling freqs except 48 kHz
>>(see the time-freq plot at: 
>>http://www.signal.uu.se/Staff/fl/chirp_test.jpg).
>>
>> From the specs of the cs4299 chip (used in ALi 5451) it allways runs
>>at 48 kHz and uses sample rate converters for the other sampling freqs.
>>However, the anti-aliasing filters (if there are any) do not seem to adapt
>>when changing sampling freq. I also checked
>>
>>cat /proc/asound/5451/pcm0p/sub0/hw_params
>>
>>and
>>
>>cat /proc/asound/5451/pcm0c/sub0/hw_params
>>
>>when playing/recording and the sampling freqs. was correct.
>>Is this a driver issue or is it just a bad sound chip?
>>
>>Regards
>>
>>Fredrik
>>
>>
>>
>>
>>-------------------------------------------------------
>>This SF.net email is sponsored by: ObjectStore.
>>If flattening out C++ or Java code to make your application fit in a
>>relational database is painful, don't do it! Check out ObjectStore.
>>Now part of Progress Software. http://www.objectstore.net/sourceforge
>>_______________________________________________
>>Alsa-devel mailing list
>>Alsa-devel@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>>
>>    
>>
>
>
>  
>




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
