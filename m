From: Henning Thielemann <alsa@henning-thielemann.de>
Subject: snd_seq_parse_address accesses uninitialised data
Date: Sun, 23 Sep 2012 19:08:09 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1209231903310.21223@anubis.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgate5.urz.uni-halle.de (mailgate5.urz.uni-halle.de
 [141.48.3.10]) by alsa0.perex.cz (Postfix) with ESMTP id CE11A2615E5
 for <alsa-devel@alsa-project.org>; Sun, 23 Sep 2012 19:08:11 +0200 (CEST)
Received: from mserv3.urz.uni-halle.de ([141.48.3.161])
 by mlucom18.urz.uni-halle.de with esmtps (TLSv1:RC4-MD5:128)
 (Exim 4.77) id 1TFpf9-0001Eg-BD for <alsa-devel@alsa-project.org>
 ; Sun, 23 Sep 2012 19:08:11 +0200
Received: from hermes.informatik.uni-halle.de ([141.48.9.46])
 by mail.uni-halle.de
 (Sun Java(tm) System Messaging Server 6.3-16.01 (built Sep 30 2011; 32bit))
 with ESMTP id <0MAT00KZ6BLMLS50@mail.uni-halle.de> for
 alsa-devel@alsa-project.org; Sun, 23 Sep 2012 19:08:10 +0200 (CEST)
Received: from anubis.informatik.uni-halle.de
 (anubis.informatik.uni-halle.de [141.48.165.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)	by hermes.informatik.uni-halle.de (Postfix)
 with ESMTPS id 110404E3276E	for <alsa-devel@alsa-project.org>; Sun,
 23 Sep 2012 19:08:10 +0200 (CEST)
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


I think I found a bug. The following small program simply parses an 
address:

$ cat ctest/parse-address.c
#include <alsa/asoundlib.h>

int main () {
   snd_seq_t *seq;

   snd_seq_open(&seq, "default", SND_SEQ_OPEN_DUPLEX, 0);

   snd_seq_addr_t addr = {128,0};
   const char *dest_name = "TiMidity";
   snd_seq_parse_address(seq, &addr, dest_name);
   printf("found client %s: %d:%d\n", dest_name, addr.client, addr.port);

   snd_seq_close(seq);
   return 0;
}

$ gcc -Wall -o ctest/parse-address ctest/parse-address.c `pkg-config --libs alsa`

$ valgrind ctest/parse-address
==27797== Memcheck, a memory error detector
==27797== Copyright (C) 2002-2011, and GNU GPL'd, by Julian Seward et al.
==27797== Using Valgrind-3.7.0 and LibVEX; rerun with -h for copyright info
==27797== Command: ctest/parse-address
==27797==
==27797== Syscall param ioctl(generic) points to uninitialised byte(s)
==27797==    at 0x5209D27: ioctl (syscall-template.S:82)
==27797==    by 0x4EC9168: snd_seq_hw_query_next_client (seq_hw.c:367)
==27797==    by 0x4ECF3E2: snd_seq_parse_address (seqmid.c:416)
==27797==    by 0x40069D: main (in /home/thielema/programming/haskell/alsa-seq/ctest/parse-address)
==27797==  Address 0x7fefffd24 is on thread 1's stack
==27797==
found client TiMidity: 129:0
==27797==
==27797== HEAP SUMMARY:
==27797==     in use at exit: 75,317 bytes in 1,409 blocks
==27797==   total heap usage: 2,054 allocs, 645 frees, 278,456 bytes allocated
==27797==
==27797== LEAK SUMMARY:
==27797==    definitely lost: 0 bytes in 0 blocks
==27797==    indirectly lost: 0 bytes in 0 blocks
==27797==      possibly lost: 42,852 bytes in 1,310 blocks
==27797==    still reachable: 32,465 bytes in 99 blocks
==27797==         suppressed: 0 bytes in 0 blocks
==27797== Rerun with --leak-check=full to see details of leaked memory
==27797==
==27797== For counts of detected and suppressed errors, rerun with: -v
==27797== Use --track-origins=yes to see where uninitialised values come from
==27797== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 2 from 2)

$ pkg-config --modversion alsa
1.0.25
