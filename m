From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 15:06:48 +0100
Message-ID: <20120821140648.GC21557@sirena.org.uk>
References: <s5hr4r0359e.wl%tiwai@suse.de> <50337316.4080208@ladisch.de>
 <50339485.30500@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 72CA7265F8E
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 16:06:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <50339485.30500@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 21, 2012 at 04:00:37PM +0200, David Henningsson wrote:
> On 08/21/2012 01:37 PM, Clemens Ladisch wrote:

> >This doesn't handle devices with simply numbered outputs (such as many
> >ICE1712-based devices), or cases where one PCM channel can be routed to
> >multiple outputs.  However, those devices typically have their own mixer
> >applets, and generic applications aren't interested in configuring them.

> As for routing more than one channel in the map from the same PCM,
> that seems a bit more complex. Maybe one could do a bitmap of
> channels instead of just one channel (with say, 32 room channel
> positions and 32 just numbered positions, that would be 64 bits).
> But how common is that anyway?

It's very common on the embedded side to use pure numbered stuff (or at
least to assign semantics dynamically at runtime which I suspect boils
down to the same thing here).
