From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Dummy module and sample rates
Date: Thu, 24 Sep 2015 09:02:11 +0200
Message-ID: <56039FF3.3030203@ladisch.de>
References: <56029069.60700@weiss.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id D9BD32612D1
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 09:02:13 +0200 (CEST)
In-Reply-To: <56029069.60700@weiss.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uli Franke <uli.franke@weiss.ch>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Uli Franke wrote:
> I fiddled around with the Dummy module and it seems to be the thing
> we're looking for. I observed a rather strange behavior though:
>
> I set the hw params sample rate to 44k1 without error, but a subsequent
> call of snd_pcm_start returns EPIPE. When setting hw params sample rate
> to 4k this does not happen.

In theory, this error code is returned if you didn't write any samples
into the buffer before starting.

An underrun is possible too, but should be reported later AFAIK.
Could you check if a larger buffer size helps?


Regards,
Clemens
