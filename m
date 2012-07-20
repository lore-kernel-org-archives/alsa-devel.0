From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: gitcompile fails
Date: Fri, 20 Jul 2012 13:38:02 +0200
Message-ID: <5009431A.6060102@perex.cz>
References: <35FE09CFAB387A4BA7ACDDED49F34518167D15@CRETE.nmmu.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id E5428265330
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2012 13:37:07 +0200 (CEST)
In-Reply-To: <35FE09CFAB387A4BA7ACDDED49F34518167D15@CRETE.nmmu.ac.za>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Brand, Mark (Mr) (Summerstrand Campus South)" <Mark.Brand@nmmu.ac.za>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Date 20.7.2012 12:30, Brand, Mark (Mr) (Summerstrand Campus South) wrote:
> Fresh (yesterday?) git clones of alsa-driver and alsa-kmirror produce a ./gitcompile failure for me:
> 
> copying file alsa-kernel/pci/hda/hda_beep.c
> patching file hda_beep.c
> Hunk #2 succeeded at 96 (offset 1 line).
> Hunk #3 succeeded at 124 (offset 1 line).
> Hunk #4 succeeded at 142 (offset 1 line).
> Hunk #5 succeeded at 164 (offset 1 line).
> Hunk #6 FAILED at 282.
> 1 out of 6 hunks FAILED -- saving rejects to file hda_beep.c.rej
> make[2]: *** [hda_beep.c] Error 1
> make[2]: Leaving directory `/home/mark/workspace/alsa-driver/pci/hda'
> make[1]: *** [prepare] Error 1
> make[1]: Leaving directory `/home/mark/workspace/alsa-driver/pci'
> make: *** [dep] Error 1
> 
> My best guess is that there is a version mismatch between the alsa-kernel/pci/hda/hda_beep.c (linked to alsa-kmirror) and pci/hda/hda_beep.patch files, since the patch seems to refer to a non-existent line-number in my source.  Any suggestions will be much appreciated, thank you.

It should be fixed now. Thank for this notice.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
