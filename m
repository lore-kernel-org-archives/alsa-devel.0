From: Svante Signell <srs@kth.se>
Subject: Re: [Fwd: Re: Problems with snd_hda_intel in Linux
 kernel 2.6.38]
Date: Thu, 31 Mar 2011 08:12:04 +0200
Message-ID: <1301551924.21366.127.camel@hp.my.own.domain>
References: <1301527768.21366.121.camel@hp.my.own.domain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-1.sys.kth.se (smtp-1.sys.kth.se [130.237.32.175])
	by alsa0.perex.cz (Postfix) with ESMTP id C1B1824691
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 08:12:18 +0200 (CEST)
Received: from mailscan-1.sys.kth.se (mailscan-1.sys.kth.se [130.237.32.91])
	by smtp-1.sys.kth.se (Postfix) with ESMTP id 6A3C8156B41
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 08:12:18 +0200 (CEST)
In-Reply-To: <1301527768.21366.121.camel@hp.my.own.domain>
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

On Thu, 2011-03-31 at 01:29 +0200, Svante Signell wrote:
> I am subscribed. What's the problem? (now without attachment). How can I
> send the attachment to the developers?
> 
> > Your mail to 'Alsa-devel' with the subject
> > 
> >     Re: [alsa-devel] Problems with snd_hda_intel in Linux kernel
> > 2.6.38
> > 
> > Is being held until the list moderator can review it for approval.
> > 
> > The reason it is being held:
> > 
> >     Message body is too big: 488063 bytes with a limit of 60 KB
> > 
> > Either the message will get posted to the list, or you will receive
> > notification of the moderator's decision.  If you would like to cancel
> > this posting, please visit the following URL:
> > 
> > 
> > http://mailman.alsa-project.org/mailman/confirm/alsa-devel/9dc4fe44b477fdc33a69862964d772f7e209c1f1
> > 
> -------- Forwarded Message --------
> From: Svante Signell <srs@kth.se>
> To: Clemens Ladisch <clemens@ladisch.de>
> Cc: Takashi Iwai <tiwai@suse.de>, 619034@bugs.debian.org,
> alsa-devel@alsa-project.org, 613979@bugs.debian.org
> Subject: Re: [alsa-devel] Problems with snd_hda_intel in Linux kernel
> 2.6.38
> Date: Thu, 31 Mar 2011 00:42:46 +0200
> 
> On Wed, 2011-03-30 at 15:13 +0200, Clemens Ladisch wrote:
> > Svante Signell wrote:
> > > Code: f4 01 00 00 ef 31 f6 48 89 df e8 15 dd ff ff 85 c0
> > > 0f 88 2b 03 00 00 48 89 ef e8 ee 11 b9 e0 8b 7b 40 e8 9f 25 a7 e0 48 8b
> > > 43 38 <66> 8b 10 66 89 14 24 8b 43 14 83 e8 03 83 f8 01 77 32 31 d2 be
> > 
> >    5:   31 f6                   xor    %esi,%esi
> >    7:   48 89 df                mov    %rbx,%rdi
> >    a:   e8 15 dd ff ff          callq  0xffffffffffffdd24
> >    f:   85 c0                   test   %eax,%eax
> >   11:   0f 88 2b 03 00 00       js     0x342
> >   17:   48 89 ef                mov    %rbp,%rdi
> >   1a:   e8 ee 11 b9 e0          callq  0xffffffffe0b9120d
> >   1f:   8b 7b 40                mov    0x40(%rbx),%edi
> >   22:   e8 9f 25 a7 e0          callq  0xffffffffe0a725c6
> >   27:   48 8b 43 38             mov    0x38(%rbx),%rax
> >   2b:   66 8b 10                mov    (%rax),%dx         <-- crash here
> >   2e:   66 89 14 24             mov    %dx,(%rsp)
> >   32:   8b 43 14                mov    0x14(%rbx),%eax
> >   35:   83 e8 03                sub    $0x3,%eax
> >   38:   83 f8 01                cmp    $0x1,%eax
> >   3b:   77 32                   ja     0x6f
> >   3d:   31 d2                   xor    %edx,%edx
> > 
> > This is the azx_readw(chip, GCAP) in azx_create(); chip->remap_addr is
> > 0xffffc90011c08000 which does look like a valid pointer, but isn't.
> 
> Thank you Clemens! Maybe your input is sufficient to solve this problem.
> I have now installed the debug version of the kernel, the objdump output
> is attached (please let me know if you are missing something). Sorry, I
> don't know where to find the relevant information in this file, but that
> is all I have (still very large). (Does not include the error messages
> on stderr, maybe something is still missing.)
> 
> Thanks!

A small except from the objdump output below. The complete file is too
big (400k) for the mailing list. Let me know if more is needed.

 56c:   be 01 00 00 00          mov    $0x1,%esi
 571:   48 89 ef                mov    %rbp,%rdi
 574:   e8 00 00 00 00          callq  579 <azx_probe+0x37c>
 579:   85 c0                   test   %eax,%eax
 57b:   79 07                   jns    584 <azx_probe+0x387>
 57d:   80 a3 f4 01 00 00 ef    andb   $0xef,0x1f4(%rbx)
 584:   31 f6                   xor    %esi,%esi
 586:   48 89 df                mov    %rbx,%rdi
 589:   e8 00 00 00 00          callq  58e <azx_probe+0x391>
 58e:   85 c0                   test   %eax,%eax
 590:   0f 88 2b 03 00 00       js     8c1 <azx_probe+0x6c4>
 596:   48 89 ef                mov    %rbp,%rdi
 599:   e8 00 00 00 00          callq  59e <azx_probe+0x3a1>
 59e:   8b 7b 40                mov    0x40(%rbx),%edi
 5a1:   e8 00 00 00 00          callq  5a6 <azx_probe+0x3a9>
 5a6:   48 8b 43 38             mov    0x38(%rbx),%rax
 5aa:   66 8b 10                mov    (%rax),%dx          <- crash here
 5ad:   66 89 14 24             mov    %dx,(%rsp)
 5b1:   8b 43 14                mov    0x14(%rbx),%eax
 5b4:   83 e8 03                sub    $0x3,%eax
 5b7:   83 f8 01                cmp    $0x1,%eax
 5ba:   77 32                   ja     5ee <azx_probe+0x3f1>
 5bc:   31 d2                   xor    %edx,%edx
