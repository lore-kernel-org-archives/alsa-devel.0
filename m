From: Mark Hills <mark@xwax.org>
Subject: Re: S/PDIF and track markers (echo3g)
Date: Fri, 24 Jun 2016 09:55:08 +0100 (BST)
Message-ID: <1606181913390.29270@beth.localdomain>
References: <1606171339510.3384@stax.localdomain> <576436BA.4090104@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 by alsa0.perex.cz (Postfix) with ESMTP id 2737D261A06
 for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2016 10:55:10 +0200 (CEST)
In-Reply-To: <576436BA.4090104@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 17 Jun 2016, Anssi Hannula wrote:

> 17.06.2016, 16:29, Mark Hills kirjoitti:
> > Hi,
> 
> Hi,
> 
> > Is there any provision in ALSA (either within the kernel or libasound) for 
> > extracting track marker information from S/PDIF?
> 
> I don't know what track marker data looks like, but see below.
> 
> > I have a large number of MiniDisc recordings to preserve as FLAC format.
> > 
> > Losing track markers would be a huge inconvenience, though I don't care 
> > for the rest of the metadata (track names etc..)
> > 
> > There's enough recordings to be worth developing specific software for the 
> > archival if it can access this information.
> > 
> > I don't really know which path is likely to be successful:
> > 
> > * An ALSA API to access the information; though I can't see anything
> >   specific to track markers
> > 
> > * Whether a timecode could be used to detect track change; but I can't see 
> >   any in /proc/asound/Layla3G/status
> > 
> > * Does ALSA provide access to raw AES streams, so I could decode it in 
> >   userland? I'm un-sure if this relates to hardware AC3 decoding.
> 
> ALSA does provide access to the raw stream with drivers that support
> that. You'll need to record with IEC958_SUBFRAME_LE or
> IEC958_SUBFRAME_BE sample formats.

Thanks, that's very useful information.
 
> > * Maybe this sort of status is only available to the firmware of the 
> >   interface and never makes it to userland (in my case, echo3g); though I 
> >   can see some constants relating to 'non audio' S/PDIF.
> 
> Unfortunately the echo3g driver doesn't seem to support
> IEC958_SUBFRAME_* sample formats.

Ah, as I'd suspect. And probably there is a lot of logic in the firmware 
that would have to cooperate.

> The HDA driver, used for most mainboard/laptop integrated audio, does
> support that format if the hardware is capable. I'm not sure if the
> hardware commonly supports that format or not, though.

This is the hardware I have on my motherboard, but it doesn't have the 
optical input I would need.

Perhaps I can find a reasonably priced PCI Express card with the 
capability.

Thanks for your help, I have a feeling this is the most promising route. 
But it does assume the MiniDisc deck is outputting this information (it 
definitely acknoledges it on input)

> > The hardware I have here is Echo Layla 3G (snd-echo3g) and a Pioneer 
> > MJ-D707 MiniDisc recorder.
> > 
> > Any advice appreciated -- many thanks.

Thanks

-- 
Mark
