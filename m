From: CH <hanchiro@msu.edu>
Subject: AZT2320 needs two modprobes
Date: Thu, 14 Mar 2002 12:06:08 +1300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3C8FDB60.9000907@msu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from rata.vuw.ac.nz (rata.vuw.ac.nz [130.195.2.11])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA15462
	for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2002 00:05:36 +0100
Received: from msu.edu (hanch@durham.fca-sef.vuw.ac.nz [130.195.15.78])
	by rata.vuw.ac.nz (8.10.1/8.10.1.4) with ESMTP id g2DN5Vg32618
	for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2002 12:05:32 +1300 (NZDT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi.

I have a AZT3000 (pnp) sound card.
I successfully (after many trials and errors) installed the latest beta 
version of ALSA.

I tried modprobe after modprobing isa-pnp kernel module and configuring 
isapnp.
So the order is:
  1. modprobe isa-pnp
  2. cat /etc/isapnp > /proc/isa-pnp  (or similar)
  3. modprobe snd-card-azt2320 snd_port=0x530 (and others)
(Note. When I did not specify snd_port=0x530, it gave me a "No such 
device" error.  snd_port=0x534 also gave me the same error.)

PROBLEM:
----------
The problem is that when I first modprobe after booting, I get "no 
device" error.  But the second modprobe works well.  So now I have to 
modprobe twice whenever I want to use sound.  And I can't avoid an ugly 
sequence of error message, too.

Any hint?

Some more details:
--------------------

Distribution: Slackware
Kernel version: 2.4.18
ALSA driver version: 0.5.12a
Configure option:  ./configure --with-isa-pnp=no --with-cards=azt2320 
(or something like that)

I want to use kernel isa-pnp module (instead of ALSA's isapnp module) in 
order to migrate 2.5.5+ kernel eventually.  I suspect that ALSA's pnp 
module will work with no problem.  Actually "kernel 2.4.5 + AlSA 0.5.10b 
+ ALSA isapnp" worked perfectly.

CH


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
