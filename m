From: peter plessas <plessas@mur.at>
Subject: Re: hdsploader on ppc
Date: Tue, 05 Apr 2005 23:25:20 +0200
Message-ID: <42530240.6040805@mur.at>
References: <423CC3E0.2020408@mur.at> <s5h64zl45cd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h64zl45cd.wl@alsa2.suse.de>
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

Hi!

Thanks for the hint, as i checked again, i see that i am indeed using 
alsa-drivers-1.0.9rc1.

 From what i found out so far, this might still be an endianess issue.
What about the firmware itself? Could there be a byte-swapping problem?

Thanks for any help!
I would so much like to solve this, it's been a year or so i have been 
revisiting this problem.

regards, Peter


Takashi Iwai wrote:
> At Sun, 20 Mar 2005 01:29:20 +0100,
> peter plessas wrote:
> 
>>Dear list,
>>
>>this is a bit complicated, due to big/little endian issues, perhaps.
>>I am trying to load the firmware into my hdsp pcmcia card.
>>
>>I am getting the fifo timeout:
>>
>>peter:~# hdsploader
>>hdsploader - firmware loader for RME Hammerfall DSP cards
>>Looking for HDSP + Multiface or Digiface cards :
>>Card 0 : PowerMac Screamer Rev 0
>>Card 1 : RME Hammerfall DSP at 0xf3000000, irq 58
>>Upload firmware for card hw:1
>>Hwdep ioctl error on card hw:1 : Input/output error.
>>
>>I am using debian testing, running a 2.6.8 kernel with manually compiled 
>>1.0.8 alsa drivers on a G3 powerpc laptop.
> 
> 
> hdsp support on ALSA 1.0.8 seems buggy.
> Please try 1.0.9rc1.
> 
> 
> Takashi


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
