From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: internal structures and 32/64bit compatibility
Date: Sun, 04 Dec 2005 01:12:26 +0000
Message-ID: <4392427A.9090608@dbservice.com>
References: <43923767.2090704@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43923767.2090704@dbservice.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tomas Carnecky wrote:
> Looks like they (the 32 and 64bit libraries) don't understand each 
> other. As I can't compile the 32bit libs on my own, they are precompiled 
> by the gentoo staff, I don't know which version they are, but the 64bit 
> alsa-lib has version 1.0.10.

... they should update their packages ;)


> I've tried to compile my own 32bit alsa-oss to test why teamspeak fails, 
> but libtool keeps using absolute paths (/usr/lib/libasound.so) but the 
> 32bit libs are located in /usr/lib32, and I have no clue how to convince 
> libtool to use "-lasound" instead of the absolete path. And I guess 
> alsa-lib will be equally hard to compile for 32bit so I didn't even try it.
> 
> How can I compile alsa-lib for 32bit ?
> 

was easier that I've expected:

./configure --prefix=~/root LDFLAGS="-L/emul/linux/x86/usr/lib -m32" 
CFLAGS="-L/emul/linux/x86/usr/lib -m32"

and the package compiled without errors, copied the library to the lib32 
path and now I can play WoW and listen to music !

but the aoss wrapper library (version 1.0.10) still fails:

$ ALSA_OSS_DEBUG=1 LD_PRELOAD=/emul/linux/x86/usr/lib/libaoss.so.0.0.0 
TeamSpeak
ERROR: ld.so: object '/emul/linux/x86/usr/lib/libaoss.so.0.0.0' from 
LD_PRELOAD cannot be preloaded: ignored.
Opened PCM dsp0 for stream 0 (result = -2)
Opened PCM default for stream 0 (result = 0)
Opened PCM default for stream 1 (result = 0)
open("/dev/dsp", 2, 0) -> 18
ioctl(18, SNDCTL_DSP_RESET)
ioctl(18, SNDCTL_DSP_SETDUPLEX)
ioctl(18, SNDCTL_DSP_GETCAPS, 0x590e9168) -> [13056]
ioctl(18, SNDCTL_DSP_SETFRAGMENT, 0x590e916c[3000c])
dsp ioctl error = -22
close(18) -> 0
$

Maybe a bug in TeamSpeak itself, not initializing the device properly, 
but it works fine under native oss. I even tracked down the file and 
line on which it fails (posted to the alsa-user mailing list). So if 
someone has a clue how to fix this I'd be more than happy to test it.

Just commenting out the function call didn't help, so that call seems to 
be important for the device initialization. Seems like the function 
arguments ate calculated wrong, but I'm not a sound expert and I don't 
know what the valid fucntiion arguments are.

tom


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
