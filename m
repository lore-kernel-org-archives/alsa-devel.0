From: Chris Pemberton <cjpembo@gmail.com>
Subject: hda-jack-retask on CentOS 6.5
Date: Mon, 21 Apr 2014 13:54:22 -0500
Message-ID: <5355695E.8060500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f177.google.com (mail-ob0-f177.google.com
 [209.85.214.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F96826088F
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 20:54:25 +0200 (CEST)
Received: by mail-ob0-f177.google.com with SMTP id wp18so4499654obc.22
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 11:54:25 -0700 (PDT)
Received: from [192.168.1.104] (ks-67-239-110-25.dhcp.embarqhsd.net.
 [67.239.110.25])
 by mx.google.com with ESMTPSA id zc8sm30898311obc.1.2014.04.21.11.54.23
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 21 Apr 2014 11:54:24 -0700 (PDT)
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

I could not find an rpm containing "hda-jack-retask" for CentOS 6.5, nor 
could I compile it from source as it requires newer libraries than 
CentOS provides.  I therefore booted into Ubuntu 14.04, ran 
hdajackretask, and saved the pin reassignments that fix my particular 
laptop.

 From Ubuntu 14.14 /lib/firmware/hda-jack-retask.fw

[codec]
0x111d76e0 0x103c190d 0

[pincfg]
0x0a 0x03a11020
0x0b 0x0321101f
0x0c 0x40f000f0
0x0d 0x90170152
0x0e 0x40f000f0
0x0f 0x40f000f0
0x10 0x90170151
0x11 0xd5a30130
0x1f 0x40f000f0
0x20 0x40f000f0

I created the following /etc/modprobe.d/hda-jack-retask.conf in CentOS 6.5:

options snd-hda-intel 
patch=hda-jack-retask.fw,hda-jack-retask.fw,hda-jack-retask.fw,hda-jack-retask.fw

Now when CentOS tries to load the snd-hda-intel module, I get the 
following error:

snd_hda_intel: Unknown parameter `patch'

Is there another method I can use to set the pins?  This is the only way 
I've managed to get "Beats Audio" working on my HP Envy k025dx.

Thanks,

Chris
