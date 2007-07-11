From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Errors in application building
Date: Wed, 11 Jul 2007 09:39:22 -0500
Message-ID: <61c0054e0707110739l29a9f71cmf18354eccb5b9f70@mail.gmail.com>
References: <61c0054e0707031129t28cc1421sde4d3b4ac4b6428b@mail.gmail.com>
	<61c0054e0707031151n6d90fc97v4493f41c1ab0cd1@mail.gmail.com>
	<61c0054e0707031206i1717e36dy8e69c872b4f33a@mail.gmail.com>
	<61c0054e0707031240y6d60fed3yea2317b8ad888110@mail.gmail.com>
	<75b66ecd0707031247h842da9j97bce3f85cda33b1@mail.gmail.com>
	<61c0054e0707031414r7565c10ax3edab20bd78d4d4c@mail.gmail.com>
	<61c0054e0707051142h46cd5beer29d91e8b6fd4560c@mail.gmail.com>
	<61c0054e0707101219i5e414590r598b45767e7b462d@mail.gmail.com>
	<20070710155712.18ee1c94.AlsaUser@PragmaSoft.com>
	<61c0054e0707101418h461afc13sdc9ec6e9d37a8d07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by alsa0.perex.cz (Postfix) with ESMTP id BB99F10390F
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 16:39:23 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so125588ugf
	for <alsa-devel@alsa-project.org>; Wed, 11 Jul 2007 07:39:23 -0700 (PDT)
In-Reply-To: <61c0054e0707101418h461afc13sdc9ec6e9d37a8d07@mail.gmail.com>
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
To: "J. Scott Merritt" <AlsaUser@pragmasoft.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Okay, I have the libthread_db issue somewhat resolved. The error in dlopen
still pops up, but it is working. I trimmed my code down to see if I could
determine the problem and I think I know where it is at, but not why or how
to resolve it.

My code looks like this:

/*************************************************************************/
#include <stdio.h>
#include <alsa/asoundlib.h>

/*************************************
 * Variable and Function Declarations
 *************************************/
int             audio_type;                     //0 = sleep; 1 = capture; 2
= playback
int             nchannels = 1;
int             buffer_size = 512;
unsigned int    sample_rate = 8000;
int             bits = 8;
char           *snd_device_in  = "hw:0,0";
char           *snd_device_out = "hw:0,0";

/*************************************
 * Main Program Section
 *************************************/
int main(void)
{
  //Testing routine
  printf("Press enter to begin recording\n");
  getchar();
  //grh_capture();
  printf("Audio Captured. Press enter to playback\n");
  getchar();

  return 0;
}
/*************************************************************************/

When I attempt to run I get a segmentation fault. With GDB, I am getting:

/*************************************************************************/
/usr/sbin $ gdb grh_audio0


dlopen failed on 'libthread_db.so.1' - File not found
GDB will not be able to debug pthreads.

GNU gdb 6.4
Copyright 2005 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are

welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "arm-linux-uclibc"...
(gdb) start
Breakpoint 1 at 0x8604: file grh_audio0.c, line 27.
Starting program: /usr/sbin/grh_audio0

Program received signal SIGSEGV, Segmentation fault.
0x40124ab8 in _pthread_cleanup_push_defer () from /lib/libc.so.0
(gdb) continue
Continuing.

Program terminated with signal SIGSEGV, Segmentation fault.
The program no longer exists.
(gdb)
/*************************************************************************/

Do the alsa libraries link to pthread? If so, I should probably be compiling
with -lpthread. Does anyone else see something I am missing that could be
causing the segfault?

Thanks.

Paul

***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
