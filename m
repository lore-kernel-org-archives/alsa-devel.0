From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002172]: Assertion `file->wbuf_used_bytes
	< file->wbuf_size_bytes' failed
Date: Mon, 29 May 2006 20:18:27 +0200
Message-ID: <7f7465cf3f9ebcc492e64c4beb0328f9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 848E1159
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 20:18:27 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2172> 
======================================================================
Reported By:                sgoodall
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   2172
Category:                   0_general
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-29-2006 20:18 CEST
Last Modified:              05-29-2006 20:18 CEST
======================================================================
Summary:                    Assertion `file->wbuf_used_bytes <
file->wbuf_size_bytes' failed
Description: 
I have my .asoundrc setup to forward PCM data to a fifo file. When the fifo
fills up, it triggers the following assert causing whatever program is
writing the PCM data to abort.

pcm_file.c:112: snd_pcm_file_add_frames: Assertion `file->wbuf_used_bytes
<
file->wbuf_size_bytes' failed.

.asoundrc config

pcm.!default {
  type plug
  slave.pcm "stdout"
}


pcm.stdout {
  type file
  file "/tmp/airportfifo"
  slave {
    pcm "hw:0,0"
  }
}

where /tmp/airportfifo has been created with "mknod /tmp/airportfifo p"

It seems to wait to write data if the fifo is full initially, but if it is
not full and then fills up, this triggers the assert.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-29-06 20:18 sgoodall       New Issue                                    
05-29-06 20:18 sgoodall       File Added: bt.txt                           
======================================================================
