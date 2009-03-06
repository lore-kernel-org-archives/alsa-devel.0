From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/5] ASoC: ssm2602 codec: fix bug -
	kernel	will crash when record and play in bf527-ezkit
Date: Fri, 6 Mar 2009 12:35:20 +0000
Message-ID: <20090306123515.GG6493@sirena.org.uk>
References: <1236326010-683-1-git-send-email-cooloney@kernel.org>
	<1236326010-683-3-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4242C2444F
	for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2009 13:35:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236326010-683-3-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>
Cc: Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 06, 2009 at 03:53:27PM +0800, Bryan Wu wrote:

> set constraint only if the value is not 0, change the configuring way for sport

This changelog doesn't appear to apply to this patch - it looks like
was copied from the previous one?  This patch appears to suffer from a
similar issue where only the first format set by an application can ever
be used, though since this changes the constraints that are set by the
driver there's no possibility that applications will end up trying to
use a sample format that the hardware is not configured for.

Do we really need such a heavy handed fix here - what is the issue
that's being fixed?
