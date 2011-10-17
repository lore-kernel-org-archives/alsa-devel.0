From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: TWL4030 low-latency
Date: Mon, 17 Oct 2011 13:23:47 +0200
Message-ID: <4E9C1043.6050804@ladisch.de>
References: <B4E3E481-AEFC-4E2E-A5FA-A63908D8DE12@ccrma.Stanford.EDU>	<CAPo=G1yzBxH3FL=Y5yqmR+REVawPV7eAdO5jmrxEJ6RRkndgxg@mail.gmail.com>	<7C8103E9-A683-4FCA-9E55-9D81A3CA3439@ccrma.Stanford.EDU>
	<CAPo=G1zpT9wupMnpWBcxEu6iK9vr=EdrkKLMuHkpk7kyBCUMXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id C2F5F103892
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Oct 2011 13:23:23 +0200 (CEST)
In-Reply-To: <CAPo=G1zpT9wupMnpWBcxEu6iK9vr=EdrkKLMuHkpk7kyBCUMXw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: Edgar Berdahl <eberdahl@ccrma.stanford.edu>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ujfalusi, Peter wrote:
> BTW: PA also have 'real time' mode which basically means that it is
> using the kernel scheduling
> for audio timing.

That mode isn't called 'real time' and has nothing to do with real time.
It just uses the kernel timer instead of the sound card clock so that
it can be woken up in irregular intervals.  This mode doesn't work so
well if the sound card doesn't allow to read the current sample position
precisely (many embedded DMA controllers have this problem).


Regards,
Clemens
