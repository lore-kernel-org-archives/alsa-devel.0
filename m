From: Anoop Rajan <anoop@librewireless.com>
Subject: Re: Support for Synchronous Audio
Date: Fri, 17 Apr 2015 10:28:50 +0000
Message-ID: <1429266530143.46159@librewireless.com>
References: <1429258074046.61439@librewireless.com>,
 <5530CD6E.4080408@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0125.outbound.protection.outlook.com [65.55.169.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 885B126053E
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 12:28:54 +0200 (CEST)
In-Reply-To: <5530CD6E.4080408@ladisch.de>
Content-Language: en-IN
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi Clemens,

As I told we support synchronous multiroom audio, where in one speaker(master) streams the audio to others nodes(slave) over the network. Master speaker  future timestamps the audio and re-transmits to all other nodes based on a common reference clock maintained. Our stack implements the logic to present the audio synchronously to ALSA monitoring the stamped time.We are not using snd_pcm_link().

We use MT-7620 SOC from Mediatek.


Thanks,
Anoop 
________________________________________
From: Clemens Ladisch <clemens@ladisch.de>
Sent: 17 April 2015 14:37
To: Anoop Rajan; alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Support for Synchronous Audio

Anoop Rajan wrote:
> We have requirements to play synchronous multi-room audio with very
> minimal node to node latency(<100 us). [...] Though I make sure that
> I start the PCM  from user layer synchronously

How?  With snd_pcm_link()?

What hardware are you using?


Regards,
Clemens
