From: "Alex Lau" <lau2468@hotmail.com>
Subject: ALSA API
Date: Sun, 04 Jan 2004 09:19:16 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Law10-F11548UXHnnC000008fa6@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I been doing some reading on using the alsa API, however, I cannot find much 
information on it. It also look like that the different versions have 
different argument for the same API.

For example, the snd_pcm_open( )

some use snd_pcm_open( &handle, card, device, stream, mode)
some use snd_pcm_open(&handle, device, stream, mode)

I try to use the second one but do not know the nameing convention for the 
device. I am using 1.0.0rc2.

I try to run the minimal playback program from the tutorial found in the 
alsa web site,

snd_pcm_t  *handle;
char  *device = "hw:0,0";
err = snd_pcm_open(&handle, device, SND_PCM_STREAM_PLAYBACK, 0);
..........


the program compile ok but when I try to run it I got a err -2 (no such file 
or directory)

if I chang the to
char *device = "front";

I got

ALSA lib pcm.c:1812:(snd_pcm_open_conf) Invalid type for PCM front 
definition (id: front, value: cards.pcm.front)
Err is -22

Can anybody tell me what is the naming convention for the devics in alsa?
Can anybody tell me where I can find some more descriptive information for 
the alsa.conf file?


Thanks in advance.

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*.  
http://join.msn.com/?page=dept/features&pgmarket=en-ca&RU=http%3a%2f%2fjoin.msn.com%2f%3fpage%3dmisc%2fspecialoffers%26pgmarket%3den-ca



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
