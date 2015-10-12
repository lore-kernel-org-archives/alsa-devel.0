From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [PATCH 0/5] ALSA: firewire-tascam: add MIDI
 functionality
Date: Tue, 13 Oct 2015 08:50:19 +1030
Message-ID: <20151012222019.GB16052@marvin.atrad.com.au>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151012144816.130ac379@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id DAE4B2614E3
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 00:20:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20151012144816.130ac379@kant>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 12, 2015 at 02:48:16PM +0200, Stefan Richter wrote:
> On Oct 12 Takashi Sakamoto wrote:
> > Although TASCAM FireWire series has physical controls, this patchset
> > doesn't support them. I think some facilities are required to enable this
> > functionality:
> >  * handling MIDI messages on virtual MIDI ports by this driver
> >  * handling status and control messages in isochronous packet by this
> >    driver
> 
> As a side note, AFAIR, RME devices encapsulate status in their isochronous
> stream too... or was it MOTU?

Both do, but in completely different ways for different purposes.  In the
case of RME devices the information communicated can be used to help control
and monitor the streaming system but it is not essential: there are other
arguably easier ways to maintain the streaming rates, and these alternatives
are what we use in FFADO now.

In MOTU devices the information relates mainly to device control changes
which are made via the front panel controls.  This is used to keep software
mixer/control programs in sync with the hardware when changes are made on
the hardware while the software control application is running.  It sounds
like this is close to what the Tascam units do based on Takashi's comments
(although obviously with a very different protocol).

jonathan
