From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: usbaudio won't do 24-bit or 32-bit i/o...
Date: Sat, 14 Dec 2002 19:48:25 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DFB0C79.7010000@boosthardware.com>
References: <Pine.HPX.4.33n.0212051549290.19058-100000@studcom.urz.uni-halle.de>	<3DF0482E.8010109@boosthardware.com> <s5hd6o5u6hw.wl@alsa2.suse.de>
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

> 
> could you tell me the rcs version numbers of the files on
> alsa-kernel/usb you are using (18 Nov.) ?  i've checked the files via
> cvs but i couldn't see any differences around the date.
> 

I have managed to test a more upto date version since then and it is the 
same. I have no idea when this happened though as I wasn't actively 
testing the 24 bit support until recently. I have a vague memory of 
testing it much earlier in the year but I think that was only for playback.

I currently cannot record from input 1 and 2 either.

Working are:

output 1,2,3,4
input 3,4

I also have to initialise both pcms with the small utility you made.




-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
