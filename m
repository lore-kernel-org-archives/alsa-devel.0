From: Josh Buhl <uzs33d@uni-bonn.de>
Subject: Re: aplay/arecord hang at 44100 Hz
Date: Tue, 11 Feb 2003 17:47:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E49291E.7000307@uni-bonn.de>
References: <3E476DD8.7050907@uni-bonn.de> <s5hu1fbcfyb.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu1fbcfyb.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

> i guess it's a bug of either alsa-lib or aplay, not of the driver.
> could you check at which user function the operation stops?
> 

I'll be happy to provide any debugging info I can, but I'm not exactly 
sure what you mean by which user function. The error occurs for both 
user functions aplay and arecord, or do you mean something else?


This is how far aplay gets:

josh@spleen:/var/tmp$ aplay track_01.wav
Playing WAVE 'track_01.wav' : Signed 16 bit Little Endian, Rate 44100 
Hz, Stereo


but no sound, just 100% cpu load.


josh@spleen:/var/tmp$ arecord -f cd -d 120 /tmp/blah.wav
Recording WAVE '/tmp/blah.wav' : Signed 16 bit Little Endian, Rate 44100 
Hz, Stereo


here arecord does write a header:


RIFF$^@^@^@WAVEfmt^P^@^@^@^A^@^B^@D<AC>^@^@^P<B1>^B^@^D^@^P^@data^@^@^@^@


but then jumps to 100% cpu load and doesn't get any further.


-josh



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
