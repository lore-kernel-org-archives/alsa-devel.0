From: Torrey Hoffman <thoffman@arnor.net>
Subject: Documentation Bugs
Date: Fri, 23 Jan 2004 14:23:48 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074896628.13428.189.camel@moria.arnor.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from devil.servak.biz (devil.servak.biz [209.124.81.2])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA09964
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2004 23:24:08 +0100
Received: from [64.122.104.99] (helo=[10.134.0.78])
	by devil.servak.biz with esmtp (Exim 4.24)
	id 1Ak9iX-00087n-1K
	for alsa-devel@alsa-project.org; Fri, 23 Jan 2004 17:23:57 -0500
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I've been working through the .asoundrc documentation and have found
several errors.

This is for the "asoundrc" documentation, viewed on Jan 23 '04, using
Mozilla 1.4.1, at the URL:

http://www.alsa-project.org/alsa-doc/doc-php/asoundrc.php3

I am using kernel 2.6.2-rc1 with the alsa-bk-2004-01-20.patch.gz,  and
the 1.0.1 version of alsa-lib, alsa-tools, and alsa-utils.

The hardware I used for these tests is the Intel ICH5 AC97 interface to
a Realtek ALC650 chip on an ABit MAX3 motherboard.

------------------------------------------------------
1. The "Aliases" section contains an incorrect example,  missing the
alias name:

"
For example, this gives your first soundcard an alias: 
	pcm. {
     		type hw
     		card 0
     		device 0
	}
Now you can access this card by the alias ''. 
	aplay -D  test.wav
"

This should be something like "pcm.my_alias_name {" ...

------------------------------------------------------
2. The Plugins section starts with an example of a very simple slave:
	pcm_slave.sltest {
     		pcm 
	}

This is incorrect.  It is missing the pcm device after the keyword pcm.

Similarly, the pcm_slave.sl2 rate-conversion example is missing the pcm
device name.

------------------------------------------------------
3. The rate conversion plug documentation (or code?) is broken.

I'm not sure if this is a documentation bug or a driver/alsa-lib bug. 

My .asoundrc at this point closely follows the documentation (with
corrections as noted in bug#2) and looks like:

pcm.ac97 {
	type hw
	card 0
	device 0
}

pcm_slave.sl2 {
	pcm ac97
	rate 44100
}

pcm.rate_convert {
	type rate
	slave sl2
}

The documentation says:  
"Now you can call this newly created virtual device by: aplay -D
rate_convert test.wav"

But when I try that, I get this error:

Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
aplay: set_params:805: Broken configuration for this PCM: no configurations available

Note that "aplay -D ac97 test.wav" works, but plays too fast (at 48000),
and gives the warning "please, try the plug plugin (-Dplug:ac97)". If I
do that, it works perfectly.

So I think the documentation is wrong, or at least incomplete, or rate
conversion does not work.

------------------------------------------------------
4.  The "plug" plugin documentation is wrong, or at least
incomplete/misleading.

First of all, the "syntax" description for "type plug" is complex and
not explained in this page of documentation at all.  route_policy,
ttable, etc. ???

The documentation goes on to say:

"	We can use it as follows: 
	pcm_slave.sl3 {
     		pcm  
     		format S16_LE
    	 	channels 1
     		rate 16000
	}

	pcm.complex_convert {
    		type plug
    		slave sl3
	}

	By calling it with: 
	aplay -vD complex_convert test.wav

	You will convert the sample during playing to the sample format:
	S16_LE, one channel and a sample rate of 16 kHz. As you called
	aplay with the verbose option -v you see this options as it
	appears as it comes from the original file"
"

First, the pcm name for the slave is missing, as in bug #2.


I copied and pasted this example directly into my .asoundrc, and then
filled in "ac97" for the missing pcm name.  Here are the results of
testing it:

[thoffman@moria thoffman]$ aplay -vD complex_convert test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
ALSA lib pcm_params.c:2096:(snd_pcm_hw_refine_slave) Slave PCM not usable
aplay: set_params:805: Broken configuration for this PCM: no configurations available

I experimented by changing the slave channels to 2 and the rate to 44100
in .asoundrc, and got exactly the same error message.

Changing the slave rate to 48000 resulted in playback, but too fast of
course...

------------------------------------------------------
5. dmix documentation

Following the documentation example for how to use dmix, I wrote this
.asoundrc:

----cut----
pcm.ac97 {
	type hw
	card 0
	device 0
}

pcm.dmixer  {
	type dmix
	ipc_key 1024
	slave {
		pcm "ac97"
		period_time 0	
		period_size 1024
		buffer_size 4096
		rate 44100
	}
	bindings {
		0 0
		1 1
	}
}
 
ctl.dmixer {
	type hw
	card 0
}

pcm.!default {
	type plug
	slave.pcm "dmixer"
}
----cut----

When I tried "aplay -f cd -Dplug:default test.wav" as the documentation
suggests, I got no error message but no sound either.

When I tried "aplay -f cd -D default test.wav" instead, it worked, and I
was able to start multiple instances, which were mixed together as
expected.

So, I think the documentation is incorrect in suggesting that the "plug"
device be used from the command line.


Thanks,

-- 
Torrey Hoffman <thoffman@arnor.net>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
