From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add STA32X codec driver
Date: Thu, 16 Jun 2011 11:13:13 +0100
Message-ID: <20110616101313.GB5262@opensource.wolfsonmicro.com>
References: <1308079626-31239-1-git-send-email-zonque@gmail.com>
	<1308079626-31239-2-git-send-email-zonque@gmail.com>
	<20110615150516.GC2806@opensource.wolfsonmicro.com>
	<20110615205329.GA7445@sig21.net> <4DF9C13A.2000205@metafoo.de>
	<BANLkTikfDFrh8Bm24ZbUCk1V3ejrgTDU-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 449AA10396B
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 12:13:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTikfDFrh8Bm24ZbUCk1V3ejrgTDU-w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 16, 2011 at 11:51:20AM +0200, Daniel Mack wrote:

> # amixer cget numid=39
> numid=39,iface=MIXER,name='Limiter1 Attack Threshold (DRC Mode)'
>   ; type=INTEGER,access=rw---R--,values=1,min=0,max=16,step=0
>   : values=9
>   | dBrange-
> 0x00000000,0x00000007,0x00000001,0x00000008,0xfffff3e4,0x000000c8,0x00000008,0x0000000d,0x00000001,0x00000008,0xfffff9c0,0x00000064,0x0000000e,0x00000010,0x00000001,0x00000008,0xfffffc18,0x0000012c,

> Is there a way to get more descriptive information about possible
> values for such controls?

This looks rather like a buggy userspace - are you sure you're using a
current version?
