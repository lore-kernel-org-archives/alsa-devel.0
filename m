From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [FFADO-devel] [RFC][PATCH 0/3] ALSA: fireface: new
 driver for RME Fireface series (MIDI only)
Date: Mon, 7 Dec 2015 08:27:44 +1030
Message-ID: <20151206215744.GA6103@marvin.atrad.com.au>
References: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id EACF4261615
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 22:57:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 06, 2015 at 10:23:41PM +0900, Takashi Sakamoto wrote:
> Unfortunately, ffado library can disturb this functionality.
> In RME::Device::init_hardware() function, the library sends a write transaction
> to 0x0000801003f4 with invalid value as higher part of address in IEEE 1212 or
> ISO/IEC 13213. This is a worst case I describe in patch 03.

The number which FFADO writes to this register is not invalid: it is in fact
the same number which is used in drivers on other operating systems
(obtained from protocol analysis).

> I think it better that FFADO developers fixes the bug as long as they doesn't
> support MIDI functionality.

As above, this is not exactly a bug because other systems set that register
to the value which FFADO uses.  In the interests of interoperability I'm
willing to remove manipulation of this register from FFADO, but I suggest
that in time the ALSA driver should consider setting this register as is
done under other systems or else we could introduce subtle behavioural
differences down the track - at least until such time as we understand what
the high part of that register does.

jonathan
