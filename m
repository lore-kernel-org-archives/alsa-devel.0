From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Non-Interleaved access method?
Date: Thu, 18 Oct 2012 16:34:06 +0200
Message-ID: <5080135E.4020600@ladisch.de>
References: <CAA2DH4uV6qzzJzpbZx6-MXnH4SBD11uqDkaxHnOTesvCXabM4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 3A6052652E5
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 16:35:23 +0200 (CEST)
In-Reply-To: <CAA2DH4uV6qzzJzpbZx6-MXnH4SBD11uqDkaxHnOTesvCXabM4A@mail.gmail.com>
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
> When the application set the access method to non-interleaved, that
> means that the ALSA application will deliver the non-interleaved
> buffers to alsa subsystem & the alsa subsystem will interleave the
> data before sending out the data to the hardware.

Yes.

> Or non-interleaved means that the data will be sent out in
> non-interleaved manner itself?

Only if the hardware supports it.  (Very few chips do.)


Regards,
Clemens
