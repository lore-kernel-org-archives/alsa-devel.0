From: Daniel Mack <daniel@zonque.org>
Subject: Re: ALSA - Channel swap
Date: Tue, 19 Aug 2014 18:13:47 +0200
Message-ID: <53F377BB.90309@zonque.org>
References: <53F35310.2040300@tcz.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B60D26565E
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 18:13:49 +0200 (CEST)
In-Reply-To: <53F35310.2040300@tcz.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomas Matejka <tomas.matejka@tcz.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/19/2014 03:37 PM, Tomas Matejka wrote:
> Good afternoon,
> i have a problem:
> I use sound codec CS4202, which I control with AT91SAM9263.
> I'm using ALSA sound library.  When i use CAPTURE mode, sometimes it
> swaps left and right channel.
> I have found this discussions on Internet, where is described similar
> problem:
> 
> http://pl.it-usenet.org/thread/17996/3593/
> http://sinustrom.info/2013/03/21/atmel-soc-ssc-channel-swapping/
> 
> I have figured out, that the problem could be in driver or in ALSA
> library. Have you any solution ? Did you encountered similar problem ?

When the mismatch happens, you'll certainly have wrong data on the I2S
bus, so that bug cannot be caused by the codec driver.

The most likely reason is that the platform's (AT91SAM9263) ASoC
implementation has a problem syncing up the playback and record streams,
probably in its DMA bits. I'd start searching in that area.

I personally never worked with this platform, but for anyone else to
help you, you should provide more information, such as the kernel
version you're working with.


Daniel
