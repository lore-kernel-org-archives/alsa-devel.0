From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ALSA: ASoC: McASP: add support for
	24	bit samples
Date: Tue, 9 Oct 2012 13:32:16 +0100
Message-ID: <20121009123216.GA11061@opensource.wolfsonmicro.com>
References: <A551BDF323A45B48ACE6A404AA16A1C412786E53@TOP-EX01.TOPIC.LOCAL>
 <5073F2CD.9010407@gmail.com>
 <20121009102331.GB15207@opensource.wolfsonmicro.com>
 <507403DB.5050003@gmail.com> <507416DC.6030207@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C2AAC261601
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 14:28:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <507416DC.6030207@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 09, 2012 at 02:21:48PM +0200, Clemens Ladisch wrote:

> > Hence Mike would be right that S24_LE has to use a 4-byte dma transfer
> > size, no?

> Yes.

That's what Mike meant but it wasn't quite what he said - he said the
CODEC would send 32 bits which isn't the case, the 32 bits thing only
applies inside the CPU.
