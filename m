From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: status of usb audio driver
Date: Thu, 13 Jun 2002 22:35:44 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D089FB0.5020604@boosthardware.com>
References: <s5h7klfdlrn.wl@alsa2.suse.de>	<3D06D91D.1080104@boosthardware.com>	<s5hhek81vgl.wl@alsa2.suse.de>	<3D07564B.4050908@boosthardware.com>	<s5hbsag1t5r.wl@alsa2.suse.de>	<3D0760FC.5060906@boosthardware.com>	<3D0772F1.6090009@boosthardware.com>	<3D077B61.7030902@boosthardware.com>	<s5hzny0zb43.wl@alsa2.suse.de>	<3D078560.4030707@boosthardware.com>	<s5hr8jbzcml.wl@alsa2.suse.de>	<3D0895F0.20904@boosthardware.com> <s5hn0tzz5vg.wl@alsa2.suse.de>
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
>>This card is supposed to be 24bit/96Khz. In windows it works like this:
>>
>>4 i/o channels(2 in, 2 out) at 16bit/48Khz or less
>>3 i/o channels(2 in, 1 out or 1 in, 2 out) at 24bit/48Khz or less
>>1 channel at 24bit/96Khz
> 
>  
> interesting.  i don't find any mono channel on the descriptions.
> well, more investigations are necessary.
> 

It is confusing to me also. From reading their docs I thought that the 
card was all seperate mono channels lsusb has changed my opinion. I now 
belive that Quattro stands for 2 stereo i/o devices not 4 mono i/o devices.

By saying in the docs that it supports 1 channel at 24bit/96Khz I guess 
they mean 1 stereo in or 1 stereo out. that is good news to me becasue I 
was under the impression that I had bought a turkey with only one mono 
i/o channel at 24/96.

>>>i've tested usb mic from Labtec, and it works.
>>>so the problem is specific to the hardware, or multi-channels...
>>>
>>
>>I just remembered that my mouse is a usb mouse too so that is not 
>>unexpected.
> 
> 
> too much bandwidth?
> 

Testing again with the new code didn't lock up my mouse and this time 
the file actually recorded data although I still cannot capture noise. 
Do you have any ideas on how I can adjust the input levels internally 
seeing as the card has no apparent internal mixer?

Is this a case of having to write our own mixer device?

Does this part of lsusb have anything to do with mixer controls?

----
  wChannelConfig     0x0003
           Left Front (L)
           Right Front (R)
         iChannelNames           0
         iTerminal               0
----





-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
