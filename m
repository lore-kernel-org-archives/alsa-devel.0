From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: Re: ALSA + jack + xrun = kernel crash
Date: Wed, 21 May 2003 02:32:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ECAC902.4050903@student.kuleuven.ac.be>
References: <s5hwugmdijp.wl@alsa2.suse.de>	<E19HnYU-0003Fd-00@sc8-sf-list1.sourceforge.net> <s5hsmrac8e7.wl@alsa2.suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Arthur Peters <amp@singingwizard.org>, Alsa dev list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

  Ok, second try:

alsa 0.9.3c fresh from CVS
   ---------------------------------------
    /proc/asound/version:
   Advanced Linux Sound Architecture Driver Version 0.9.3c.
   Compiled on May 21 2003 for kernel 2.4.20-LL with versioned symbols.

    /proc/asound/cards:
   0 [AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
                        Ensoniq AudioPCI ENS1371 at 0xb000, irq 5

   ---------------------------------------

jack 0.71.2 fresh from CVS
spiralsynthmodular

the first error:

jack -R -d alsa    (as root)
   ---------------------------------------
jackd 0.71.2
Copyright 2001-2003 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

JACK compiled with System V SHM support
loading driver ..
creating alsa driver ... default|1024|2|48000|swmon|swmeter|rt
open
You appear to be using the ALSA software "plug" layer, probably
a result of using the "default" ALSA device. This is less
efficient than it could be. Consider using a ~/.asoundrc file
to define a hardware audio device rather than using the plug layer

You appear to be using the ALSA software "plug" layer, probably
a result of using the "default" ALSA device. This is less
efficient than it could be. Consider using a ~/.asoundrc file
to define a hardware audio device rather than using the plug layer

port alsa_pcm:capture_1 has mixdown = 0x4003410e
port alsa_pcm:capture_2 has mixdown = 0x4003410e
port alsa_pcm:playback_1 has mixdown = 0x4003410e
port alsa_pcm:playback_2 has mixdown = 0x4003410e
starting engine

**** alsa_pcm: xrun of at least 78.613 msecs
**** alsa_pcm: xrun of at least 0.194 msecs
**** alsa_pcm: xrun of at least 0.030 msecs
**** alsa_pcm: xrun of at least 0.025 msecs
port SSM:In0 has mixdown = 0x4003410e
port SSM:In1 has mixdown = 0x4003410e
port SSM:In2 has mixdown = 0x4003410e
port SSM:In3 has mixdown = 0x4003410e
port SSM:In4 has mixdown = 0x4003410e
port SSM:In5 has mixdown = 0x4003410e
port SSM:In6 has mixdown = 0x4003410e
port SSM:In7 has mixdown = 0x4003410e
port SSM:Out0 has mixdown = 0x4003410e
port SSM:Out1 has mixdown = 0x4003410e
port SSM:Out2 has mixdown = 0x4003410e
port SSM:Out3 has mixdown = 0x4003410e
port SSM:Out4 has mixdown = 0x4003410e
port SSM:Out5 has mixdown = 0x4003410e
port SSM:Out6 has mixdown = 0x4003410e
port SSM:Out7 has mixdown = 0x4003410e
could not complete playback of 1024 frames
cycle execution failure, exiting
telling signal thread that the engine is done
jack main caught signal 1
   ---------------------------------------

no problem up to this point (but for the fact that jack terminates)

Then I try to restart jack with the same command. It starts, but after 
the second xrun it hangs the system.

Pieter


Takashi Iwai wrote:

>At Mon, 19 May 2003 12:38:14 -0400,
>Paul Davis wrote:
>  
>
>>>could you check whether snd_pcm_stream_linked() returns really only
>>>zero?  if yes, the code path shouldn't include the complicated locks
>>>      
>>>
>>aw shoot. of course it returns true: jack tries to link
>>capture+playback so that we only have to issue single commands to
>>start+stop. damn, i forgot that, sorry.
>>    
>>
>
>ok, i found a serious typo in pcm_native.c, which i guess as the
>culprit.
>could you try the cvs version?
>
>
>Takashi
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: ObjectStore.
>If flattening out C++ or Java code to make your application fit in a
>relational database is painful, don't do it! Check out ObjectStore.
>Now part of Progress Software. http://www.objectstore.net/sourceforge
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>  
>





-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
