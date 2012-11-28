From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: SOC that needs L/R data in separate buffers
Date: Tue, 27 Nov 2012 23:13:22 -0500
Message-ID: <CAKON4OzLvNUNsWXoaBMy+BFT-dhv2sAW6ytPXpTWkKEjoS+w0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id B0D9826030F
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 05:13:23 +0100 (CET)
Received: by mail-ie0-f179.google.com with SMTP id 9so9557050iec.38
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 20:13:22 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Is there a format in ALSA for hardware that wants the L/R stereo data
in two different buffers and not inter-leaved? Hardware has two DMA
channels into separate FIFOs for L/R.

If not I guess I have to unpack it inside the device driver. Doing
that will mess up mixing since ALSA won't know where the real DMA
buffer is.

FIFOs are only four samples deeps so that's probably too many
interrupts/sec to do programmed IO when FIFO is half full.


--
Jon Smirl
jonsmirl@gmail.com
