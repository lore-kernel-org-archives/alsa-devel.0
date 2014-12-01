From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 21/30] ALSA: oxfw: Change the way to name
	card
Date: Tue, 02 Dec 2014 00:05:31 +0900
Message-ID: <547C83BB.3040602@sakamocchi.jp>
References: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
 <1417190379-4172-22-git-send-email-o-takashi@sakamocchi.jp>
 <s5hbnnpbxxs.wl-tiwai@suse.de> <547A9E1B.7060004@sakamocchi.jp>
 <s5h4mthay31.wl-tiwai@suse.de> <547BA5F2.4040401@sakamocchi.jp>
 <s5hzjb792z3.wl-tiwai@suse.de> <547C4F53.1030306@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 351AD260500
 for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2014 16:05:36 +0100 (CET)
In-Reply-To: <547C4F53.1030306@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Dec 1 2014 20:21, Clemens Ladisch wrote:
> (While the driver name often is name of the driver, it is also used to
> select one of the configuration files in /usr/share/alsa/cards/.  The
> FireWave and the LaCie speakers are often used for 'normal' 5.1 and 2.0
> playback, and need different configurations, so I used different driver
> names for these.
> 
> For these two devices, the driver name should stay the same.  All the
> other snd-oxfw device are (semi)pro devices where it does not really
> make sense to define devices like "surround51", so the driver name does
> not matter and might as well be "OXFW".)

Exactly. If userspace didn't have the configuration files, I were
willing to use 'OXFW' as driver name for all of models.

> As for the shortname, it is not an internal identifier but typically
> displayed to identify the device for the user.  Something like
> "FWSpeakers" might be recognizable, but I'd prefer the old "FireWire
> Speakers".

In this case (the old name), 'Speakers' is an identical name such as
'hw:Speakers'. IMHO, this is a bit strange because it's usual, not
identical.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
