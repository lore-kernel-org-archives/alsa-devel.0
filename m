From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: Complex hw buffer with MMAP_COMPLEX?
Date: Tue, 9 Oct 2012 16:09:11 +0200
Message-ID: <20121009140911.GK2040@ltw.loris.tv>
References: <50742405.9070201@drcomp.erfurt.thur.de>
 <50742B6C.9080601@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
 by alsa0.perex.cz (Postfix) with ESMTP id 41C402616CD
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 16:09:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <50742B6C.9080601@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Andre Schramm <andre.schramm@iosono-sound.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 09, 2012 at 03:49:32PM +0200, Clemens Ladisch wrote:

> > That is, we're dealing with 25 (or 26 for output) interleaved streams
> > with two or eight channels each.
> >
> > How could we represent such a layout in ALSA, that is, how are we
> > talking to userspace? Would one create subdevices and rejoin them via
> > plughw?
> 
> Is it possible to start/stop the streams independently?

No, there's only a single start/stop call for the entire card.

> > Or use MMAP_COMPLEX and then let every application deal with it
> > on its own?
> 
> Alsa-lib can automatically convert this.

The only remaining question is how to tell alsa-lib about the buffer
layout.

AFAIKS, there's not even a single driver that uses MMAP_COMPLEX atm.


Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
