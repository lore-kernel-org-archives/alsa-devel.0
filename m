From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Disabling buffer fill level preprocessing by ALSA
Date: Mon, 31 Dec 2007 18:12:27 +0100
Message-ID: <20071231171226.GA17953@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FAA410385D
	for <alsa-devel@alsa-project.org>; Mon, 31 Dec 2007 18:12:29 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi!

In PulseAudio I want to schedule on my own when I need to write audio
data into the device and when not. To achieve that I want to be
notified via poll() whenever a period boundary is passed (i.e. when an
IRQ happens), but only then. That's different from the usual mode
where you are notified via poll() whether there is space in the
playback buffer that needs to be filled up. 

On OSS the mmap() mode enables a mode like I described above. After
enabling mmap() the application can decide by itself what it considers
full and what empty in the dma buffer, and use GETOPTR to query the
playback position. poll() on the OSS fd will directly reflect the
sound card IRQs and is not influenced if you ever wrote data to device
or not.

I assume that I can enable a mode like that with one of the SW
params. But quite frankly the docs for it are not enlighening at all.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
