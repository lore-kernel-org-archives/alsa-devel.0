From: "Geoffrey D. Bennett" <g@b4.vu>
Subject: Re: [PATCH RFC RESEND] ALSA: usb-audio: Scarlett mixer
	interface for 18i20 Gen 2
Date: Thu, 25 Apr 2019 05:33:25 +0930
Message-ID: <20190424200325.GA6126@b4.vu>
References: <20190423235842.GA3614@b4.vu> <s5himv3oep6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from b4.vu (b4.vu [203.16.231.147])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BBE4AF89618
 for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2019 22:03:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5himv3oep6.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 24, 2019 at 12:55:17PM +0200, Takashi Iwai wrote:
> On Wed, 24 Apr 2019 01:58:42 +0200,
> Geoffrey D. Bennett wrote:
> > 
> > Add mixer quirk for the Focusrite Scarlett 18i20 Gen 2 audio
> > interface. Although the interface is USB compliant, additional
> > hardware mixing, routing, and metering functionality is available
> > using proprietary USB requests.
> > 
> > Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
> > ---
> > (ping resend (no changes) as no feedback received for 3 weeks)
> 
> Oh sorry, I must have overlooked the post.

No problem, thank you for your feedback.

> > - I added a private field to struct snd_usb_audio for storing the
> >   private mixer data. This seems wrong, but I didn't know where else I
> >   could/should put that data.
> 
> Hm, this is a thing I'd like to avoid as much as possible.
> Currently, each usb_mixer_elem_info may have a private pointer, and
> the original scarlett quirk uses it for storing its own "type"
> information.  This could be used for storing the data instead?
[...]

The original scarlett quirk private data is all related to each of the
mixer elements that they are attached to, but the private data I am
storing is unrelated to any specific mixer element (e.g. an
incrementing sequence number that is included in every proprietary USB
request). Do you think that I should just attach the data to the first
mixer element?

I have started work on extending the driver to support the 18i8 2nd
Gen interface as well, so I will incorporate all your feedback into
that and resend once complete.

Thanks again,
Geoffrey.
