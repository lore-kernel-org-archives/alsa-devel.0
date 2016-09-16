From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: arecord: does hardware or software throw away
	unused
Date: Fri, 16 Sep 2016 09:26:00 +0200
Message-ID: <19996f68-0a7b-807b-6519-64720afb1e19@ladisch.de>
References: <CALAeOVNogPUjK68n6LozD4j0y9RhO3ObaduANshG0+mg-8+1Rw@mail.gmail.com>
 <a69bb60f-63d6-8979-070f-a0a6ad0cfe6b@ladisch.de>
 <CALAeOVODpXGbY-gRD9_p3_q+=nyi0f6hNqK7e7iGcX9yrn+0pg@mail.gmail.com>
 <d4151ac9-bad3-22eb-90f8-17bdf26b62be@ladisch.de>
 <CALAeOVOdJ1c12PyfbsEfTP3Z=8ZuWXJm_gQASG=vr4cjEDnLQg@mail.gmail.com>
 <485b922c-3ec6-87ac-fccc-023940583a36@ladisch.de>
 <CALAeOVOXDKcJYvc3AJbPUgS29LnZd4xW3LeSFJSWU+FwO8h=Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 4B69B265ACA
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2016 09:26:00 +0200 (CEST)
In-Reply-To: <CALAeOVOXDKcJYvc3AJbPUgS29LnZd4xW3LeSFJSWU+FwO8h=Cw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Nertney <rob@rob-otics.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rob Nertney wrote:
> If I define my hw_params like this, is it correct for multiple channels?
>
> channels_min = 1
> channels_max = 16

I don't know what the actual constraints of your hardware are.

> buffer_bytes_max = 32768
> period_bytes_min = 32768/16
> period_bytes_max = 32768/16
> periods_min = 16
> periods_max = 16
>
> Everything is really associated around a 2048 Byte IRQ.

Is that an actual constraint of your hardware?

Anyway, this will not work with, e.g., 15 channels; 60-byte frames do
not fit into 32768 bytes.


Regards,
Clemens
