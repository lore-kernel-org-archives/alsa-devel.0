From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Re: USB recording - repetitive peaks
Date: Wed, 03 Jul 2002 03:38:41 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D21F331.7090609@boosthardware.com>
References: <3D208C5C.36649172@ladisch.de>	<s5hhejibem0.wl@alsa2.suse.de>	<3D21B878.8090902@boosthardware.com>	<s5hy9curxdr.wl@alsa2.suse.de>	<3D21C827.2060602@boosthardware.com>	<s5hwuseruac.wl@alsa2.suse.de>	<3D21D6CA.7000308@boosthardware.com> <s5hu1nirsni.wl@alsa2.suse.de> <3D21DDFD.6000206@boosthardware.com> <3D21EB37.7070008@boosthardware.com> <3D21F06E.10604@boosthardware.com>
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
Cc: thorsten.haas@gmx.de, Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> Patrick Shirkey wrote:
> 
>> I did run make install and have just done so again to make sure but 
>> it's not in /usr/local/share/aclocal either. I will copy it over and 
>> try recording again (see below).
>>
>> >
> 
>  >> Recording was a bit messy, due to killing the arecord process 
> freezes my >> box.
>  >> Deterministically: whenever the process is interuppted (Ctrl-C) or 
> killed
>  >> (sig 9).
> 
> This seems to be the same here now. The file was recorded and with no 
> distortions
> to the sound but arecord hangs my rig when it stops. I'll check with 
> JACK+ardour.
> 
> 

Ouch. JACK+ardour causes an instant hang. Using alt+sysreq I can sync 
unmount and reboot but nothing else. Also the sound quality is 
significantly degraded while running through JACK. At least the native 
drivers are sounding correct now though :)



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
