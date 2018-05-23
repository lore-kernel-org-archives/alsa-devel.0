From: Daniel Danzberger <daniel@dd-wrt.com>
Subject: out of sync capture samples with MMAP on MIPS
Date: Wed, 23 May 2018 20:36:37 +0200
Message-ID: <e89758e0-b3db-c17c-71f5-e7acfbe76845@dd-wrt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail.newmedia-net.de (webmail.newmedia-net.de [185.84.6.166])
 by alsa0.perex.cz (Postfix) with ESMTP id 08874266C1C
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 20:36:40 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am using alsa's mmap() interface to capture audio samples on some AR71xx MIPS
devices via USB and sometimes the sampled audio sounds very disordered.

After debugging deeper into this issue I found that samples are fine in the
kernel's vmalloc'ed buffer (runtime->dma_area). But once they get accessed from
userspace via mmaped memory, the samples differ.

I wrote a module + userspace program to demonstrate the issue:
git@github.com:dddaniel/mmaptest.git

The userspace tool reads the data a couple of times with a small delay.
As you see below, after a couple of reads the data gets closer to look like in
the kernel buffer:
---
root@OpenWrt:/# mmaptest-user
mmap addr: 0x77a04000
[  760.464968] mmap page 7573000 at va 87573000
check memory ...FAIL (at byte 0)
check memory ...FAIL (at byte 96)
check memory ...FAIL (at byte 96)
check memory ...FAIL (at byte 96)
check memory ...FAIL (at byte 128)
---

Does someone here experienced similar issues ?
