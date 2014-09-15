From: Ivica Ico Bukvic <ico@vt.edu>
Subject: question about snd_ctl_card_info_free and valgrind
Date: Mon, 15 Sep 2014 01:15:24 -0400
Message-ID: <541675EC.7060104@vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from omr2.cc.vt.edu (omr2.cc.vt.edu [198.82.141.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F2E42610A6
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 07:15:33 +0200 (CEST)
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [198.82.164.236] (may be forged))
 by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id s8F5FVuf009124
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 01:15:31 -0400
Received: from mail-qg0-f47.google.com (mail-qg0-f47.google.com
 [209.85.192.47])
 by mr4.cc.vt.edu (8.14.4/8.14.4) with ESMTP id s8F5FPoD016579
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 01:15:30 -0400
Received: by mail-qg0-f47.google.com with SMTP id i50so3328579qgf.34
 for <alsa-devel@alsa-project.org>; Sun, 14 Sep 2014 22:15:25 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all, I have the following code snippet (excerpt from pd-l2ork's 
g_audio_alsa.c that was inherited from pure-data--full version available 
at https://github.com/pd-l2ork/pd/blob/master/pd/src/s_audio_alsa.c):

         if (snd_ctl_open(&ctl, devname, 0) >= 0)
         {
             snd_ctl_card_info_malloc(&info);
             snd_ctl_card_info(ctl, info);
             desc = snd_ctl_card_info_get_name(info);
             snd_ctl_card_info_free(info);
         }

With the said implementation are no crashes or noticeable problems other 
than when ran through valgrind, I get the following error report:

==6884== Memcheck, a memory error detector
==6884== Copyright (C) 2002-2011, and GNU GPL'd, by Julian Seward et al.
==6884== Using Valgrind-3.7.0 and LibVEX; rerun with -h for copyright info
==6884== Command: pd-l2ork
==6884==
==6884== Invalid read of size 1
==6884==    at 0x719F061: vfprintf (vfprintf.c:1630)
==6884==    by 0x725D263: __vsprintf_chk (vsprintf_chk.c:86)
==6884==    by 0x725D1AC: __sprintf_chk (sprintf_chk.c:33)
==6884==    by 0x51412D: alsa_getdevs (stdio2.h:34)
==6884==    by 0x4D84DA: sys_set_audio_settings (s_audio.c:209)
==6884==    by 0x4D156A: sys_loadpreferences (s_file.c:375)
==6884==    by 0x4CD804: sys_main (s_main.c:288)
==6884==    by 0x717576C: (below main) (libc-start.c:226)
==6884==  Address 0xc1ac488 is 40 bytes inside a block of size 376 free'd
==6884==    at 0x4C2A82E: free (in 
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==6884==    by 0x51410F: alsa_getdevs (s_audio_alsa.c:857)
==6884==    by 0x4D84DA: sys_set_audio_settings (s_audio.c:209)
==6884==    by 0x4D156A: sys_loadpreferences (s_file.c:375)
==6884==    by 0x4CD804: sys_main (s_main.c:288)
==6884==    by 0x717576C: (below main) (libc-start.c:226)
==6884==
==6884== Invalid read of size 1
==6884==    at 0x71CFDB8: _IO_default_xsputn (genops.c:480)
==6884==    by 0x719EC31: vfprintf (vfprintf.c:1630)
==6884==    by 0x725D263: __vsprintf_chk (vsprintf_chk.c:86)
==6884==    by 0x725D1AC: __sprintf_chk (sprintf_chk.c:33)
==6884==    by 0x51412D: alsa_getdevs (stdio2.h:34)
==6884==    by 0x4D84DA: sys_set_audio_settings (s_audio.c:209)
==6884==    by 0x4D156A: sys_loadpreferences (s_file.c:375)
==6884==    by 0x4CD804: sys_main (s_main.c:288)
==6884==    by 0x717576C: (below main) (libc-start.c:226)
==6884==  Address 0xc1ac488 is 40 bytes inside a block of size 376 free'd
==6884==    at 0x4C2A82E: free (in 
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==6884==    by 0x51410F: alsa_getdevs (s_audio_alsa.c:857)
==6884==    by 0x4D84DA: sys_set_audio_settings (s_audio.c:209)
==6884==    by 0x4D156A: sys_loadpreferences (s_file.c:375)
==6884==    by 0x4CD804: sys_main (s_main.c:288)
==6884==    by 0x717576C: (below main) (libc-start.c:226)
==6884==
==6884== Invalid read of size 1
==6884==    at 0x71CFDC7: _IO_default_xsputn (genops.c:479)
==6884==    by 0x719EC31: vfprintf (vfprintf.c:1630)
==6884==    by 0x725D263: __vsprintf_chk (vsprintf_chk.c:86)
==6884==    by 0x725D1AC: __sprintf_chk (sprintf_chk.c:33)
==6884==    by 0x51412D: alsa_getdevs (stdio2.h:34)
==6884==    by 0x4D84DA: sys_set_audio_settings (s_audio.c:209)
==6884==    by 0x4D156A: sys_loadpreferences (s_file.c:375)
==6884==    by 0x4CD804: sys_main (s_main.c:288)
==6884==    by 0x717576C: (below main) (libc-start.c:226)
==6884==  Address 0xc1ac48a is 42 bytes inside a block of size 376 free'd
==6884==    at 0x4C2A82E: free (in 
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==6884==    by 0x51410F: alsa_getdevs (s_audio_alsa.c:857)
==6884==    by 0x4D84DA: sys_set_audio_settings (s_audio.c:209)
==6884==    by 0x4D156A: sys_loadpreferences (s_file.c:375)
==6884==    by 0x4CD804: sys_main (s_main.c:288)
==6884==    by 0x717576C: (below main) (libc-start.c:226)
==6884==
==6884== Invalid read of size 1
==6884==    at 0x719F061: vfprintf (vfprintf.c:1630)
==6884==    by 0x725D263: __vsprintf_chk (vsprintf_chk.c:86)
==6884==    by 0x725D1AC: __sprintf_chk (sprintf_chk.c:33)
==6884==    by 0x51414B: alsa_getdevs (stdio2.h:34)
==6884==    by 0x4D84DA: sys_set_audio_settings (s_audio.c:209)
==6884==    by 0x4D156A: sys_loadpreferences (s_file.c:375)
==6884==    by 0x4CD804: sys_main (s_main.c:288)
==6884==    by 0x717576C: (below main) (libc-start.c:226)
==6884==  Address 0xc1ac488 is 40 bytes inside a block of size 376 free'd
==6884==    at 0x4C2A82E: free (in 
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==6884==    by 0x51410F: alsa_getdevs (s_audio_alsa.c:857)
==6884==    by 0x4D84DA: sys_set_audio_settings (s_audio.c:209)
==6884==    by 0x4D156A: sys_loadpreferences (s_file.c:375)
==6884==    by 0x4CD804: sys_main (s_main.c:288)
==6884==    by 0x717576C: (below main) (libc-start.c:226)
==6884==
==6884== Invalid read of size 1
==6884==    at 0x719F061: vfprintf (vfprintf.c:1630)
==6884==    by 0x725D263: __vsprintf_chk (vsprintf_chk.c:86)
==6884==    by 0x725D1AC: __sprintf_chk (sprintf_chk.c:33)
==6884==    by 0x51416A: alsa_getdevs (stdio2.h:34)
==6884==    by 0x4D84DA: sys_set_audio_settings (s_audio.c:209)
==6884==    by 0x4D156A: sys_loadpreferences (s_file.c:375)
==6884==    by 0x4CD804: sys_main (s_main.c:288)
==6884==    by 0x717576C: (below main) (libc-start.c:226)
==6884==  Address 0xc1ac488 is 40 bytes inside a block of size 376 free'd
==6884==    at 0x4C2A82E: free (in 
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==6884==    by 0x51410F: alsa_getdevs (s_audio_alsa.c:857)
==6884==    by 0x4D84DA: sys_set_audio_settings (s_audio.c:209)
==6884==    by 0x4D156A: sys_loadpreferences (s_file.c:375)
==6884==    by 0x4CD804: sys_main (s_main.c:288)
==6884==    by 0x717576C: (below main) (libc-start.c:226)
==6884==
==6884== Invalid read of size 1
==6884==    at 0x719F061: vfprintf (vfprintf.c:1630)
==6884==    by 0x725D263: __vsprintf_chk (vsprintf_chk.c:86)
==6884==    by 0x725D1AC: __sprintf_chk (sprintf_chk.c:33)
==6884==    by 0x514192: alsa_getdevs (stdio2.h:34)
==6884==    by 0x4D84DA: sys_set_audio_settings (s_audio.c:209)
==6884==    by 0x4D156A: sys_loadpreferences (s_file.c:375)
==6884==    by 0x4CD804: sys_main (s_main.c:288)
==6884==    by 0x717576C: (below main) (libc-start.c:226)
==6884==  Address 0xc1ac488 is 40 bytes inside a block of size 376 free'd
==6884==    at 0x4C2A82E: free (in 
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==6884==    by 0x51410F: alsa_getdevs (s_audio_alsa.c:857)
==6884==    by 0x4D84DA: sys_set_audio_settings (s_audio.c:209)
==6884==    by 0x4D156A: sys_loadpreferences (s_file.c:375)
==6884==    by 0x4CD804: sys_main (s_main.c:288)
==6884==    by 0x717576C: (below main) (libc-start.c:226)
==6884==
==6884== Invalid read of size 8
==6884==    at 0x71CFD95: _IO_default_xsputn (genops.c:480)
==6884==    by 0x719EC31: vfprintf (vfprintf.c:1630)
==6884==    by 0x725D263: __vsprintf_chk (vsprintf_chk.c:86)
==6884==    by 0x725D1AC: __sprintf_chk (sprintf_chk.c:33)
==6884==    by 0x51412D: alsa_getdevs (stdio2.h:34)
==6884==    by 0x4D84DA: sys_set_audio_settings (s_audio.c:209)
==6884==    by 0x4D156A: sys_loadpreferences (s_file.c:375)
==6884==    by 0x4CD804: sys_main (s_main.c:288)
==6884==    by 0x717576C: (below main) (libc-start.c:226)
==6884==  Address 0xc1ada58 is 40 bytes inside a block of size 376 free'd
==6884==    at 0x4C2A82E: free (in 
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==6884==    by 0x51410F: alsa_getdevs (s_audio_alsa.c:857)
==6884==    by 0x4D84DA: sys_set_audio_settings (s_audio.c:209)
==6884==    by 0x4D156A: sys_loadpreferences (s_file.c:375)
==6884==    by 0x4CD804: sys_main (s_main.c:288)
==6884==    by 0x717576C: (below main) (libc-start.c:226)
==6884==

The repeating error refers to the line 857 which is

snd_ctl_card_info_free(info);

If I read valgrind error report, it appears there is a double free (???) 
error taking place even though there is no other place in that code that 
the snd_ctl_card_info_free is being called. Now, the loop does cycle 
through all the available alsa devices. Could this be beccause some of 
them are invalid and if so, how would one go about detecting that before 
calling snd_ctl_card_info_free?

If I comment that line (as it is currently in the linked source file on 
git), valgrind does not complain any more but I wonder if this means 
there is now a memory leak instead?

Any assistance with this is most appreciated. NB: I am not an alsa dev, 
so my knowledge of alsa lib API is rather limited beyond what I've 
briefly studied to better understand the aforesaid code snippet.

Best,

-- 
Ivica Ico Bukvic, D.M.A.
Associate Professor
Computer Music
ICAT Senior Fellow
DISIS, L2Ork
Virginia Tech
School of Performing Arts - 0141
Blacksburg, VA 24061
(540) 231-6139
ico@vt.edu
www.performingarts.vt.edu
disis.music.vt.edu
l2ork.music.vt.edu
