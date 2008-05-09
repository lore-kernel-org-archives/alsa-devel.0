From: Pete Clements <clem@clem.clem-digital.net>
Subject: Re: 2.6.26-rc1 regression: ISA DMA broken (bisected)
Date: Fri, 9 May 2008 08:29:22 -0400 (EDT)
Message-ID: <200805091229.m49CTMJW001947@clem.clem-digital.net>
References: <48243D86.7020504@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from clem.clem-digital.net (clem.clem-digital.net [68.16.168.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 472D524457
	for <alsa-devel@alsa-project.org>;
	Fri,  9 May 2008 14:29:27 +0200 (CEST)
In-Reply-To: <48243D86.7020504@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, Glauber Costa <gcosta@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Pete Clements <clem@clem.clem-digital.net>
List-Id: alsa-devel@alsa-project.org

Quoting Rene Herman
  > On 09-05-08 08:06, Takashi Iwai wrote:
  > 
  > > Thanks for catching it.  Yeah, the patch looks buggy.  We had an
  > > implicit assumption that dev = NULL for ISA devices that require 24bit
  > > DMA.
  > > 
  > > How about the patch below?  It's against the latest Linus git tree.
  > 
  > Yes, works well. Thank you.
  > 
  > Rene.
  > 
Confirmed here also with git7. Thanks

-- 
Pete Clements 
