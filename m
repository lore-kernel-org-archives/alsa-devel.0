From: Andrei Tanas <andrei@tanas.ca>
Subject: Re: Asus P5QL-EM motherboard (ALC1200 codec) - no
 sound through S/PDIF
Date: Fri, 14 Nov 2008 11:06:40 -0500
Message-ID: <0e1c691b3c35afdbd5b2d56810b6f3a8@localhost>
References: <668af2a1e877d41c059f6c84fa462476@localhost>
	<1226564212.605116.29828@de>
	<9b7acddf9b27fdc3fea4444c2db912cf@localhost>
	<dfbb90e1b88698b6b74f8d59fa20600c@localhost>
	<1226638730.458905.27492@de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tanas.ca (tanas.ca [206.248.136.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 9929824333
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 17:06:42 +0100 (CET)
In-Reply-To: <1226638730.458905.27492@de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wu Fengguang <wfg@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 14 Nov 2008 12:58:44 +0800, Wu Fengguang <wfg@linux.intel.com>
wrote:
> On Thu, Nov 13, 2008 at 09:22:10AM -0500, Andrei Tanas wrote:
>> Here's "aplay -L" with autodetection
> 
> Thank you. What's the output of 'aplay -l' ?

I don't have access to the machine now. From memory, it was showing two
items: one device with two subdevices.
I'll provide you exact details later.

>> And here's "cat /proc/asound/card0/codec#0"
> 
> This is the regular codec.
> Are there /proc/asound/card0/codec#{1,2,3}?

There was only one.

> The HDMI codec would look like this one:
> % cat /proc/asound/card0/codec\#3                                        
 

I saw nothing like that.

I got an SB Audigy card and had all set up in minutes, so it's not as
important for me to get this running, but I'd like to help resolve this
anyway - there seems to be a lot of uncertainty among other Asus P5Q users.

Will it help to enable SND_VERBOSE_PRINTK and SND_DEBUG?

Thanks,
Andrei.
