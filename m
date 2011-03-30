From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problems with snd_hda_intel in Linux kernel 2.6.38
Date: Wed, 30 Mar 2011 15:13:21 +0200
Message-ID: <4D932C71.10402@ladisch.de>
References: <1301394280.3906.29.camel@s1499.it.kth.se>	<s5haage43qz.wl%tiwai@suse.de>	<1301396296.32453.1.camel@s1499.it.kth.se>	<s5h7hbi41xs.wl%tiwai@suse.de>	<1301480744.21366.110.camel@hp.my.own.domain>	<s5hpqp827sv.wl%tiwai@suse.de>
	<1301486370.32453.9.camel@s1499.it.kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 6833F24350
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 15:12:07 +0200 (CEST)
In-Reply-To: <1301486370.32453.9.camel@s1499.it.kth.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: srs@kth.se
Cc: Takashi Iwai <tiwai@suse.de>, 619034@bugs.debian.org, alsa-devel@alsa-project.org, 613979@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

Svante Signell wrote:
> Code: f4 01 00 00 ef 31 f6 48 89 df e8 15 dd ff ff 85 c0
> 0f 88 2b 03 00 00 48 89 ef e8 ee 11 b9 e0 8b 7b 40 e8 9f 25 a7 e0 48 8b
> 43 38 <66> 8b 10 66 89 14 24 8b 43 14 83 e8 03 83 f8 01 77 32 31 d2 be

   5:   31 f6                   xor    %esi,%esi
   7:   48 89 df                mov    %rbx,%rdi
   a:   e8 15 dd ff ff          callq  0xffffffffffffdd24
   f:   85 c0                   test   %eax,%eax
  11:   0f 88 2b 03 00 00       js     0x342
  17:   48 89 ef                mov    %rbp,%rdi
  1a:   e8 ee 11 b9 e0          callq  0xffffffffe0b9120d
  1f:   8b 7b 40                mov    0x40(%rbx),%edi
  22:   e8 9f 25 a7 e0          callq  0xffffffffe0a725c6
  27:   48 8b 43 38             mov    0x38(%rbx),%rax
  2b:   66 8b 10                mov    (%rax),%dx         <-- crash here
  2e:   66 89 14 24             mov    %dx,(%rsp)
  32:   8b 43 14                mov    0x14(%rbx),%eax
  35:   83 e8 03                sub    $0x3,%eax
  38:   83 f8 01                cmp    $0x1,%eax
  3b:   77 32                   ja     0x6f
  3d:   31 d2                   xor    %edx,%edx

This is the azx_readw(chip, GCAP) in azx_create(); chip->remap_addr is
0xffffc90011c08000 which does look like a valid pointer, but isn't.


Regards,
Clemens
