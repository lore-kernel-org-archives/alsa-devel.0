From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH 1/2] ALSA: add DSD formats
Date: Sun, 07 Apr 2013 02:07:49 +0300
Message-ID: <5160AAC5.70401@sonarnerd.net>
References: <1365248693-27867-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id D6B59265013
 for <alsa-devel@alsa-project.org>; Sun,  7 Apr 2013 01:07:50 +0200 (CEST)
Received: from porkkala.uworld (porkkala.uworld [IPv6:fc00::2])
 by mail.sonarnerd.net (Postfix) with ESMTP id 64D741966CAA
 for <alsa-devel@alsa-project.org>; Sun,  7 Apr 2013 02:07:49 +0300 (EEST)
In-Reply-To: <1365248693-27867-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/06/2013 02:44 PM, Daniel Mack wrote:
>                                                     configured hardware
>          352.8kHz       705.6KHz     1411.2KHz  <----       sample rate
>
> 8-bit     2.8MHz         5.6MHz       11.2MHz
> 16-bit    5.6MHz        11.2MHz
>
>           `-----------------------------------'
>                   actual DSD sample rates

This looks fine, I would just put a comment somewhere like "oldest bit 
is in LSB" or "oldest bit is in MSB". Then for the U16 rest is about 
question of byte endianess for hw vs sw...

Of course, from decoding point of view oldest-in-LSB is easiest since it 
becomes just "y = x & 1; x >>= 1;" loop, while for encoding 
oldest-in-MSB is easiest since it's "x |= y; x <<= 1;"
