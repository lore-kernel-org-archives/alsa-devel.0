From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Handling non-buffer-sized MMAP requests
Date: Mon, 13 Dec 2010 09:56:25 +0100
Message-ID: <4D05DFB9.3080407@ladisch.de>
References: <6e2495d80bd7915f371b984cc4b4a503.squirrel@master.museresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id DE2211037E3
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 09:53:38 +0100 (CET)
In-Reply-To: <6e2495d80bd7915f371b984cc4b4a503.squirrel@master.museresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: louis@museresearch.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

louis@museresearch.com wrote:
> Hi everyone, I'm having some difficulty improving a full-duplex MMAP ALSA
> routine.  ALSA sometimes reports more samples available for input than my
> buffer can take, or asks for more samples than I have available.  Is this
> a buffer overrun/underrun? 

Yes.  (And this should happen only when you've disabled stopping on
an xrun, so you've asked for it.  :-)

> If I restart the streams in the case that too
> much input is available (on the assumption that it's an xrun) it seems to
> happen at the drop of a hat and makes things worse.  If I discard the
> excess input, that doesn't work well either.
> 
> What is the appropriate way to deal with this situation?

The best way would be to prevent this situation from happening, i.e.,
read the captured data from the buffer before it overflows.

(In the case of capturing, latency does _not_ depend on the buffer size,
so you should make the buffer as big as possible.)


Regards,
Clemens
