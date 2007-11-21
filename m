From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Channel mapping
Date: Wed, 21 Nov 2007 19:37:43 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711211922540.8325@tm8103.perex-int.cz>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5hr6ijhljj.wl%tiwai@suse.de>
	<1195658261.9272.1222564051@webmail.messagingengine.com>
	<Pine.LNX.4.61.0711211621310.8325@tm8103.perex-int.cz>
	<1195660340.16225.1222569047@webmail.messagingengine.com>
	<s5h8x4rwqy1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 484B42445F
	for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 19:37:45 +0100 (CET)
In-Reply-To: <s5h8x4rwqy1.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Nov 2007, Takashi Iwai wrote:

> > > We can also encode PCM device / subdevice numbers to data structure. 
> > > But I think that best way is to extend channel_info PCM ioctl 
> > > (create new version and emulate old one - it should be quite easy to 
> > > implement).
>
> > The channel_info ioctl returns only information about one channel.
>
> OTOH, it's simple and easy to parse.  But, certainly TLV is more
> flexible for additional metadata.

I also think that it's easy to iterate over all channels to get a map.

> > I think we should have a more flexible ioctl that also allows us to
> > describe the PCM device itself (such as volume controls that affect
> > all channels, or latency information).
> 
> Indeed, the mixer <-> PCM mapping can be useful.  For such
> information, the fixed size struct isn't suitable as multiple mixer
> elements correspond to a single PCM channel.

I think that we have already such interface, but maybe not well described 
and used. I would propose to use SNDRV_CTL_ELEM_IFACE_PCM for PCM mixer 
related controls and device & subdevice from control_id structure. In this 
way, we can easy group and assign all control elements to PCM substream.

We may have only one problem - to identify which elements are mixer 
related and which are not. Maybe, we can use one bit from access flags to 
determine, if it's a mixer control element if interface != MIXER.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
