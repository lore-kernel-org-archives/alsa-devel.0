From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: latencytest 0.5.3 and recent kernels?
Date: 31 May 2004 20:24:26 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1086060265.3054.4.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm trying to build Takashi's version of latencytest (0.5.3) and
apparently something has changed in the kernel (or I have something that
I need to turn on in the config options?). This is what I get:

# make -f Makefile.module
make -C /lib/modules/`uname -r`/build SUBDIRS=`pwd` modules
make[1]: Entering directory
`/lib/modules/2.6.6-1.391.2.ll.rhfc2.ccrma/build'
  CC [M]  /home/nando/software/latencytest/kernel/latencytest.o
  LD [M]  /home/nando/software/latencytest/kernel/latency-test.o
  Building modules, stage 2.
  MODPOST
*** Warning: "kallsyms_lookup"
[/home/nando/software/latencytest/kernel/latency-test.ko] undefined!
  CC      /home/nando/software/latencytest/kernel/latency-test.mod.o
  LD [M]  /home/nando/software/latencytest/kernel/latency-test.ko
make[1]: Leaving directory
`/lib/modules/2.6.6-1.391.2.ll.rhfc2.ccrma/build'

If I look for that symbol or something similar this is what I get:

# grep _lookup /boot/System.map-2.6.6-1.391.2.ll.rhfc2.ccrma|grep ksym
022b6ee0 r __ksymtab_d_lookup
022b9388 r __ksymtab_flow_cache_lookup
022b6d00 r __ksymtab_lookup_create
022b6d08 r __ksymtab_lookup_hash
022b7050 r __ksymtab_lookup_mnt
022b6d10 r __ksymtab_lookup_one_len
022b95b0 r __ksymtab_neigh_lookup
022b6d48 r __ksymtab_path_lookup
022b9600 r __ksymtab_pneigh_lookup
022b7648 r __ksymtab_radix_tree_gang_lookup
022b7650 r __ksymtab_radix_tree_gang_lookup_tag
022b7630 r __ksymtab_radix_tree_lookup
022b7140 r __ksymtab_simple_lookup
022b90e0 r __ksymtab_sockfd_lookup
022b98a0 r __ksymtab_tcf_police_lookup
022b9b78 r __ksymtab_tcp_v4_lookup_listener
022b9f70 r __ksymtab_xfrm_dst_lookup
022b9df8 r __ksymtab_xfrm_lookup
022b9e50 r __ksymtab_xfrm_state_lookup

-- Fernando




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
