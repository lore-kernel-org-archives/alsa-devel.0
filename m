From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: What are subdevices?
Date: Mon, 27 Oct 2014 20:46:45 +0100
Message-ID: <544EA125.80909@ladisch.de>
References: <544CAD55.8070605@gmail.com> <544CBACF.2080702@ladisch.de>
 <544CC58C.3080800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id A53912614FD
 for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 20:46:50 +0100 (CET)
Received: from [192.168.42.83] (tmo-103-50.customers.d1-online.com
 [80.187.103.50])
 by dehamd003.servertools24.de (Postfix) with ESMTPSA id A9CABF8083
 for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 20:45:42 +0100 (CET)
In-Reply-To: <544CC58C.3080800@gmail.com>
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

dE wrote:
> typically cards have a single analog device but support multichannel
> output. So how does this work at the software level? If ALSA can't
> send multiple streams of audio to one device, then how does ALSA send
> separate output to different channels of the device?

The channels are not separate.  For a stereo devices, the samples are
arranged like LRLRLRLRLR...; for more channels, there are more
interleaved values: 123456123456123456123456...


Regards,
Clemens
