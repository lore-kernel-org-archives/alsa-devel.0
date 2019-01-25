From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer
	support
Date: Fri, 25 Jan 2019 19:24:29 +0800
Message-ID: <CAMz4kuKZOpAXG=Lwii5Cb6q2EKoMUJOEmDz8X=dmVv+JivWf=w@mail.gmail.com>
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
 <20190118190805.GF6260@sirena.org.uk>
 <s5hzhrxzrez.wl-tiwai@suse.de> <20190121124053.GA12679@sirena.org.uk>
 <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz>
 <20190122202535.GK7579@sirena.org.uk>
 <s5h4l9z4mbo.wl-tiwai@suse.de> <20190123124658.GE15906@leoy-ThinkPad-X240s>
 <3962daba-f6ed-d706-c618-b791a1ba6b59@perex.cz>
 <CAMz4kuK5JgfZF7uXa83xC3eVCrZ8+wkZRdKq2s71o_QjT=OhGg@mail.gmail.com>
 <s5h1s51120e.wl-tiwai@suse.de> <s5hwomtyr6o.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 47A342673DD
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 12:24:41 +0100 (CET)
Received: by mail-lf1-f68.google.com with SMTP id z13so6654750lfe.11
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 03:24:41 -0800 (PST)
In-Reply-To: <s5hwomtyr6o.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, gustavo@embeddedor.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, mchehab+samsung@kernel.org, sr@denx.de, Daniel Thompson <daniel.thompson@linaro.org>, Jon Corbet <corbet@lwn.net>, Phil Burk <philburk@google.com>, Matthew Wilcox <willy@infradead.org>, Jeffery Miller <jmiller@neverware.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, colyli@suse.de, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, anna-maria@linutronix.de, Mathieu Poirier <mathieu.poirier@linaro.org>, sboyd@kernel.org, LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>, Leo Yan <leo.yan@linaro.org>, joe@perches.com
List-Id: alsa-devel@alsa-project.org

On Fri, 25 Jan 2019 at 18:20, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 25 Jan 2019 11:10:25 +0100,
> Takashi Iwai wrote:
> >
> > On Fri, 25 Jan 2019 10:25:37 +0100,
> > Baolin Wang wrote:
> > >
> > > Hi Jaroslav,
> > > On Thu, 24 Jan 2019 at 21:43, Jaroslav Kysela <perex@perex.cz> wrote:
> > > >
> > > > Dne 23.1.2019 v 13:46 Leo Yan napsal(a):
> > > > > Hi all,
> > > > >
> > > > > On Wed, Jan 23, 2019 at 12:58:51PM +0100, Takashi Iwai wrote:
> > > > >> On Tue, 22 Jan 2019 21:25:35 +0100,
> > > > >> Mark Brown wrote:
> > > > >>>
> > > > >>> On Mon, Jan 21, 2019 at 03:15:43PM +0100, Jaroslav Kysela wrote:
> > > > >>>> Dne 21.1.2019 v 13:40 Mark Brown napsal(a):
> > > > >>>
> > > > >>>>> It was the bit about adding more extended permission control that I was
> > > > >>>>> worried about there, not the initial O_APPEND bit.  Indeed the O_APPEND
> > > > >>>>> bit sounds like it might also work from the base buffer sharing point of
> > > > >>>>> view, I have to confess I'd not heard of that feature before (it didn't
> > > > >>>>> come up in the discussion when Eric raised this in Prague).
> > > > >>>
> > > > >>>> With permissions, I meant to make possible to restrict the file
> > > > >>>> descriptor operations (ioctls) for the depending task (like access to
> > > > >>>> the DMA buffer, synchronize it for the non-coherent platforms and maybe
> > > > >>>> read/write the actual position, delay etc.). It should be relatively
> > > > >>>> easy to implement using the snd_pcm_file structure.
> > > > >>>
> > > > >>> Right, that's what I understood you to mean.  If you want to have a
> > > > >>> policy saying "it's OK to export a PCM file descriptor if it's only got
> > > > >>> permissions X and Y" the security module is going to need to know about
> > > > >>> the mechanism for setting those permissions.  With dma_buf that's all a
> > > > >>> bit easier as there's less new stuff, though I've no real idea how much
> > > > >>> of a big deal that actually is.
> > > > >>
> > > > >> There are many ways to implement such a thing, yeah.  If we'd need an
> > > > >> implementation that is done solely in the sound driver layer, I can
> > > > >> imagine to introduce either a new ioctl or an open flag (like O_EXCL)
> > > > >> to specify the restricted sharing.  That is, a kind of master / slave
> > > > >> model where only the master is allowed to manipulate the stream while
> > > > >> the slave can mmap, read/write and get status.
> > > > >
> > > > > In order to support EXCLUSIVE mode, it is necessary to convert the
> > > > > /dev/snd/ descriptor to an anon_inode:dmabuffer file descriptor.
> > > > > SELinux allows that file descriptor to be passed to the client. It can
> > > > > also be used by the AAudioService.
> > > >
> > > > Okay, so this is probably the only point which we should resolve for the
> > > > already available DMA buffer sharing in ALSA (the O_APPEND flag).
> > > >
> > > > I had another glance to your dma-buf implementation and I see many
> > > > things which might cause problems:
> > > >
> > > > - allow to call dma-buf ioctls only when the audio device is in specific
> > > > state (stream is not running)
> > >
> > > Right. Will fix.
> > >
> > > > - as Takashi mentioned, if we return another file-descriptor (dma-buf
> > > > export) to the user space and the server closes the main pcm
> > > > file-descriptor (the client does not) - the result will be a crash (dma
> > > > buffer will be freed, but referenced through the dma-buf interface)
> > >
> > > Yes, will fix.
> >
> > There are a few more overlooked problems.  A part of them was already
> > mentioned in my previous reply, but let me repeat:
> >
> > - The racy ioctls have to be considered; you can perform this export
> >   ioctl concurrently, and both of them write and mix up the setup,
> >   which is obviously broken.
> >
> > - The PCM buffer can be re-allocated on the fly.  If the current
> >   buffer is abandoned while exporting, it leads to the UAF.
> >
> > - Similarly, what if the PCM stream that is attached is closed without
> >   detaching itself?  Or, what if the PCM stream attaches itself twice
> >   without detaching?
> >
> > - The driver may provide its own mmap method, and you can't hard-code
> >   the mmap implementation as currently in snd_pcm_dmabuf_mmap().
> >
> >   I suppose you can drop of most of the code in snd_pcm_dmabuf_map(),
> >   instead, assign PCM substream in obj, and call snd_pcm_mmap_data()
> >   with the given VMA.  If this really works, it manages the mmap
> >   refcount, so the previous two issues should be covered there.
> >   But it needs more consideration...
>
> Erm, obviously it's not enough.  Each attach / detach needs to manage
> the refcount, too, for covering the cases above.  It can re-use the
> PCM mmap_refount, though.

But we've used the DMA buffer file's refcounting to manage the DMA
buffer. So is this not enough?

-- 
Baolin Wang
Best Regards
