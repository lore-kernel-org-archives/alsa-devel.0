From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Interesting problem with hotplug and Midisport 2x2
 on Mdk 9.0
Date: Sat, 01 Mar 2003 16:17:12 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E605E78.9070501@boosthardware.com>
References: <000201c2de8a$1237dfe0$aa1f830a@ICO>	<s5h65r5k2uc.wl@alsa2.suse.de>	<3E5EF8CC.50400@boosthardware.com> <s5h1y1sk3f0.wl@alsa2.suse.de> <3E604C56.6020402@boosthardware.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> Takashi Iwai wrote:
> 
>>>
>>> I see it too with the quattro and another user has reported it with 
>>> the audigy. It would be nicer if we didn't have to remember to unload 
>>> the usb-audio driver before hotplugging. Is it possible to make that 
>>> happen.
>>
>>
>>
>> then there is still a bug in this regard.
>> are you using MIDI on quattro, too?
>>
> 
> It is automatically used. Clemens would have to explain as I cannot 
> remember the exact details.
> 

I another bug I was just reminded of is that if I remove the alsa 
modules while the usb device is still switched on I get a complete hang 
where I have to restart with alt+sysreq+b


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
