From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: firewire mixer interface -- was Re: [PATCH 11/11]
 ALSA: digi00x: apply double-oh-three algorism to multiplex PCM samples
Date: Sat, 21 Mar 2015 00:55:06 +1100
Message-ID: <550C26BA.3060703@gmail.com>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
 <1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>
 <5506E7EE.6060300@gareus.org> <55070409.8090107@sakamocchi.jp>
 <55070F3B.7000509@gareus.org> <55075D65.20406@sakamocchi.jp>
 <55082E06.6010008@gareus.org> <55083103.5030704@gmail.com>
 <5508CFA5.7060903@sakamocchi.jp> <550AD65F.10803@gareus.org>
 <550B51BC.80506@sakamocchi.jp> <550C0CFC.4060404@gareus.org>
 <550C1FC6.4050700@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
 [209.85.192.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C98026049B
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 14:55:15 +0100 (CET)
Received: by pdnc3 with SMTP id c3so109706187pdn.0
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 06:55:14 -0700 (PDT)
In-Reply-To: <550C1FC6.4050700@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Robin Gareus <robin@gareus.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On 21/03/15 00:25, Takashi Sakamoto wrote:
> Any userspace applications can destroy packet streaming which kernel
> driver starts, by transaction to streaming-related register.
> 
> In current implementation of ALSA firewire stack and Linux FireWire
> subsystem, we cannot avoid this.

Does that mean the mixer control will need root permissions to execute
in userspace because the /dev/fwX node is usually owned by root?

Damien
