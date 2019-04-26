From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Will we ever see a low latency/high performance
 PCM api for usb, firewire, avb ?
Date: Fri, 26 Apr 2019 14:22:47 +0200
Message-ID: <fa3a4950-a0ba-c3fd-5ec7-923a59ee9a78@ladisch.de>
References: <trinity-467bdb56-fbf5-484d-a3a7-6fb0f9b14eab-1556225642297@3c-app-gmx-bs08>
 <e287f788-82f9-d9e2-0380-d8f66d2b422b@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [IPv6:2a01:4f8:212:88::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 160B0F8961C
 for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2019 14:22:48 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 99251558355F
 for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2019 14:22:47 +0200 (CEST)
In-Reply-To: <e287f788-82f9-d9e2-0380-d8f66d2b422b@perex.cz>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> Any idea to improve the transfer method? The problem with the serial buses is
> that you have to queue usually more samples to avoid underruns.

When the ALSA buffer is not mmapped, it is possible to treat the contents of the
packet buffers as the ring buffer, i.e., to write the sample data directly into
the packets, ideally even after they have been queued.


Regards,
Clemens
