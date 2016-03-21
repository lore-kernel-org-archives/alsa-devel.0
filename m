From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: amidi.c.patch review request
Date: Mon, 21 Mar 2016 08:46:40 +0100
Message-ID: <56EFA6E0.1010303@ladisch.de>
References: <alpine.LFD.2.20.1603201658110.27665@mylaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 4B422261A5E
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2016 08:46:41 +0100 (CET)
In-Reply-To: <alpine.LFD.2.20.1603201658110.27665@mylaptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: m.tarenskeen@zonnet.nl, Alsa-devel mailinglist <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Martin Tarenskeen wrote:
> My synth sends continuously not only 0xFE (Active Sensing) but also
> 0xF8 (Timing Clock). 24 times per quarter note to be exactly. With
> a fast tempo like 250 BPM this gives a 0xF8 byte every 10 ms. Until
> now when I tried to fetch a SysEx dump from my synth using amidi the
> data were polluted with lots of 0xF8 bytes and the -t option would
> not work. A bug I would say.
>
> The attached patch seems to solve this issue, but please comment and
> improve where needed.

> -			err = poll(pfds, npfds, 200);
> +			err = poll(pfds, npfds, 5);

This does not help when the clocks are sent faster.

To properly handle this, there needs to be a separate timer for the
timeout.  I'm working on this ...


Regards,
Clemens
