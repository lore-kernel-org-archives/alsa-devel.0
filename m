From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Information request - writing a driver for a
 virtual soundcard
Date: Wed, 18 Aug 2010 21:15:10 +0200
Message-ID: <20100818191510.GL17833@buzzloop.caiaq.de>
References: <AANLkTiksDnhg=kBupJ1uQO_vXq+8q-tk+TXwAwgtRaSm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D90CC24476
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 21:15:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTiksDnhg=kBupJ1uQO_vXq+8q-tk+TXwAwgtRaSm@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Olof <olof@baah.se>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 18, 2010 at 07:53:29PM +0200, Olof wrote:
> Maybe this is the wrong place to ask, but I kinda feel that I'm out of options.

ALSA allows rerouting of audio material to arbitary userspace plugins,
which sounds like what you're looking for. PulseAudio also give you
similar options, so it seems unnecessary to hack around in kernel space.

What exactly are you trying to do?

Daniel


> My goal is to write a dummy driver which makes the PCM data available
> as a character device though /dev/whatever. Of course I start with the
> dummy pcm driver. However I find it difficult to understand how the
> driver shall poll PCM data from the ALSA framework. I've read the
> how-to-write-a-driver doc and studied the hda driver but I don't
> understand how it all fits together with substreams, reading from
> intermediate buffers, the PCM memory management functions etc.
> 
> Could someone please help me out with some pointers to additional
> documentation, a suitable piece of driver code to study or any thing
> that might help?
> 
> Kind Regards,
> Olof
