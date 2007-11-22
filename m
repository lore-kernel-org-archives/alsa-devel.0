From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Channel mapping
Date: Thu, 22 Nov 2007 10:17:54 +0100
Message-ID: <1195723074.30838.1222700857@webmail.messagingengine.com>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5hr6ijhljj.wl%tiwai@suse.de>
	<1195658261.9272.1222564051@webmail.messagingengine.com>
	<Pine.LNX.4.61.0711211621310.8325@tm8103.perex-int.cz>
	<1195660340.16225.1222569047@webmail.messagingengine.com>
	<s5h8x4rwqy1.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0711211922540.8325@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6A2ED243E5
	for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2007 10:17:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0711211922540.8325@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Wed, 21 Nov 2007, Takashi Iwai wrote:
> > Indeed, the mixer <-> PCM mapping can be useful.  For such
> > information, the fixed size struct isn't suitable as multiple mixer
> > elements correspond to a single PCM channel.
> 
> I think that we have already such interface, but maybe not well described 
> and used. I would propose to use SNDRV_CTL_ELEM_IFACE_PCM for PCM mixer 
> related controls and device & subdevice from control_id structure. In this 
> way, we can easy group and assign all control elements to PCM substream.

At the moment, this is only used for sound cards that have multiple
substreams.

> We may have only one problem - to identify which elements are mixer 
> related and which are not. Maybe, we can use one bit from access flags to 
> determine, if it's a mixer control element if interface != MIXER.

I'm not sure if this information (mixer or not) is that useful - an
application is likely to access a mixer control with a 'known' meaning,
like volume or mute, and in this case it has to search the controls by
their name anyway.


Regards,
Clemens
