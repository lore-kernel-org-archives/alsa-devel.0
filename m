From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Getting stable PCM device id
Date: Wed, 08 Jul 2015 18:23:57 +0200
Message-ID: <559D4E9D.5010900@ladisch.de>
References: <CAP737oJhCD_20qobOBZYfy60e0mXEjO9OP8hmxb3J5bod=ZDvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 884FC264F09
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 18:25:23 +0200 (CEST)
In-Reply-To: <CAP737oJhCD_20qobOBZYfy60e0mXEjO9OP8hmxb3J5bod=ZDvw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Bique <bique.alexandre@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alexandre Bique wrote:
> I wonder how to get a PCM identifier that would be stable if you
> reboot or plug/unplug sound cards in a random order.
>
> I'm not an expert in hardware ids, yet I imagine that we could use the
> hardware serial number or equivalent?

The most detailed identification is likely to show up in the card's longname.


Regards,
Clemens
