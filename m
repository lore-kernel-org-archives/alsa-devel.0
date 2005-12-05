From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: internal structures and 32/64bit compatibility
Date: Mon, 05 Dec 2005 20:30:19 +0000
Message-ID: <4394A35B.1030101@dbservice.com>
References: <43923767.2090704@dbservice.com>	<4392427A.9090608@dbservice.com>	<s5hbqzvmvnx.wl%tiwai@suse.de>	<43949C0C.8030101@dbservice.com> <s5h4q5nmkp6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4q5nmkp6.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 05 Dec 2005 19:59:08 +0000,
> Tomas Carnecky wrote:
> 
>>Takashi Iwai wrote:
>>
>>>At Sun, 04 Dec 2005 01:12:26 +0000,
>>>Tomas Carnecky wrote:
>>>
>>>
>>>>but the aoss wrapper library (version 1.0.10) still fails:
>>>>
>>>>$ ALSA_OSS_DEBUG=1 LD_PRELOAD=/emul/linux/x86/usr/lib/libaoss.so.0.0.0 
>>>>TeamSpeak
>>>>ERROR: ld.so: object '/emul/linux/x86/usr/lib/libaoss.so.0.0.0' from 
>>>>LD_PRELOAD cannot be preloaded: ignored.
>>>
>>>
>>>Do you really have this shlib file?
>>>
>>>
>>
>>if alsa does some output, then the library was preloaded, if the preload 
>>would fail, I wouldn't see any output I guess.
> 
> 
> Right, but still I'm wondering how it did work.  Maybe you have
> another libaoss and it was loaded instead of the above?
> 
> 

if I do:

LD_PRELOAD=./mylib.so wine /games/World.of.Warcraft/WoW.exe

it also prints that 'can't preload' message, but if I supply the full 
path to the library, it doesn't print that anymore. But since I've 
supplied the full path to LD_PRELOAD, I have no clue what might cause 
this error.

After I've changed some parts of libaoss.so it started to work, I had to 
comment out one function call, replace a return value in another place 
and add two function calls to the snd_pcm_read/write functions.

What I've done is described here: 
http://gentoo-wiki.com/HOWTO_ALSA_and_TeamSpeak_on_amd64

read the section 'compile patched alsa-oss' to find out what exactly 
I've changed.

tom


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
