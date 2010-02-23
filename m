From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/5] ALSA: usbaudio: parse USB descriptors
 with	structs
Date: Tue, 23 Feb 2010 09:10:32 +0100
Message-ID: <20100223081032.GQ28972@buzzloop.caiaq.de>
References: <1266878953-9184-1-git-send-email-daniel@caiaq.de>
	<1266878953-9184-2-git-send-email-daniel@caiaq.de>
	<4B8388C5.9070101@ladisch.de> <s5h7hq42xlf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 8EBF7103896
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 09:10:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7hq42xlf.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 23, 2010 at 08:57:32AM +0100, Takashi Iwai wrote:
> At Tue, 23 Feb 2010 08:50:29 +0100,
> Clemens Ladisch wrote:
> > 
> > Daniel Mack wrote:
> > > In preparation of support for v2.0 audio class, use the structs from
> > > linux/usb/audio.h and add some new ones to describe the fields that are
> > > actually parsed by the descriptor decoders.
> > > ...
> > > --- a/include/linux/usb/audio.h
> > > +++ b/include/linux/usb/audio.h
> > > @@ -81,7 +81,7 @@
> > >  
> > >  /* Terminal Control Selectors */
> > >  /* 4.3.2  Class-Specific AC Interface Descriptor */
> > > -struct uac_ac_header_descriptor {
> > > +struct uac_ac_header_descriptor_v1 {
> > 
> > This header is already used by drivers in drivers/usb/gadget/.
> > 
> > If there isn't too much overlap between v1 and v2 descriptors, it might
> > make sense to put them in separate headers (audio2.h) and to put the
> > parsers for v1 and v2 into separate files, too.
> 
> Good point.  But this can be in another patch?

It does break compilation though, so I'll fix that up somehow before
merge.

Daniel
