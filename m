From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ASoC: mmap or read/write?
Date: Thu, 18 Oct 2012 11:09:38 +0200
Message-ID: <507FC752.1050005@ladisch.de>
References: <CAA2DH4uhwV0NmxEbLKN=m+VC9ruOHM13Vpu1m33j0DNm+n6yKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id D374F2625FC
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 11:10:56 +0200 (CEST)
In-Reply-To: <CAA2DH4uhwV0NmxEbLKN=m+VC9ruOHM13Vpu1m33j0DNm+n6yKQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Prasant J <pj0585@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Prasant J wrote:
> I'm writing an alsa application for recording & playing 16 channel audio.
>
> The application is intended to run on an embedded platform & the
> resources are highly constrained.

Then I wonder how you manage to handle 16 channels.
What hardware is this?

> My application is not performing well with read/write methods.

How much CPU usage?

> Does the mmap method has any advantages over read/write?

No, except when then samples are generated in/consumed from the
device's buffer directly without copying them around, and even then
it's unlikely that the time needed for copying actually matters.

> Is there any thumb rule to decide when to use mmap or read/write?

Yes; use read/write.


Regards,
Clemens
