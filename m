From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Multi-channel playback
Date: Wed, 13 Apr 2016 08:51:28 +0200
Message-ID: <570DEC70.6040004@ladisch.de>
References: <3CD7D8096827214EA72BFDC6B95C7CC931B68E10@VEREXCH02.harrisbroadcast.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id C264C2650DB
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 08:51:35 +0200 (CEST)
In-Reply-To: <3CD7D8096827214EA72BFDC6B95C7CC931B68E10@VEREXCH02.harrisbroadcast.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Li, Steve" <Steve.Li@imaginecommunications.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Li, Steve wrote:
> I am trying to playback a multi-channel PCM stream, e.g. 5.1. Is there an API for configuring the channel positions?

Yes, but not many devices support it.

> calling snd_pcm_get_chmap() return NULL.

Your device (driver), whatever it is, doesn't support reading it either.


Regards,
Clemens
