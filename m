From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: cloning snd_seq_t (or creating one from client id)
Date: Mon, 31 Mar 2014 23:01:19 +0200
Message-ID: <5339D79F.8060502@ladisch.de>
References: <53390BC4.5090900@gmx.net> <53395FA7.5050704@ladisch.de>
 <53397E54.2060309@tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 9B4A626512D
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 23:01:24 +0200 (CEST)
Received: from [192.168.42.96] (tmo-096-93.customers.d1-online.com
 [80.187.96.93])
 by dehamd003.servertools24.de (Postfix) with ESMTPSA id EDF8C20E381F
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 23:01:03 +0200 (CEST)
In-Reply-To: <53397E54.2060309@tu-dresden.de>
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

Tobias Schlemmer wrote:
> ALSA imposes a policy
> that is obviously is not necessary from a technical point of view as
> every program instance can use different sequencer clients already with
> the current implementation at the cost of worsening the usability. My
> suggestion is to losen this restriction.

What you call "loosening this restriction" would actually involve
a nontrivial amount of code.

> P.S.: We are talking about the library API right?

Most of the client event handling is implemented in the kernel.

However, a threadsafe event (de)multiplexer could just as well be
implemented completely outside of the ALSA library.


Regards,
Clemens
