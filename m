From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/5] ALSA: usbaudio: parse USB descriptors
 with	structs
Date: Tue, 23 Feb 2010 09:07:16 +0100
Message-ID: <20100223080716.GP28972@buzzloop.caiaq.de>
References: <1266878953-9184-1-git-send-email-daniel@caiaq.de>
	<1266878953-9184-2-git-send-email-daniel@caiaq.de>
	<4B8388C5.9070101@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id B68D8103870
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 09:07:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B8388C5.9070101@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: =?utf-8?B?5bKp5LqVIOmahg==?= <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 23, 2010 at 08:50:29AM +0100, Clemens Ladisch wrote:
> Daniel Mack wrote:
> > In preparation of support for v2.0 audio class, use the structs from
> > linux/usb/audio.h and add some new ones to describe the fields that are
> > actually parsed by the descriptor decoders.
> > ...
> > --- a/include/linux/usb/audio.h
> > +++ b/include/linux/usb/audio.h
> > @@ -81,7 +81,7 @@
> >  
> >  /* Terminal Control Selectors */
> >  /* 4.3.2  Class-Specific AC Interface Descriptor */
> > -struct uac_ac_header_descriptor {
> > +struct uac_ac_header_descriptor_v1 {
> 
> This header is already used by drivers in drivers/usb/gadget/.
> 
> If there isn't too much overlap between v1 and v2 descriptors, it might
> make sense to put them in separate headers (audio2.h) and to put the
> parsers for v1 and v2 into separate files, too.

There's a lot of overlap, v2.0 is more an extension to v1.0, with
certain incompatibilties that must be addressed. I can split the
headers, that wouldn't be a big thing. But the parsers have too many
things in common. I'll have a look whether the common parts could be
factored out somehow. I don't like 4000+ line .c files anyway ;)

Daniel
