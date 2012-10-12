From: "Paul D. DeRocco" <pderocco@ix.netcom.com>
Subject: Question about rawmidi USB Tx buffer size
Date: Fri, 12 Oct 2012 14:58:58 -0700
Message-ID: <D5EEE172F274435D9FE0A154CE63E5B4@PAULD>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-scoter.atl.sa.earthlink.net
 (elasmtp-scoter.atl.sa.earthlink.net [209.86.89.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 8032A26162E
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2012 23:58:52 +0200 (CEST)
Received: from [76.173.239.22] (helo=PAULD)
 by elasmtp-scoter.atl.sa.earthlink.net with esmtpa (Exim 4.67)
 (envelope-from <pderocco@ix.netcom.com>) id 1TMnFr-0002AO-AL
 for alsa-devel@alsa-project.org; Fri, 12 Oct 2012 17:58:51 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Simple question: how big is it?

ALSA provides snd_rawmidi_status for reading the status structure from a
rawmidi handle, and snd_rawmidi_status_get_avail to extract the number of
bytes in the ring buffer from that structure, but what I want to know is how
many bytes of space are available in the ring buffer, so that I know how
many bytes I can write without blocking. Is the buffer size a fixed number
for any particular driver? The only driver I'm concerned with is the USB
MIDI driver, so that shouldn't be hardware dependent.

-- 

Ciao,               Paul D. DeRocco
Paul                mailto:pderocco@ix.netcom.com 
 
