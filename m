From: Daniel Mack <daniel@zonque.org>
Subject: Re: ALSA - Channel swap
Date: Wed, 20 Aug 2014 14:41:10 +0200
Message-ID: <53F49766.6060907@zonque.org>
References: <53F35310.2040300@tcz.cz> <53F377BB.90309@zonque.org>
 <53F49680.2050003@tcz.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id F368B2656E9
 for <alsa-devel@alsa-project.org>; Wed, 20 Aug 2014 14:41:11 +0200 (CEST)
In-Reply-To: <53F49680.2050003@tcz.cz>
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

Hi,

On 08/20/2014 02:37 PM, Tomas Matejka wrote:
> My kernel version is 3.2.18.
> I can't uderstand this, does this mean that using Atmel, Linux and audio 
> codec always result to channel swapping?
> It would be very strange. How could codec manufacturer sell codec, which 
> swaps channels ?
> I need this for application that requires that audio channels can't be 
> randomly swapped.

It's probably only a race condition that can be fixed in software. I've
seen such issues before.

But in order to work on this and get more feedback, you have to try a
more recent kernel (3.16 or 3.17-rc1). Maybe the issue is even already
fixed.


Daniel
