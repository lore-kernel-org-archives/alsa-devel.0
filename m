From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: usbaudio won't do 24-bit or 32-bit i/o...
Date: Tue, 17 Dec 2002 05:11:52 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DFE3388.9000201@boosthardware.com>
References: <Pine.HPX.4.33n.0212051549290.19058-100000@studcom.urz.uni-halle.de>	<3DF0482E.8010109@boosthardware.com>	<s5hd6o5u6hw.wl@alsa2.suse.de>	<3DFB0C79.7010000@boosthardware.com> <s5hvg1tswyq.wl@alsa2.suse.de> <3DFE2295.2020502@boosthardware.com>
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
>>  
>> hmm, it's weird.  it would be nice if we can know at which point the
>> driver became broken...
>>
> 
> It was working nicely before the drivers were merged but wouldn't paly 
> with jack. Now it likes jack.
> 

In additon to this the last version I had from before the merge that 
seemed to work well is from September 5. In that version I can record 
from inputs 1,2 and playback from all 4 channels.

I also get "sample format non available" when trying to use s24_3le with 
this version at any sample rate.





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
