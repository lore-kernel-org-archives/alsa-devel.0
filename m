From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Information request - writing a driver for a
 virtual soundcard
Date: Wed, 18 Aug 2010 21:33:54 +0200
Message-ID: <20100818193354.GM17833@buzzloop.caiaq.de>
References: <AANLkTiksDnhg=kBupJ1uQO_vXq+8q-tk+TXwAwgtRaSm@mail.gmail.com>
	<20100818191510.GL17833@buzzloop.caiaq.de>
	<AANLkTi=EO295r9BpmR105gYLRsjFhG3_kiD81mHTSLKP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A98E710383D
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 21:33:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=EO295r9BpmR105gYLRsjFhG3_kiD81mHTSLKP@mail.gmail.com>
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

(please never remove any people from the list of recipients when
 replying, and please do not top-post)

On Wed, Aug 18, 2010 at 09:27:36PM +0200, Olof wrote:
> I want to connect my smartphone to my amplifier and then use it as a
> virtual soundcard. The actual sound data shall be transmitted over
> wireless TCP/IP from my laptop to the smartphone, enabling me to move
> around in the flat without wiring.

I still don't understand where the actual audio material has its origin,
or where it should be sent to, respectively.

> Thought a virtual soundcard was a
> good idea since it the whole system then would be independent of
> application playing sound on the laptop. I intended to do the
> compressing & transmission in user space, but perhaps everything can
> be done in user space? I wasn't aware of the possibility. Where can I
> read more?

I think the easiest API to access your existing sound cards and to
create virtual sinks and sources is offered by PulseAudio:

  http://pulseaudio.org/wiki/DeveloperDocumentation

In case your distribution uses PulseAudio natively, you souldn't even
need to set up anything.

HTH,
Daniel
