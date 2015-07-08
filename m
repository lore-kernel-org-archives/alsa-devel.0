From: Alexandre Bique <bique.alexandre@gmail.com>
Subject: Re: Getting stable PCM device id
Date: Wed, 8 Jul 2015 18:55:12 +0200
Message-ID: <CAP737o+SyzWn1m5TaGwWbsWz9wy9_NNpo9Q2SiR+ZfVLtowc3Q@mail.gmail.com>
References: <CAP737oJhCD_20qobOBZYfy60e0mXEjO9OP8hmxb3J5bod=ZDvw@mail.gmail.com>
 <559D4E9D.5010900@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
 [209.85.217.169])
 by alsa0.perex.cz (Postfix) with ESMTP id B943F26596E
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 18:55:32 +0200 (CEST)
Received: by lbcpe5 with SMTP id pe5so59888841lbc.2
 for <alsa-devel@alsa-project.org>; Wed, 08 Jul 2015 09:55:32 -0700 (PDT)
In-Reply-To: <559D4E9D.5010900@ladisch.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 8, 2015 at 6:23 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Alexandre Bique wrote:
>> I wonder how to get a PCM identifier that would be stable if you
>> reboot or plug/unplug sound cards in a random order.
>>
>> I'm not an expert in hardware ids, yet I imagine that we could use the
>> hardware serial number or equivalent?
>
> The most detailed identification is likely to show up in the card's longname.

This is the identifier - name - longname:

Found card: hw:1 - HDA Intel PCH - HDA Intel PCH at 0xf7c30000 irq 26

Pointer and irq does not really help :)

-- 
Alexandre Bique
