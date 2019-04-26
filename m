From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Will we ever see a low latency/high performance
 PCM api for usb, firewire, avb ?
Date: Fri, 26 Apr 2019 08:37:24 +0200
Message-ID: <e287f788-82f9-d9e2-0380-d8f66d2b422b@perex.cz>
References: <trinity-467bdb56-fbf5-484d-a3a7-6fb0f9b14eab-1556225642297@3c-app-gmx-bs08>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ADAE9F80C41
 for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2019 08:37:27 +0200 (CEST)
In-Reply-To: <trinity-467bdb56-fbf5-484d-a3a7-6fb0f9b14eab-1556225642297@3c-app-gmx-bs08>
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
To: Ralf Beck <musical_snake@gmx.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 25. 04. 19 v 22:54 Ralf Beck napsal(a):
> Subject says it all.
> 
> During the Dec/Jan period i did some USB patches for the Motu AVB series and a trivial alsa driver to connect my Motu via AVB for a single i/o stream. So i discovered how totally unsuitable the mmapped ringbuffer model of alsa is for the above types of interfaces. Is there any intention to change this ?
> I've read that this has already been discussed during miniconf 2017 (USB) and 2018 (AVB). Any results?

Any idea to improve the transfer method? The problem with the serial buses is
that you have to queue usually more samples to avoid underruns. The system
scheduling comes to play, too (no direct DMA transfers from the audio buffer
without further main CPU intervention).

Also, you can write only read/write driver without mmap support (ALSA API
supports this mode). But I don't think that it will help much. If you have
problem to find good ring buffer size / period size settings, it's usually
because of the hardware limitation or the system scheduler settings.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
