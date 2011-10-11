From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: question for the snd_pcm_mmap_writen.
Date: Tue, 11 Oct 2011 16:23:54 +0200
Message-ID: <4E94517A.6000405@ladisch.de>
References: <C516192DA6D2B74F8192CDC209D958FD5826629B96@dr-mail>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id AF5571038C5
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Oct 2011 16:24:30 +0200 (CEST)
In-Reply-To: <C516192DA6D2B74F8192CDC209D958FD5826629B96@dr-mail>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anders Gnistrup <agn@datarespons.dk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 10/11/2011 02:06 PM, Anders Gnistrup wrote:
> I have a embedded device with a 8 channel audio chip.
> I only have to use 5 of these channels
> My goal is not to use any cpu cycles on the 3 unused channels
>
> I have decided to use the non-interleaved method

This helps only if your device actually supports non-interleaved data.
Otherwise, the samples of all eight channels will have to be converted.

> For this, the function snd_pcm_mmap_writen could be used.

Please note that using mmap makes sense only if you write the data
directly into the device's buffer.  If you only use snd_pcm_mmap_write*,
you could just as well use snd_pcm_write* without mmap.

> Q1)
> Should/must the **bufs be continuations -> bufs[0][size]==bufs[1][0]???

No.

> Q2)
> Is is possible the set bufs[2] == NULL, to signal that the channel is unused?

No, all channels must have data.

> Q3)
> I have tried to find some information about the SND_PCM_ACCESS_MMAP_COMPLEX. What is this???

Typically, it's used for devices that are constructed by mergng multiple
interleaved streams.  Each channel is described by the address of its
first sample and the distance between two consecutive samples.


Regards,
Clemens
