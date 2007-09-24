From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: OSS sequencer mode and SNDCTL_SEQ_CTRLRATE
Date: Mon, 24 Sep 2007 08:34:11 +0200
Message-ID: <1190615651.22796.1212214463@webmail.messagingengine.com>
References: <5f52f6d70709220428s1645574bice44b0a5bf63d202@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 5080024881
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Sep 2007 08:34:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5f52f6d70709220428s1645574bice44b0a5bf63d202@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Claudio Matsuoka <cmatsuoka@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Claudio Matsuoka wrote:
> Using the OSS sequencer mode of ALSA, I noticed that a request for
> SNDCTL_SEQ_CTRLRATE always returns 100 regardless of the kernel HZ
> value. I therefore assume that the OSS sequencer mode always works at
> this rate, unlike real OSS which varies with the kernel HZ, is that
> correct?

I always works at this rate, unless you have changed it with
SNDCTL_TMR_TEMPO or SNDCTL_TMR_TIMEBASE.


HTH
Clemens
