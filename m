From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Re: USB recording - repetitive peaks
Date: Wed, 03 Jul 2002 02:08:13 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D21DDFD.6000206@boosthardware.com>
References: <3D208C5C.36649172@ladisch.de>	<s5hhejibem0.wl@alsa2.suse.de>	<3D21B878.8090902@boosthardware.com>	<s5hy9curxdr.wl@alsa2.suse.de>	<3D21C827.2060602@boosthardware.com>	<s5hwuseruac.wl@alsa2.suse.de>	<3D21D6CA.7000308@boosthardware.com> <s5hu1nirsni.wl@alsa2.suse.de>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 03 Jul 2002 01:37:30 +0900,
> Patrick Shirkey wrote:
> 
>>Takashi Iwai wrote:
>>
>>>Hi Patrick,
>>>
>>>i found out an obvious bug there.  i forgot to correct the offset
>>>value of capture destination after a minor modification.
>>>it's fixed on cvs.
>>>could you update the cvs and test whether it works?
>>>
>>
>>I get this in alsa-utils
>>
>>----
>>/usr/local/src/music/alsa/alsa-utils# ./cvscompile 
> 
>                             ^^^^^^^^^^
> shouldn't be alsa-driver?
> 

Yeah I had to zap the cvs because of the patch confusing things so I'm 
trying to install alsa-utils but I get that error. alsa-driver and 
alsa-lib installed correctly.

Another thing is that even though I can rmmod all the other sound 
modules for other cards I cannot rmmod the following. I have checked 
with ps -aux that there are no stray processes. Currently I have to 
reboot. I think this only started with the new patches for recording.

snd-usb-audio          23136   1  (autoclean)
snd-pcm                48320   1  [snd-usb-audio]
snd-timer               9280   0  [snd-pcm]
snd                    23400   3  [snd-usb-audio snd-pcm snd-timer]
soundcore               3556   0  [snd]





-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
