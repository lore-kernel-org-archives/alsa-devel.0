From: Laurent Georget <lgeorget2@club-internet.fr>
Subject: Re: level plugin not loaded with current cvs
Date: Mon, 27 Jan 2003 22:13:08 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E35A0E4.5040605@club-internet.fr>
References: <3E327281.5070004@club-internet.fr> <s5hptqiopid.wl@alsa2.suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Hi,
> 
> At Sat, 25 Jan 2003 12:18:25 +0100,
> Laurent Georget wrote:
> 

>>[l@localhost l]$ arecord -D ameter -v sound.wav
>>ALSA lib dlmisc.c:107:(snd_dlsym_verify) unable to verify version for
>>symbol _snd_pcm_scope_ameter_open
>>ALSA lib pcm_meter.c:742:(snd_pcm_meter_add_scope_conf) symbol
>>_snd_pcm_scope_ameter_open is not defined inside /usr/local/lib/libameter.so
>>arecord: main:462: audio open error: No such device or address
>>

> 
> it's due to the check of snd_dlsym().
> now pcm_meter.c uses the normal dlsym(), so it should work again on cvs.
> please give a try.
> 
> 
> ciao,
> 
> Takashi

Ok now, thanks!

Laurent




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
