From: Paul Davis <pbd@op.net>
Subject: Re: Rate Conversion
Date: Fri, 28 Jun 2002 07:28:28 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17NttO-0001Ov-00@usw-sf-list1.sourceforge.net>
References: <3D1BD850.C59C43C2@anu.edu.au>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Fri, 28 Jun 2002 13:30:24 +1000."
             <3D1BD850.C59C43C2@anu.edu.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: u9514439@anu.edu.au
Cc: Jaroslav Kysela <perex@suse.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>> You don't need to do this. Use the 'plughw' device which should do all
>> conversions from you.
>
>I am a little confused about your advice. I am not sure how to access
>the 'plughw' device from my application.

     snd_pcm_open (&handle, "plughw:N,M", ...)

where N and M are the card number and subdevice number. Preferably,
this is a string supplied by the user, not hard coded into the application.

>I am not sure of how I should be setting up my PCM devices. How do I
>tell them to convert, say, 8kHz audio data to 44.1kHz audio data so my
>hardware can play it at the correct speed?

just as in the few token API examples. using
snd_pcm_hw_params_*(). there is no difference setting the parameters
no matter what "type" of PCM device you are using.

>I tried using aplay with plughw to play an 8kHz file and got the
>following results
>
>>aplay -Dplughw s1.wav
>Playing WAVE 's1.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
>Segmentation fault

almost certainly a bug in aplay. i suspect you might be one of the
first people to use it for a mono 8kHz file :(

--p





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Caffeinated soap. No kidding.
http://thinkgeek.com/sf
