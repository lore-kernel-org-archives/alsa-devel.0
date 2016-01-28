From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] amixer: add support for TLV byte control
	read
Date: Thu, 28 Jan 2016 14:56:44 +0530
Message-ID: <20160128092644.GJ11130@localhost>
References: <1453441612-29902-1-git-send-email-vinod.koul@intel.com>
 <s5hoace5e75.wl-tiwai@suse.de> <20160122074623.GC11130@localhost>
 <s5hfuxq593q.wl-tiwai@suse.de> <20160122095648.GD11130@localhost>
 <s5hegd9sxb3.wl-tiwai@suse.de> <20160127174749.GB11130@localhost>
 <s5h7fiuoo2r.wl-tiwai@suse.de> <20160128042509.GC11130@localhost>
 <s5hzivqmewz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id E4DEB260544
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2016 10:27:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hzivqmewz.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 28, 2016 at 06:49:48AM +0100, Takashi Iwai wrote:
> > Yes did, but didn't get a clue. tlv seems to be valid before free and points
> > to right location and contents
> 
> Could you show the backtrace?

676                     if ((err = snd_hctl_elem_tlv_read(elem, tlv, 4096)) < 0) {
(gdb) n
677                             error("Control %s element TLV read error: %s\n", card, snd_strerror(err));
(gdb) p err
$1 = -14

(gdb) n
amixer: Control hw:0 element TLV read error: Bad address

678                             free(tlv);
(gdb) p tlv
$2 = (unsigned int *) 0x625f10
(gdb) p tlv[0]
$3 = 4294967295
(gdb) p tlv[1]
$4 = 0
(gdb) backtrace
#0  show_control (elem=0x625310, level=level@entry=5, space=0x409b01 "  ")
at amixer.c:678
#1  0x00000000004066d9 in cset (argc=argc@entry=1, argv=0x7fffffffe530,
roflag=roflag@entry=1, keep_handle=keep_handle@entry=0) at amixer.c:1184
#2  0x0000000000404352 in main (argc=<optimized out>, argv=0x7fffffffe518)
at amixer.c:1863
(gdb) c
Continuing.

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff749e12f in _int_free (av=0x7ffff77dd760 <main_arena>,
p=<optimized out>, have_lock=0) at malloc.c:3996
3996    malloc.c: No such file or directory.
(gdb) backtrace
#0  0x00007ffff749e12f in _int_free (av=0x7ffff77dd760 <main_arena>,
p=<optimized out>, have_lock=0) at malloc.c:3996
#1  0x00000000004063be in show_control (elem=0x625310, level=level@entry=5,
space=0x409b01 "  ") at amixer.c:678
#2  0x00000000004066d9 in cset (argc=argc@entry=1, argv=0x7fffffffe530,
roflag=roflag@entry=1, keep_handle=keep_handle@entry=0) at amixer.c:1184
#3  0x0000000000404352 in main (argc=<optimized out>, argv=0x7fffffffe518)
at amixer.c:1863

-- 
~Vinod
