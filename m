From: =?ISO-8859-1?Q?Petter_Sundl=F6f?= <petter.sundlof@findus.dhs.org>
Subject: Re: Some problems with two 1010LTs (pcm_multi & jackd)
Date: Fri, 27 Jan 2006 00:14:41 +0100
Message-ID: <43D957E1.3030608@findus.dhs.org>
References: <43D8D6E9.80902@findus.dhs.org> <20060126184843.GA3747@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from findus.dhs.org (gl177a.glassen.ac [82.182.223.101])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id CF333199
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2006 00:14:43 +0100 (MET)
In-Reply-To: <20060126184843.GA3747@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: John Rigg <j@sound-man.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>>After this I tried to run jackd -d alsa -r44100 -p512 -C multi_capture 
>>-P multi_playback
>>
>>I then get this stdout message:
>>
>>jackd 0.100.7
>>Copyright 2001-2005 Paul Davis and others.
>>jackd comes with ABSOLUTELY NO WARRANTY
>>This is free software, and you are welcome to redistribute it
>>under certain conditions; see the file COPYING for details
>>
>>JACK compiled with System V SHM support.
>>loading driver ..
>>creating alsa driver ... 
>>multi_playback|multi_capture|1024|2|48000|0|0|nomon|swmeter|-|32bit
>>configuring for 48000Hz, period = 1024 frames, buffer = 2 periods
>>nperiods = 2 for capture
>>nperiods = 2 for playback
> 
> 
> It's starting with the wrong sample rate and number of frames, but using
> the right devices. That's strange.
> You say you installed alsa-lib over an existing one. Are you sure you replaced
> it?

I pasted in a "later" jack command line, where I tried with 44k/512 
frames instead. So the stdout output doesn't match the command I 
actually used at that time.

> 
>>I then start Ardour and open a session. I place the playhead somewhere 
>>and try to start playback. Nothing happens. After a few seconds, Ardour 
>>is disconnected from JACK, and I receive this in jackd's stdout:
>>
>>ALSA: poll time out, polled for 17416024 usecs
> 
> 
> This is the error message I kept getting before I patched pcm_multi.c.
> 
> It might be worth removing alsa-lib and jack completely and
> recompiling/reinstalling.

That'd be a dependency nightmare on Fedora Core :/ alsa-lib is patched 
and installed, but I'll double double check it tomorrow (today's been 
too rough; had to evactuate rehearsal room and guitarist breaks his 
little finger).

> You won't be able to record for long like this. It will run for a while,
> as the clocks are pretty accurate, but they will drift and you'll get
> xruns and/or jackd will die.

Yeah. Since I don't have any external S/PDIF sources yet, I guess I'll 
have to wait until/if a solution for 1010LT cards has landed.

[snip...]
 >># S/PDIF second soundcard (playback)
 >>>  	bindings.18.slave b
 >>>  	bindings.18.channel 8
 >>>  	bindings.19.slave b
 >>>  	bindings.19.channel 9
 >
 >
 >One more thing - I'm not sure if the S/PDIFs are working yet on 1010LT.
 >Try commenting these sections out in .asoundrc.

Done, but no change.

I'll try making sure alsa-lib is patched alright.

Thanks for the help.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
