From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: firewire: remove support for 16 bit
 PCM samples in playback substream
Date: Mon, 22 May 2017 16:21:47 +0200
Message-ID: <19968091-3930-87af-be06-f5a8332b669a@ladisch.de>
References: <20170522132221.16733-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 532F9266E84
 for <alsa-devel@alsa-project.org>; Mon, 22 May 2017 16:21:52 +0200 (CEST)
In-Reply-To: <20170522132221.16733-1-o-takashi@sakamocchi.jp>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> As long as I know, models which support IEC 61883-1/6 doesn't allow to
> switch bit length of PCM sample in MBLA data channel. They always
> transmit/receive PCM frames of 24 bit length. This can be seen for the
> other models which support protocols similar to IEC 61883-1/6.
>
> On the other hand, current drivers for these protocols supports 16 bit
> length PCM sample in playback substream. In this case, PCM sample is put
> into the MBLA data channel with 8 bit padding in LSB side. Although 16
> bit PCM sample is major because it's in CD format, this doesn't represent
> device capability as is.

I added 16-bit support in fear of programs that do not use automatic
sample format conversion (hardcoded "hw:X" or OSS).

> This commit removes support for 16 bit PCM samples in playback substream.

Other devices without 16-bit support appear to work fine nowadays.

> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Acked-by: Clemens Ladisch <clemens@ladisch.de>
