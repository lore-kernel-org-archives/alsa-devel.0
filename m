From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Maximum buffer size on HDA
Date: Mon, 16 Jun 2008 14:29:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806161415010.1798@tm8103-a.perex-int.cz>
References: <20080613191303.GA3899@tango.0pointer.de>
	<s5hzlplpt58.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806161246330.1798@tm8103-a.perex-int.cz>
	<s5hprqhpok8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 0403024588
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 14:29:06 +0200 (CEST)
In-Reply-To: <s5hprqhpok8.wl%tiwai@suse.de>
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

On Mon, 16 Jun 2008, Takashi Iwai wrote:

> At Mon, 16 Jun 2008 12:53:11 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > On Mon, 16 Jun 2008, Takashi Iwai wrote:
> > 
> > > At Fri, 13 Jun 2008 21:13:03 +0200,
> > > Lennart Poettering wrote:
> > > > 
> > > > Heya,
> > > > 
> > > > the HDA driver allows a playback buffer size of something like 64K
> > > > onyl. Is this a driver limitation or a limitation of the hardware?
> > > > Skimming through the docs I cannot see anything like this, and I got
> > > > the idea that the audio buffer is maintained in system memory, not
> > > > sound card memory, so why this limit?
> > > 
> > > This comes from the buffer pre-allocator.
> > > Run the below:
> > > 
> > > 	# echo 1024 > /proc/asound/card0/pcm0p/sub0/prealloc
> > > 
> > > then you can use now 1MB buffer.  snd-hda-intel has max
> > > pre-allocation buffer size 1MB, and this is the hard-coded limit.
> > > 
> > > It's rather a silly constraint, and I think it'd be better cut off.
> > > OTOH, this makes the system safer (e.g. avoiding page allocations for
> > > too large buffers), and there is a proper workaround, too.
> > > So, I'm open about this change, so far.
> > 
> > Which workaround you're talking about?
> 
> Reset a proc file manually like the above.  Without this, you cannot
> allocate the buffer over the pre-allocated size.

I'm not quite sure what you like to change. Make 1MB limit smaller? Or 
change the default preallocated size? Or remove preallocation? I think 
that it might make sense to increase the default preallocation value to 
128KB or 192KB.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
