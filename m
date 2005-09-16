From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0 modem
Date: Fri, 16 Sep 2005 16:55:35 +0800
Message-ID: <432A8887.4020808@netvigator.com>
References: <20050913000909.GB19713@tecr> <20050913085552.GA2655@titan.lahn.de> <20050913173529.GD31269@sashak.softier1.local> <20050913174930.GA5816@titan.lahn.de> <4327DA14.3040205@netvigator.com> <20050914205608.GD14657@sashak.softier1.local> <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de> <20050915143533.GB23218@sashak.softier1.local> <20050915204345.GC27700@sashak.softier1.local> <20050916084653.GB524@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050916084653.GB524@titan.lahn.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Philipp Matthias Hahn wrote:
> Hello!
> 

> 
> 
>>2. GPIO
>>
>>Probably we are lucky and au88x0 implements it in AC97 way, try to write
>>mc97 registers via /proc (for this you need build drivers in debug mode,
>>'--with-debug=detect' is ok):
>> # echo 42 ffff > /proc/asound/card0/codec97#0/mc97#1-1+regs
>> # echo 42 0 > /proc/asound/card0/codec97#0/mc97#1-1+regs
>> # echo 54 1 > /proc/asound/card0/codec97#0/mc97#1-1+regs
> 
> 
> Sorry, I did echo those values and read mc97#1-1+regs, but no values
> changed.
> 
> 
>>, if value is changed (we are lucky then), you may connect line and
>>isten 'Hook-Off' clicks (when 0x54 is switched between 0 and 1) with
>>parallel phone.
> 
> 
> I don't have the line cable with me at the moment and need to find a
> analog telephone circuit until I can test that
> 

This may mean the patched  vortex_codec_read() works but 
vortex_codec_write() is still not working as expected.

Do system log show any timeout error of the codec ?





-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
