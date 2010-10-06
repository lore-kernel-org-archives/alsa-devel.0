From: Jaime Torres <jaimeurieltorres@hotmail.com>
Subject: X-Fi Xtreme Audio PCIe
Date: Tue, 5 Oct 2010 22:15:46 -0500
Message-ID: <SNT136-w16AB2F31C1D85EDBEED317CF6E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from snt0-omc3-s11.snt0.hotmail.com (snt0-omc3-s11.snt0.hotmail.com
	[65.55.90.150]) by alsa0.perex.cz (Postfix) with ESMTP id 4A8722414F
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 05:15:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hello Alsa developers:

We have 500 linux servers with X-Fi Xtreme Audio PCIe. The audio card is properly detected by kernel. The card is unmuted, the sound applications works fine. But the card doesn't sound.  

Googling I discover the same case on several forums, no solution.   

First Question:   The driver is finished? Is it on development? Is it abandoned?
Second Question: Can I join to driver development. I need to make work this soundcard.

----------------------------------------------------------------------------------
Distribution: Fedora 13
kernel 2.6.34.7-56.fc13.i686.PAE 
alsa version: alsa-lib-1.0.23
01:00.0 PCI bridge: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG PCI to PCIe Bridge


[root@localhost ~]# lsmod 
Module                  Size  Used by
snd_ctxfi              69769  0 
fuse                   47907  2 
sunrpc                163601  1 
ip6t_REJECT             3310  2 
nf_conntrack_ipv6      14223  2 
ip6table_filter         1199  1 
ip6_tables              9774  1 ip6table_filter
ipv6                  221726  88 ip6t_REJECT,nf_conntrack_ipv6
uinput                  5287  0 
snd_hda_codec_ca0110     4769  1 
snd_hda_intel          19995  0 
iTCO_wdt                8940  0 
iTCO_vendor_support     2027  1 iTCO_wdt
snd_hda_codec          70968  2 snd_hda_codec_ca0110,snd_hda_intel
snd_hwdep               4860  1 snd_hda_codec
snd_seq                42775  0 
snd_seq_device          5035  1 snd_seq
dcdbas                  6552  0 
snd_pcm                62185  3 snd_ctxfi,snd_hda_intel,snd_hda_codec
bnx2                   57069  0 
snd_timer              15391  2 snd_seq,snd_pcm
power_meter             7602  0 
snd                    46591  9 snd_ctxfi,snd_hda_codec_ca0110,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_seq,snd_seq_device,snd_pcm,snd_timer
soundcore               4934  1 snd
snd_page_alloc          6097  3 snd_ctxfi,snd_hda_intel,snd_pcm
microcode              10249  0 






 		 	   		  
