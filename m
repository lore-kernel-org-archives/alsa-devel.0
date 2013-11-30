From: Adam Williamson <awilliam@redhat.com>
Subject: Unsupported Valley View 'LPE' adapter?
Date: Sat, 30 Nov 2013 11:33:59 -0800
Message-ID: <1385840039.2566.12.camel@adam.happyassassin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id AB80F261A7E
 for <alsa-devel@alsa-project.org>; Sat, 30 Nov 2013 20:34:04 +0100 (CET)
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
 (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rAUJY2LH017561
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <alsa-devel@alsa-project.org>; Sat, 30 Nov 2013 14:34:02 -0500
Received: from mail.happyassassin.net (ovpn-113-24.phx2.redhat.com
 [10.3.113.24])
 by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id
 rAUJY1AU007204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <alsa-devel@alsa-project.org>; Sat, 30 Nov 2013 14:34:02 -0500
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

Hi, folks. I recently bought a Dell Venue 8 Pro -
a Bay Trail / Valley View-based Intel tablet - to try and get Fedora
running on it. Among the many things I'm currently fighting :) , the
sound doesn't work. snd-hda-intel is not loaded at all, and there are no
audio devices present at any level.

In Windows' Device Manager I see an 'Intel SST Audio Device' with PCI ID
0x86:0f28 . Indeed, the PCI ID database has this listed as "ValleyView
LPE Audio Controller" - http://pci-ids.ucw.cz/read/PC/8086/0f28 . But
hda-intel does not have 0f28 as a supported device. The commit for 'Bay
Trail' audio support added the ID 0f04:

https://lkml.org/lkml/2013/5/16/38

So...what is this 0f28? Is support for it going to be added? Is there
any info I can provide to help? (I can boot Linux on the tablet and get
info out of it _just barely_, but it's pretty painful - there's no wifi
and an install to 'disk' (really a usb stick) doesn't work too well, so
I'm stuck working in a live image with no network).
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | XMPP: adamw AT happyassassin . net
http://www.happyassassin.net
