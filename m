From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ASoC: mmap or read/write?
Date: Thu, 18 Oct 2012 16:32:20 +0200
Message-ID: <508012F4.5050204@ladisch.de>
References: <CAA2DH4uhwV0NmxEbLKN=m+VC9ruOHM13Vpu1m33j0DNm+n6yKQ@mail.gmail.com>	<507FC752.1050005@ladisch.de>
 <CAA2DH4v4DUxf5Qh79nehTPD+22v6XddzDrEMmnBu2eM8m4JXzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id F05DA2652E5
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 16:33:37 +0200 (CEST)
In-Reply-To: <CAA2DH4v4DUxf5Qh79nehTPD+22v6XddzDrEMmnBu2eM8m4JXzg@mail.gmail.com>
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
> in my case, I will anyway have to copy the buffers to mmap-ed area.

This is *exactly* the same what snd_pcm_writei() already does.


Regards,
Clemens
