From: "Brand, Mark (Mr) (Summerstrand Campus South)" <Mark.Brand@nmmu.ac.za>
Subject: gitcompile fails
Date: Fri, 20 Jul 2012 10:30:29 +0000
Message-ID: <35FE09CFAB387A4BA7ACDDED49F34518167D15@CRETE.nmmu.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from osiris.nmmu.ac.za (osiris.nmmu.ac.za [196.21.198.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BA1D265322
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2012 12:30:47 +0200 (CEST)
Received: from TUKTUK.nmmu.ac.za (tuktuk.nmmu.ac.za [10.103.121.195])
 by osiris.nmmu.ac.za (8.13.8/8.13.8) with ESMTP id q6KAUUrK012840
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2012 12:30:38 +0200
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Fresh (yesterday?) git clones of alsa-driver and alsa-kmirror produce a ./gitcompile failure for me:

copying file alsa-kernel/pci/hda/hda_beep.c
patching file hda_beep.c
Hunk #2 succeeded at 96 (offset 1 line).
Hunk #3 succeeded at 124 (offset 1 line).
Hunk #4 succeeded at 142 (offset 1 line).
Hunk #5 succeeded at 164 (offset 1 line).
Hunk #6 FAILED at 282.
1 out of 6 hunks FAILED -- saving rejects to file hda_beep.c.rej
make[2]: *** [hda_beep.c] Error 1
make[2]: Leaving directory `/home/mark/workspace/alsa-driver/pci/hda'
make[1]: *** [prepare] Error 1
make[1]: Leaving directory `/home/mark/workspace/alsa-driver/pci'
make: *** [dep] Error 1

My best guess is that there is a version mismatch between the alsa-kernel/pci/hda/hda_beep.c (linked to alsa-kmirror) and pci/hda/hda_beep.patch files, since the patch seems to refer to a non-existent line-number in my source.  Any suggestions will be much appreciated, thank you.

Mark Brand.

________________________________

NOTICE: Please note that this eMail, and the contents thereof, is subject to the standard NMMU eMail disclaimer which may be found at:
http://www.nmmu.ac.za/disclaimer/email.htm
