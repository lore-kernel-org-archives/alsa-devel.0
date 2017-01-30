From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 00/19][RFC v2] ALSA: firewire-motu: new
 driver for MOTU FireWire series
Date: Mon, 30 Jan 2017 12:09:20 +0900
Message-ID: <5337c637-aae0-3d96-53d4-e1e55b1465e5@sakamocchi.jp>
References: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
 <20170129132239.GB15067@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id EC3EB26690B
 for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2017 04:09:24 +0100 (CET)
In-Reply-To: <20170129132239.GB15067@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Jan 29 2017 22:22, Jonathan Woithe wrote:
> On Sun, Jan 29, 2017 at 12:53:58PM +0900, Takashi Sakamoto wrote:
>> However, this module cannot handle 828 correctly to generate sound. The
>> reason is not clear yet.
>
> There is something odd about the 828 - I have observed this with FFADO.
> While capture works fine, playback remains resolutely muted.

Not resolutely. With this module, in the beginning of packet streaming, 
the unit can generate sound for quite a short period.

Currently I have a hypothesis that this issue comes from missing 
synchronization on a path between PDI 1394L21BE and QuickLogic DA828FW. 
As the name implies, the latter IC is designed by S&S research Inc. just 
for this unit, and there's less information.

Don't behave with your over-generalization, if being a reasonable person.


Regards

Takashi Sakamoto
