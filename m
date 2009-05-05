From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Call out after period buffer is filled
Date: Tue, 5 May 2009 11:31:42 -0400
Message-ID: <9e4733910905050831s3001d6a9xbe556e33ffc058c0@mail.gmail.com>
References: <9e4733910905050735g168d2c4ibf1ce91538557513@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 1297410382B
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 17:31:45 +0200 (CEST)
Received: by fxm18 with SMTP id 18so5255227fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 05 May 2009 08:31:44 -0700 (PDT)
In-Reply-To: <9e4733910905050735g168d2c4ibf1ce91538557513@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 5, 2009 at 10:35 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> Is there some way to get a call out after a period DMA buffer is
> filled so that I can add it to the DMA queue?

The current model in my driver is to queue up a bunch of DMA
descriptors, one per period. When I queue these I don't know if the
DMA buffers have music in them or not. I then start this queue playing
and tell ALSA when each period has finished. After each period plays I
requeue the descriptor. I keep hoping that ALSA can get these filled
before they start playing.

After the last period plays ALSA calls trigger(STOP). At that point I
try to shut down the DMA hardware and get the descriptors back. But
because of the FIFO and asynchronous DMA engine I can't stop DMA fast
enough in the trigger(STOP) routine. The result is that the next
period starts playing. This period has data from earlier in the stream
and it sounds like a burst of noise.

What I need is a call back indicating which buffers have valid data in
them. When I know the buffer is valid I can queue the descriptor. This
will fix the problem at end of stream since there won't be buffers
queued containing invalid data.

-- 
Jon Smirl
jonsmirl@gmail.com
