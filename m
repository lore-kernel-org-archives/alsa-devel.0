From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2] ALSA: add LaCie Firewire
 Speakers/Griffin FireWave surround driver
Date: Tue, 08 Feb 2011 09:05:36 +0100
Message-ID: <4D50F950.5090104@ladisch.de>
References: <4D46933D.5050609@ladisch.de>	<4D4FB7C8.7090501@ladisch.de>	<4D4FB7F6.8000801@ladisch.de>	<20110207154025.13fdeba3@stein>
	<20110207225604.3fe43920@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id F039A2436A
	for <alsa-devel@alsa-project.org>; Tue,  8 Feb 2011 09:04:35 +0100 (CET)
In-Reply-To: <20110207225604.3fe43920@stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, Jay Fenlason <fenlason@redhat.com>
List-Id: alsa-devel@alsa-project.org

Stefan Richter wrote:
> BUG: unable to handle kernel paging request at [...]
> IP: [...] iso_packets_buffer_destroy+0x8/0x1d [snd_firewire_lib]
> [...]
> Call Trace:
>  [...] amdtp_out_stream_stop+0x3b/0x46 [snd_firewire_lib]
>  [...]

f8cc3400:   55                      push   %ebp
f8cc3401:   89 e5                   mov    %esp,%ebp
f8cc3403:   53                      push   %ebx
f8cc3404:   89 c3                   mov    %eax,%ebx
f8cc3406:   8b 02                   mov    (%edx),%eax
f8cc3408:  <8b>50 fc                mov    -0x4(%eax),%edx
f8cc340b:   89 d8                   mov    %ebx,%eax
f8cc340d:   e8 9a fe 02 00          call   0xf8cf32ac
f8cc3412:   8b 43 0c                mov    0xc(%ebx),%eax
f8cc3415:   e8 1f 62 3c c8          call   0xc1089639
f8cc341a:   5b                      pop    %ebx
f8cc341b:   c9                      leave
f8cc341c:   c3                      ret

The crash happens when iso_packets_buffer_destroy() tries to read
fw_parent_device(unit)->card.

b points to address 0xf3120c58, unit to 0xf1164df0.
fw_parent_device(unit) results in 0xf12e8bf4, which looks more or less
like a kmalloc()ed pointer, but is not correctly aligned if the standard
buddy allocator is used, and turns out not to be in a valid address
range.

There must be a wrong pointer somewhere in this chain, but I have no
clue where.


Regards,
Clemens
