From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Thu, 04 Jul 2013 13:00:30 +0200
Message-ID: <51D555CE.7040807@ladisch.de>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
 <51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
 <51D22CAE.2020302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 9F96326568D
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2013 13:00:34 +0200 (CEST)
In-Reply-To: <51D22CAE.2020302@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joel Fernandes <joelf@ti.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

Joel Fernandes wrote:
> On 07/01/2013 01:10 AM, Mike Looijmans wrote:
>> The trouble with the current davinci driver is that the IRQ handler has a
>> real-time requirement, it must finish before the next DMA block completes. This
>> causes most of the buffer overruns on heavily loaded systems.
>
> But how do you get around not calling snd_pcm_period_elapsed in a time-sensitive
> fashion?

To ensure that other stuff is completed first, snd_pcm_period_elapsed()
could be called later from a tasklet.  (snd_pcm_period_elapsed() calls
the .pointer callback, which could be another source of delays depending
on how much hardware accesses it does.)


Regards,
Clemens
