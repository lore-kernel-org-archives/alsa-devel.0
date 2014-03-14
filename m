From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] [PATCH] firewire-lib: add support for AV/C
 deferred transaction
Date: Fri, 14 Mar 2014 23:24:55 +0100
Message-ID: <532381B7.3030903@ladisch.de>
References: <5323151D.3010706@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 71FDA262610
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 23:25:36 +0100 (CET)
In-Reply-To: <5323151D.3010706@sakamocchi.jp>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, linux1394-devel@lists.sourceforge.net, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Can I request your comments about attached patch?
>
> This is for adding support of deferred transaction into
> snd-firewire-lib. I confirm some BeBoB devices use this type of
> transaction. If you have no negative comments, I'll add this patch for
> my series.

Looks OK.

> For 'undefined interval' between INTERIM and final response, I want to
> use 'FCP_TIMEOUT_MS' (=125msec) again. In specifications which I can
> read, there is no limit for this interval. But I need to promise to
> finish this function for callers.

In theory, a device that uses INTERIM is likely to need a larger timeout
than the FCP default, but as long as 125 ms works for those BeBoB devices,
increasing the timeout is not necessary.


Regards,
Clemens
