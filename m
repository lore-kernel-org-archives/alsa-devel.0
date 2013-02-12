From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Takashi: please help (compiling alsa-driver)
Date: Tue, 12 Feb 2013 22:58:37 +0100
Message-ID: <511ABB0D.90808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f52.google.com (mail-bk0-f52.google.com
 [209.85.214.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A804264F13
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2013 22:58:39 +0100 (CET)
Received: by mail-bk0-f52.google.com with SMTP id jk13so259474bkc.11
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2013 13:58:38 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I'm talking to you directly because this

ftp://ftp.suse.com/pub/people/tiwai/snapshot/alsa-driver-unstable-snapshot.tar.gz

is the only alsa-driver source that I'm able to compile so far. I can unpack this and simply run ./configure && make && make install. It works great. (I compile against the kernel-headers from ubuntu).

I spent hours in trying to compile from several other sources.

* The plain1.0.25 release (complains about missing symbols).
* The snapshots fromhttp://www.alsa-project.org/snapshot/  (will complain about missing 'uapi' stuff)
* Btw. where did the snapshots fromhttp://ftp.kernel.org/pub/linux/kernel/people/tiwai/alsa/  go (Advertised here:http://www.alsa-project.org/main/index.php/Download)?
* Checked out alsa-driver from git. But no luck, tried many things. e.g.: Branch release, then autoconf, but not even ./configure succeeds.

Id like to submit some patches and be able to work with the current state from git. How is that supposed to work?

Btw. I often read that the alsa-kernel is needed to compile. But it is not neede with this above mentioned 'unstable-snapshot'. It will just compile against the ubuntu kernel-headers (Lubuntu 12.10).

How do you generate these snapshots?

Thanks and sorry if that's stupid questions..
Jonas
