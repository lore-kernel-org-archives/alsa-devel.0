From: Raymond <rayau@netvigator.com>
Subject: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Tue, 23 Aug 2005 23:20:00 +0800
Message-ID: <430B3EA0.1000903@netvigator.com>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org>	<s5h8y1n7af3.wl@alsa2.suse.de>	<42A5B7D4.50201@netvigator.com>	<200506071716.05194.alien999999999@users.sourceforge.net>	<s5hwtp6w2nw.wl@alsa2.suse.de>	<42A6B51F.20405@netvigator.com>	<s5h8y1lkv1c.wl@alsa2.suse.de>	<42EA4086.6030702@netvigator.com>	<s5hoe8lbqe0.wl%tiwai@suse.de>	<42F35F8F.4060808@netvigator.com>	<s5hbr4czc7o.wl%tiwai@suse.de>	<43067D3B.5040601@netvigator.com> <s5h1x4nqx72.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1x4nqx72.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Manuel Jander <manuel.jander@gmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Sat, 20 Aug 2005 08:45:47 +0800,
> Raymond wrote:
> 
>>
>>I am still using Kernel 2.4 which is not affected by the missing of 
>>these two patches.
>>
>>Is the missing of "snd_card_set_dev(card, &pci->dev);" affected only 
>>some distrubtion of Kernel 2.6 (32-bits platform) ?
>>
>>https://bugtrack.alsa-project.org/alsa-bug/view.php?id=299
> 
> 
> Sure, it's only for 2.6, and it can't be critical.
> It just adds the sysfs entry for udev/hal.  It must work fine without
> it.
> 
> 
>>The reporter of bug 216 using Kernel 2.4 and the reporter of bug 299 
>>using Kernel 2.6
> 
> 
> Then this will fix that bug very unlikely.
> 
> 
> Takashi
> 

For au88x0 on AMD64

One of the au8810 user still experience hangs when using GAIM.

Igor V. Kovalenko reported his patch is OK for his au8820

http://savannah.nongnu.org/patch/?func=detailitem&item_id=3948#comment43

There are no feed back from the reporters of ALSA BTS and another au8830 
user in the alsa.user mailing list.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1047  au8810
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1138  au8820
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1025  au8830

Would you related this three bugs report ?

They can try Igor V. Kovalenko's patch at the openvortex project.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
