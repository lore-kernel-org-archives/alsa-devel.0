From: Daniel Mack <zonque@gmail.com>
Subject: Re: Lynx HiLo USB DAC issues
Date: Thu, 12 Sep 2013 18:41:46 +0200
Message-ID: <5231EECA.1030600@gmail.com>
References: <CAAmECqTLRKu8uEpX9YHY3=W5bB0ydys2oQ2pAgHs2WjsjCqUFQ@mail.gmail.com>
 <CAAmECqRAJy=j+16Yp8kjb==905SMRhguL01CMqvMG8AP4A7QeA@mail.gmail.com>
 <CAAmECqTyhg0vPrTQzmthpjXFC_mtzO0WAs=WWbbzQ8CdkP6HzA@mail.gmail.com>
 <CAAmECqRfMqgVXSjuouqVzBX1FOGt79c+ueSQ1xLVFQAJ4QE6tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f41.google.com (mail-bk0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id CCB7D2654CD
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 18:41:47 +0200 (CEST)
Received: by mail-bk0-f41.google.com with SMTP id na10so23436bkb.0
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 09:41:47 -0700 (PDT)
In-Reply-To: <CAAmECqRfMqgVXSjuouqVzBX1FOGt79c+ueSQ1xLVFQAJ4QE6tw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Radoslaw Szkodzinski <astralstorm@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Radoslaw,

On 12.09.2013 02:43, Radoslaw Szkodzinski wrote:
> Never mind, I see the issue now. (It is late here.)
> The CLOCK_SELECTOR is read-only according to lsusb output.
> 
> Apparently uac_clock_selector_get_val fails to work, returning invalid
> pin number.
> That should not happen, but it shouldn't be called either in this
> case, as the selector is irrelevant.

Sorry, I don't follow. Given that you successfully dug into the driver
sources already, can you share a patch that makes things work for you?

The problem with the clocking framework in UAC2 is that it's quite
powerful (there are multipliers, dividers, switches etc), but I haven't
yet seen a system that actually makes uses it in more complex
applications. Hence it's not exactly easy to come up with a generic
approach of how to handle all the possible cases correctly, and how to
react on clock validity loss for instance.

Help from someone who has access to a more complex device is hence more
than welcome :)


Thanks,
Daniel
