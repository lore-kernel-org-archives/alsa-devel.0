From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [PATCH 0/5] ALSA: firewire-tascam: add MIDI
	functionality
Date: Tue, 13 Oct 2015 20:32:28 +1030
Message-ID: <20151013100228.GA16452@marvin.atrad.com.au>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151012144816.130ac379@kant>
 <20151012222019.GB16052@marvin.atrad.com.au>
 <561CD0A0.6000708@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C7242617A4
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 12:02:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <561CD0A0.6000708@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 13, 2015 at 06:36:32PM +0900, Takashi Sakamoto wrote:
> On Oct 13 2015 07:20, Jonathan Woithe wrote:
> >On Mon, Oct 12, 2015 at 02:48:16PM +0200, Stefan Richter wrote:
> >>On Oct 12 Takashi Sakamoto wrote:
> >>>Although TASCAM FireWire series has physical controls, this patchset
> >>>doesn't support them. I think some facilities are required to enable this
> >>>functionality:
> >>>  * handling MIDI messages on virtual MIDI ports by this driver
> >>>  * handling status and control messages in isochronous packet by this
> >>>    driver
> >>
> >>As a side note, AFAIR, RME devices encapsulate status in their isochronous
> >>stream too... or was it MOTU?
> >
> >Both do, but in completely different ways for different purposes. ...
> 
> I don't know the reason that you're interested in it, while I'm not
> currently interested in it.

My comment was to clarify things for Stefan.  Stefan was simply making the
observation that Tascam are not the only devices which send non-audio data
through iso packets.

> When the status and control messages are handled by the drivers, consumers
> are userspace applications. Userspace applications perform some reactions
> against the status and control messages. Most of the reactions are archieved
> via fw character devices.

That depends on what those reactions are.  But yes, in *most* cases it's
userspace that will be most interested in these data.

> When considering about userspace applications, permissions of fw character
> devices are important.

For sure.  However, for cases like MOTU, where mixer control setting updates
are pushed to the computer by the device in response to front panel actions,
there will be a need for userspace to somehow tap into this flow.  Userspace
could not gain access to the iso stream because the kernel will have control
over that.  Or can userspace tap into iso streams that have been initiated
by the kernel (that is surprising to me if it's true).

> If possible, I'd like to add enough rules to udevd, including RME and MOTU
> models before working for them.

I have some ideas about how both of these device families might fit in.  No
code yet, unfortunately, due to an unexpectedly busy year.  Note that the
issue of non-audio data extraction from the iso stream to user space isn't
relevant for RME: it's only MOTU which will require this.  In any case, it
goes beyond udevd permissions.

> I'm glad to get your help for these issues, Stefan and Jonathan.

Now that there is functional infrastructure within ALSA to build on I am
hoping to start experimenting with RME and MOTU devices over the next few
months by porting my FFADO streaming drivers to ALSA.

Regards
  jonathan
