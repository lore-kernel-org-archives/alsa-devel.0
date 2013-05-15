From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Handling HDA FIFO error
Date: Wed, 15 May 2013 11:08:55 +0200
Message-ID: <519350A7.3000606@ladisch.de>
References: <CAMLZHHT8Q4iV5Ug8s6XyA1-LNWUe+WH3a0jEqHTbXYC-ihzy7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2C86E260319
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 11:09:00 +0200 (CEST)
In-Reply-To: <CAMLZHHT8Q4iV5Ug8s6XyA1-LNWUe+WH3a0jEqHTbXYC-ihzy7w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Drake <dsd@laptop.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Drake wrote:
> Digging into the HDA code, I can see that normally, when the stream
> gets started, we get interrupts with SD_STS as 0x24. In the failure
> case, as soon as we start the stream, we get a flood of interrupts
> with SD_STS 0x8 - which indicates FIFO error.
>
> Disabling interrupt generation upon FIFO error does not help much - it
> avoids the flood of interrupts, but doesn't change the fact that audio
> playing apps hang or loop infinitely.
>
> Are there any things I could check that would explain why a FIFO error
> might be occurring?

Probably a buffer underrun, i.e., the controller did not manage to
read samples from memory fast enough.

> any suggestions for how to improve the hda_intel driver to handle
> FIFO error gracefully? Right now there is no code to handle that.

It should stop the stream, i.e., go into the xrun state.

In theory, the application restarting the stream should reset the DMA
engine enough to make it work again.  But you say this happens also
when starting the stream, so I guess more resetting is needed.


Regards,
Clemens
