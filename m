From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: spdif input, source synchronous?
Date: Thu, 24 Jan 2013 12:49:43 +0100
Message-ID: <51011FD7.5020405@ladisch.de>
References: <50A17AEC.2080102@radagast.org>
 <1B9FEF259F5D4B4F83CD1C9FF0CF0FDB@mediascore.mediascore.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 5ACFF261696
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 12:49:45 +0100 (CET)
In-Reply-To: <1B9FEF259F5D4B4F83CD1C9FF0CF0FDB@mediascore.mediascore.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rafal Powierski <powierski@mediascore.de>
Cc: alsa-devel@alsa-project.org, Dave Platt <dplatt@radagast.org>
List-Id: alsa-devel@alsa-project.org

Rafal Powierski wrote:
> ... ALC886 SPDIF input.
> The test results show that the input is not "source synchronous"
>
> It seams that my HDA clock is a bit slower then definition ( about -10ppm)
> Therefore resampling starts below -10ppm
> It probably means that when spdif signal is 0ppm, about 10ppm of samples are missing.

And real S/PDIF inputs probably are all over the map ...

> Is this a bug? or it is planed like this?

The HDA specification describes source synchronous streams, but does
not mandate them.

Apparently, the ALC886 does not support source synchronous streams.
A quick Google search shows only the WM8850 (which also has a real
sample rate converter).


Regards,
Clemens
