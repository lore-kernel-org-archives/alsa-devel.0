From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Mon, 28 Nov 2011 15:36:15 -0600
Message-ID: <33321.629119064$1322516193@news.gmane.org>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>	<s5hbos2g4af.wl%tiwai@suse.de>
	<1322106354.1516.951.camel@vkoul-udesk3>	<s5hfwhd29a5.wl%tiwai@suse.de>
	<1322127157.1516.973.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 948E310395B
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 22:36:17 +0100 (CET)
In-Reply-To: <1322127157.1516.973.camel@vkoul-udesk3>
Content-language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Vinod Koul' <vinod.koul@linux.intel.com>, 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

> > implementation?  At least, the term "frame" is already used in ALSA
> > PCM, and I'm not sure whether you use this term for the very same
> > meaning in the above context...

Most compressed formats have a notion of frame, but this is indeed a
different notion. In ALSA a frame is really a sampling point, possibly with
multiple channels. Compression algorithms group sampling points in frames,
or blocks, before applying a transform and quantizing. AAC works with 1024
sampling points, MPEG Layer3 with 2 granules of 576 points, AMR with 160
points, etc. 
We may want to use terms like 'blocks' or 'chunks', if this helps avoid
confusions with existing ALSA concepts.
 
> For capture, since application may need to get data on frame basis
> (think video recording with encoded video usage, where application
> needs
> audio compressed data on "frame" basis for encapsulation). The DSP is
> supposed callback after every encoded frame. I think only difference
> between PCM and this is encoding format, otherwise in terms of decoded
> data and time they would mean the same.. I am not expert here so maybe
> wrong.

For capture, in some cases the compressed bitstream doesn't provide any
pointers on the beginning of a block, nor any block-length indication (eg.
AAC-RAW). In that case, an encoder would need to pass data to user-space on
a block-by-block basis, with the bytes available in the ring buffer
corresponding to the block length. If the applications can extract 'blocks'
on their own and handle the relevant file-write/multiplexing, the usual
data-passing with regular events is fine.

For playback, the decoder is expected to deal with such situations on its
own and find the block boundaries, meaning at the application level we can
just push bytes down to the decoder without worrying. 
-Pierre
