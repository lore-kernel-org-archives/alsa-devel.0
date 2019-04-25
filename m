From: "Ralf Beck" <musical_snake@gmx.de>
Subject: Will we ever see a low latency/high performance PCM
 api for usb, firewire, avb ?
Date: Thu, 25 Apr 2019 22:54:02 +0200
Message-ID: <trinity-467bdb56-fbf5-484d-a3a7-6fb0f9b14eab-1556225642297@3c-app-gmx-bs08>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D712F8961C
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2019 22:54:03 +0200 (CEST)
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

Subject says it all.

During the Dec/Jan period i did some USB patches for the Motu AVB series and a trivial alsa driver to connect my Motu via AVB for a single i/o stream. So i discovered how totally unsuitable the mmapped ringbuffer model of alsa is for the above types of interfaces. Is there any intention to change this ?
I've read that this has already been discussed during miniconf 2017 (USB) and 2018 (AVB). Any results?
