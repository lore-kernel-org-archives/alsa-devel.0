From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: Re: Phase Reversal on Santa Cruz (cs46xx)
Date: Fri, 22 Nov 2002 01:09:16 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DDD75AC.9030408@cucumelo.org>
References: <200211170056.11190.puetzk@iastate.edu> <200211171652.05776.puetzk@iastate.edu> <3DD87414.8060303@cucumelo.org> <200211172241.14373.puetzk@iastate.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kevin Puetz <puetzk@iastate.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>well, the basic premise is simple... the speaker wires have a positive and 
>negative wire, current flows through the coil, and the cone moves one way or 
>the other. If you swap the wires, the cone moves the other way. Inaudible, 
>except that if the two speakers aren't moving the same way, they waves tend 
>to cancel each other out. It affects bass more than treble because the waves 
>are longer and slower, so a) they correleation between the stereo channels is 
>stronger and b) inaccuracies in soundcard timing, etc have less impact. The 
>fact that sound is sensitive to polarity is just basic physics :-)
>  
>
Thanks, that explication makes sense.

>Now, why in the world the santa cruz would be wired in such a way that 
>software which is fine on other cards would get one channel backwards on it 
>is an excellent question. Espescially when there is older software that 
>worked on all (though not so well, I definitely like having multiple apps 
>accessing it at once).
>  
>
If it was that simple that Santa Cruz where the only card in the world with
this problem, but there's the same problem is reported for other cs46xx 
based card's
too.

>well, how did it work before (0.9.0rc1 worked for sure, I guess I should try 
>to identify the specific version that developed this problem)? Were we using 
>the DSP to invert it previosly, did we lose some Santa Cruz specific 
>bittwiddling (the 'fix' consists of just negating all the levels for one 
>stereo channel). Any guesses?
>  
>
I would like know why the problem does not apear with rc1,  but the 
problem does not
apear  forme with any release, so I cant reproduce the problem with my 
equipment, which
dont make things easy ...

The main diference between the old DSP code and the new is that the old DSP
is based on a static parameter setup. The new DSP code is  a attempt to 
manage
tasks and resources in the DSP dynamically.

I dont find any reason to why the DSP would invert one of the channels, 
in theory
the parameter setup made when playing one PCM channel is the same as it is
in the old DSP code static loaded (discarding unknown bugs)

Finally, the "volume" could be possible, speculating: if the output sample
is the product of volume * sample, and the volume is negative the sample 
would
be negated. The "volume" in a DSP SCB for each channel is 16 bit value where
0x8000 is the maximum volume and 0xffff is cero, and lower then 0x8000 dont
know. This part now actually differs a little bit from the old static 
DSP setup.
Have you tested my latest patch ??

>Just as another question, do anyone know if it's possible to use the internal 
>SPDIF connector to feed CD audio into the card instead of the analog input? I 
>can't find anything in the mixer that seems to recieve that input.
>  
>

The cs4630 chip got only one SDPIF input interface, you should see it 
the mixer with
the new DSP code. And if that interface is wired to the internal SPDIF 
conector without
any GPIO story it should just work (however the sounds gets 
distorcionated (out-of-sync)
sometimes with the SPDIF input) ...

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
