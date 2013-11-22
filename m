From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: While writing to speaker sometimes segmentation
 fault comes.
Date: Fri, 22 Nov 2013 12:07:20 +0100
Message-ID: <528F3AE8.9050109@ladisch.de>
References: <1750043993.107445.1385097675393.JavaMail.zimbra@iwavesystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 42FD3261631
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 12:07:23 +0100 (CET)
In-Reply-To: <1750043993.107445.1385097675393.JavaMail.zimbra@iwavesystems.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ranjith vs <ranjithvs@iwavesystems.com>, alsa-devel@alsa-project.org
Cc: krishna ks <krishnaks@iwavesystems.com>
List-Id: alsa-devel@alsa-project.org

ranjith vs wrote:
> i'm getting segmentation fault in the snd_pcm_writei function.

Then there's something wrong with the code that calls it.

I'd guess that you computed the frames parameter as bytes.

> And one more thing is that eventhough I try to set the buffer size to
> 4096. It is setting it's own value.

The buffer size is constrained by the hardware capabilities.


Regards,
Clemens
