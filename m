From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa-lib Dmix issue
Date: Thu, 26 Jan 2017 08:52:39 +0100
Message-ID: <1aeb13c4-e84e-dc51-d596-51898a16a5d1@ladisch.de>
References: <CACmL+LCqwU8A8uq+Z=wFSazTCSMsKoRm0U+w7airoza240aHVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id B44E4266F05
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 08:53:25 +0100 (CET)
In-Reply-To: <CACmL+LCqwU8A8uq+Z=wFSazTCSMsKoRm0U+w7airoza240aHVQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anoop Rajan <anoopmannil@gmail.com>, alsa-devel@alsa-project.org
Cc: ajith karnik <ajithskarnik@gmail.com>
List-Id: alsa-devel@alsa-project.org

Anoop Rajan wrote:
>  I am trying to play a song  using dmix plugin using AlsaLib(1.0.29) , My
> kernel (Linux 3.8)hangs at poll() on snd timer interface.When I debugged
> further, I understood that poll hangs because of DMA interrupt
> (snd_pcm_period_elapsed)not been received.

This sounds like a bug in the driver.


Regards,
Clemens
