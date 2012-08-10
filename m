From: "Fujikawa, Kazutoshi" <fujikawa.k@jp.fujitsu.com>
Subject: Re: Question about Conversion to S24_LE from S24_3LE
Date: Fri, 10 Aug 2012 08:44:12 +0000
Message-ID: <1C2A10B55A8EFD41B703692DB3F435E40C23248A@G01JPEXMBYT21>
References: <1C2A10B55A8EFD41B703692DB3F435E40C2321BD@G01JPEXMBYT21>
 <s5hhasb9sv5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 by alsa0.perex.cz (Postfix) with ESMTP id CEA59266491
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 10:14:30 +0200 (CEST)
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 1844F3EE0AE
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 17:44:14 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 0015C45DE4F
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 17:44:13 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id D7C7945DE50
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 17:44:13 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id AD9A31DB8037
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 17:44:13 +0900 (JST)
Received: from g01jpexchyt26.g01.fujitsu.local
 (g01jpexchyt26.g01.fujitsu.local [10.128.193.109])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 4751D1DB8040
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 17:44:13 +0900 (JST)
In-Reply-To: <s5hhasb9sv5.wl%tiwai@suse.de>
Content-Language: ja-JP
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello, Takashi.
Thank you for your replay.

> > 0x00123456 (MSB 0(or 0xFF) padding)
> 
> This is the correct S24_LE representation.

I record a sound file by arecord command on Ubuntu.
(% arecord -f S24_LE -r 48000 -c 2 ubuntu_rec_S24_LE_48000.wav )

Then this file was created, and it was LSB 0 padding.
So I think that S24_LE format is LSB 0 padding.

% od -t x4 ubuntu_rec_S24_LE_48000.wav 
0000000 46464952 003a9824 45564157 20746d66
0000010 00000010 00020001 0000bb80 0005dc00
0000020 00180008 61746164 003a9800 ffffbf00
0000030 ffffc300 ffffc600 ffffca00 ffffd300
0000040 ffffd600 ffffdc00 ffffe000 ffffe000
0000050 ffffe400 ffffea00 ffffeb00 fffff800
0000060 fffffa00 00000400 00000500 00001000
0000070 00000f00 00001600 00001700 00001500

Do you know why this file is LSB 0 padding?

Regards
