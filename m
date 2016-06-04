From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: CIP Discontinuity with snd-firewire-digi00x
Date: Sun, 5 Jun 2016 07:58:46 +0900
Message-ID: <57535D26.2080105@sakamocchi.jp>
References: <alpine.LNX.2.20.1606041726460.13950@anticlack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id CF0F02614A1
 for <alsa-devel@alsa-project.org>; Sun,  5 Jun 2016 00:58:52 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.20.1606041726460.13950@anticlack.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lin-alsa@noblejury.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I've used the same unit for my development and test.

On Jun 5 2016 07:30, lin-alsa@noblejury.com wrote:
> Unfortunately, the mixer seems to desync or something after a few
> minutes - hours. dmesg gives me `snd-firewire-digi00x fw1.0: Detect
> discontinuity of CIP: XX XX` with XX XX replaced with various hex
> pairs.

The hex pairs is important in this log, too.

On Jun 5 2016 07:30, lin-alsa@noblejury.com wrote:
> so I don't think it's an external clock issue.

Tell me the reason that you judge that quality of the external signal to
optical interface as ADAT sync is enough good and realiable.


Regards

Takashi Sakamoto
