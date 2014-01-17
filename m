From: siddharth <siddharth@greenearthnetwork.in>
Subject: ProVideo PV 918A - audi o device created but cannot
	capture sound
Date: Fri, 17 Jan 2014 08:04:16 +0000 (UTC)
Message-ID: <loom.20140117T085941-825@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id D27B9261A7B
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2014 09:40:05 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1W44yC-0001xj-P4
 for alsa-devel@alsa-project.org; Fri, 17 Jan 2014 09:40:04 +0100
Received: from 117.195.53.10 ([117.195.53.10])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2014 09:40:04 +0100
Received: from siddharth by 117.195.53.10 with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2014 09:40:04 +0100
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

Hi,

I have installed a ProVideo PV 981.

I was able to get the sound device detected by putting 

modprobe snd-bt87x load_all=1 digital_rate=48000 enable=1

but am unable to capture sound. I am using Fedora 19 on an intel i5 machine.

In dmesg i get the error:

[  235.145932] ALSA sound/pci/bt87x.c:860 unknown card 0x878-0xaa00:0x1460
[  235.145935] ALSA sound/pci/bt87x.c:863 please mail id, board name, and,
if it works, the correct digital_rate option to <alsa-devel@alsa-project.org>
[  235.146061] ALSA sound/pci/bt87x.c:931 bt87x0: Using board 0, analog,
digital (rate 48000 Hz)


Any help will be appreciated.

regards
Siddharth
