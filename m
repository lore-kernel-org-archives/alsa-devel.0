From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Complex hw buffer with MMAP_COMPLEX?
Date: Tue, 09 Oct 2012 15:49:32 +0200
Message-ID: <50742B6C.9080601@ladisch.de>
References: <50742405.9070201@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 94F742616CD
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 15:49:36 +0200 (CEST)
In-Reply-To: <50742405.9070201@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Cc: alsa-devel@alsa-project.org, Andre Schramm <andre.schramm@iosono-sound.com>
List-Id: alsa-devel@alsa-project.org

Adrian Knoth wrote:
> That is, we're dealing with 25 (or 26 for output) interleaved streams
> with two or eight channels each.
>
> How could we represent such a layout in ALSA, that is, how are we
> talking to userspace? Would one create subdevices and rejoin them via
> plughw?

Is it possible to start/stop the streams independently?
If yes, this might be useful.

(And subdevices are usually used for streams that are mixed together.)

> Or use MMAP_COMPLEX and then let every application deal with it
> on its own?

Alsa-lib can automatically convert this.  Applications that insist
on using hw devices have to deal with it (Jack does).


Regards,
Clemens
