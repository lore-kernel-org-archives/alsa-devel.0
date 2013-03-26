From: David Flater <vger@flaterco.com>
Subject: Re: [bug] sbawe: the PnP won't stop
Date: Mon, 25 Mar 2013 21:04:56 -0400
Message-ID: <5150F438.6090902@flaterco.com>
References: <514E640E.4060502@flaterco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay01.pair.com (relay01.pair.com [209.68.5.15])
 by alsa0.perex.cz (Postfix) with SMTP id 41A23264EFD
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 02:05:01 +0100 (CET)
In-Reply-To: <514E640E.4060502@flaterco.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This problem now appears to be bigger than just sbawe or ALSA.

- The clone-and-reallocate behavior happened with the gameport too, even
  though I didn't mess with that at all.  The gameport is discovered by some
  driver as a legacy port, then later rediscovered and reallocated with
  different resources as a PnP gameport.

- The kernel parameter pnp_reserve_dma, which ought to be the right way to
  avoid getting DMA 5, doesn't do anything.

The cleanest workaround seems to be to noisapnp the kernel, use the userspace
/sbin/isapnp tool, and provide ALSA module options as for a non-PnP card.

On 03/23/2013 10:25 PM, David Flater wrote:
> I've got an ISA PnP SB AWE type card in a system with a non-working DMA 5.
> Without intervention, the Sound Blaster always gets the broken DMA.  I have
> no BIOS options to control the allocation of DMAs, and the PnP configuration
> done within ALSA ignores /etc/isapnp.conf [*].  DMA 6 works fine if I can get
> sbawe to stop re-initializing the PnP and just use it.
