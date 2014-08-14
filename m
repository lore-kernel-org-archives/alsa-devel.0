From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Grey noise with HDA Intel PCH
Date: Thu, 14 Aug 2014 12:20:11 +0200
Message-ID: <53EC8D5B.5020709@ladisch.de>
References: <20140814114003.7b0019f3@saldaea>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 547322615F7
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 12:20:12 +0200 (CEST)
In-Reply-To: <20140814114003.7b0019f3@saldaea>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julian Wollrath <jwollrath@web.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Julian Wollrath wrote:
> when having my soundcard not muted, I get to hear grey noise over the
> speakers or over the headphone
>
> Simple mixer control 'Master',0
>   Mono: Playback 19 [22%] [-51.00dB] [on]

This is rather low.  A lower signal level implies a worse signal-to-
noise ratio.

> Simple mixer control 'Mic',0
>   Front Left: Playback 0 [0%] [-34.50dB] [on]
>   Front Right: Playback 0 [0%] [-34.50dB] [on]

This plays any noise from the mic input.


Regards,
Clemens
