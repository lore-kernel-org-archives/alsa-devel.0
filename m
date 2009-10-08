From: Adriano <adriano.src@gmail.com>
Subject: Bt87x unknown card
Date: Thu, 8 Oct 2009 15:40:18 +0200
Message-ID: <5f89296f0910080640x2a757e69sa344a3afe8e0fb69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 20D28103A9C
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 15:40:19 +0200 (CEST)
Received: by bwz25 with SMTP id 25so2327244bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 08 Oct 2009 06:40:18 -0700 (PDT)
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

Hi I've this Pinnacle PCTV card: 11bd:0012 with this multimedia audio
controller:

02:02.1 Multimedia controller [0480]: Brooktree Corporation Bt878
Audio Capture [109e:0878] (rev 11)
        Subsystem: Pinnacle Systems Inc. PCTV pro (TV + FM stereo
receiver, audio section) [11bd:0012]
        Flags: bus master, medium devsel, latency 32, IRQ 23
        Memory at f7eff000 (32-bit, prefetchable) [size=4K]
        Capabilities: <access denied>
        Kernel driver in use: Bt87x

I have no audio with alsa, when I loaded snd-bt87x, I received this
error in dmesg:

[ 1951.383480] unknown card 0x878-0x11bd:0x12
[ 1951.383484] please mail id, board name, and, if it works, the
correct digital_rate option to <alsa-devel@alsa-project.org>
[ 1951.383518] Bt87x 0000:02:02.1: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[ 1951.383741] bt87x0: Using board 0, analog, digital (rate 32000 Hz)

Can you tell me the problem and any solution?

Thanks you
Adriano Foschi
