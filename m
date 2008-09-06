From: William Estrada <MrUmunhum@popdial.com>
Subject: Clearification needed about structure _snd_pcm
Date: Sat, 06 Sep 2008 13:05:34 -0700
Message-ID: <48C2E28E.1060208@popdial.com>
Reply-To: MrUmunhum@popdial.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from MAIL02.inside.adbasesystems.com (mail.1dial.com [64.136.164.73])
	by alsa0.perex.cz (Postfix) with ESMTP id CE1022450E
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Sep 2008 22:05:33 +0200 (CEST)
Received: from [10.1.1.50] (64.124.13.3.gatespeed.com [64.124.13.3]) by
	MAIL02.inside.adbasesystems.com
	(Vircom SMTPRS 4.5.654.13) with ESMTP id
	<B0594620984@MAIL02.inside.adbasesystems.com> for
	<alsa-devel@alsa-project.org>; Sat, 6 Sep 2008 16:05:31 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi group,

  I have found the documentation about ALSA very confusing. Where can I 
find the definitions
about the fields in the structure_snd_pcm? Specifically Buffer, Rate, 
Period, Buffer Size,
Period size, etc. Basically all of these:
> Device: 8c297b8
> PCM Device name = 'default'         PCM state         = RUNNING
> access type     = MMAP_NONINTERLEAV format            = 'U8' (Unsigned 
> 8 bit)
> subformat       = 'STD' (Standard)  channels          = 1
> rate            = 8000 bps          period time       = 10000 us
> period size     = 80 frame          buffer time       = 0 us
> buffer size     = 65536 frames      periods/buffer    = 0 frames
> exact rate      = 8000/1 bps        significant bits  = 8000
> is batch        = 0                 is block transfer = 1
> is double       = 0                 is half duplex    = 0
> is joint duplex = 0                 can overrange     = 0
> can mmap        = 1                 can pause         = 0
> can resume      = 1                 can sync start    = 1
  My program is not honoring the 'packet size'.

-- 
William Estrada
MrUmunhum@popdial.com
Mt-Umunhum-Wireless.net ( http://Mt-Umunhum-Wireless.net )
Ymessenger: MrUmunhum
