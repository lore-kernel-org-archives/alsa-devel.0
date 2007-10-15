From: Jan-Simon =?iso-8859-1?q?M=F6ller?= <dl9pf@gmx.de>
Subject: fsc esprimo v5505 (snd_intel_hda) - output in
	/var/log/messages
Date: Mon, 15 Oct 2007 09:43:31 +0200
Message-ID: <200710150943.31573.dl9pf@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id E79592456C
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Oct 2007 09:43:34 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

What do these messages mean ?

Oct 15 09:26:22 legolas kernel: ALSA sound/pci/hda/hda_intel.c:1185: 
azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
Oct 15 09:26:22 legolas kernel: ALSA sound/pci/hda/hda_codec.c:623: 
hda_codec_setup_stream: NID=0x13, stream=0x5, channel=0, format=0x11
Oct 15 09:26:22 legolas kernel: ALSA sound/pci/hda/hda_codec.c:623: 
hda_codec_setup_stream: NID=0x19, stream=0x5, channel=0, format=0x11
Oct 15 09:26:22 legolas kernel: ALSA sound/pci/hda/hda_codec.c:623: 
hda_codec_setup_stream: NID=0x19, stream=0x0, channel=0, format=0x0
Oct 15 09:26:22 legolas kernel: ALSA sound/pci/hda/hda_codec.c:623: 
hda_codec_setup_stream: NID=0x13, stream=0x0, channel=0, format=0x0
Oct 15 09:26:22 legolas kernel: ALSA sound/pci/hda/hda_intel.c:1185: 
azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
Oct 15 09:26:22 legolas kernel: ALSA sound/pci/hda/hda_codec.c:623: 
hda_codec_setup_stream: NID=0x13, stream=0x5, channel=0, format=0x11
Oct 15 09:26:22 legolas kernel: ALSA sound/pci/hda/hda_codec.c:623: 
hda_codec_setup_stream: NID=0x19, stream=0x5, channel=0, format=0x11
Oct 15 09:26:22 legolas kernel: ALSA sound/pci/hda/hda_codec.c:623: 
hda_codec_setup_stream: NID=0x19, stream=0x0, channel=0, format=0x0
Oct 15 09:26:22 legolas kernel: ALSA sound/pci/hda/hda_codec.c:623: 
hda_codec_setup_stream: NID=0x13, stream=0x0, channel=0, format=0x0

Thanks !

Jan
