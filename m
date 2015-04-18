From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Support for Synchronous Audio
Date: Sat, 18 Apr 2015 12:36:00 +0200
Message-ID: <55323390.9070407@ladisch.de>
References: <1429258074046.61439@librewireless.com>,
 <5530CD6E.4080408@ladisch.de>
 <1429266530143.46159@librewireless.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 33E1B2615F7
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 12:36:30 +0200 (CEST)
In-Reply-To: <1429266530143.46159@librewireless.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anoop Rajan <anoop@librewireless.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Anoop Rajan wrote:
> As I told we support synchronous multiroom audio, where in one speaker
> (master) streams the audio to others nodes(slave) over the network.
> Master speaker  future timestamps the audio and re-transmits to all
> other nodes based on a common reference clock maintained. Our stack
> implements the logic to present the audio synchronously to ALSA
> monitoring the stamped time.We are not using snd_pcm_link().

Well, snd_pcm_link() would work only on a single computer.

> We use MT-7620 SOC from Mediatek.

What sound hardware and driver are you using?


Regards,
Clemens
