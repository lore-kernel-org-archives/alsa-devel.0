From: Daniel Mack <daniel@zonque.org>
Subject: Re: caiaq driver: audio 4 dj and jackd
Date: Mon, 2 Dec 2013 10:59:48 +0100
Message-ID: <20131202095948.GA2886@tamtam.fritz.box>
References: <529BF843.6000608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id EA58E2619F9
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 10:59:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <529BF843.6000608@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Antonio Ospite <ao2@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 01, 2013 at 07:02:27PM -0800, Gabriel M. Beddingfield wrote:
> A user was having trouble using the NI Audio 4 DJ device with jackd.
> When jack connected, this 4-in/4-out device would appear as
> 2-in/2-out. This was the result of the fact that the channels are
> split up into stereo substreams.  I.e. the first two channels are
> found in hw:x,0,0 and the last two channels are in hw:x,0,1.

That's right, but I don't see a problem with that. Why was jack having
trouble using the two interfaces? After all, the streams are guaranteed
to be synchronous, as they share the same clock in hardware.

> The work-around was to use the `multi' plug-in to make these 2 PCM's
> appear as a single PCM.

Yes, that's the other possibility.

> Ideally, substream 0 would support 1, 2, or 4 channels (for both
> playback and capture).  When substream 0 is using more than 2
> channels, then substream 1 would return EBUSY when in use.
> 
> So... would it be possible to do this in the caiaq driver?

Technically yes, but changing that would mean breakage for all other
users, and making it configurable would result in yet another moving
part which makes things even more complex.


Thanks,
Daniel
