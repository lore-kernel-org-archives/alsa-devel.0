From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RESEND] [PATCH] pxa2xx-ac97: fix displaying
	GSR	after reset timeout
Date: Wed, 25 Mar 2009 10:34:07 +0000
Message-ID: <20090325103406.GA20936@sirena.org.uk>
References: <gq8unj$6og$1@ger.gmane.org>
	<1237911929-29895-1-git-send-email-l.fu@pengutronix.de>
	<20090324221841.GC15455@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 10A52103842
	for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2009 11:34:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090324221841.GC15455@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: dbaryshkov@gmail.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk, Luotao Fu <l.fu@pengutronix.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 24, 2009 at 10:18:41PM +0000, Russell King - ARM Linux wrote:

> It would make more sense to put "GSR | gsr_bits" into a temporary variable
> for testing, and then printing so that the value printed is the exact
> value which was tested, not somehting that may have changed.

Indeed - Luotao, please make this change.

> Also, you've resent your patch but omitted the ALSA mailing list.

Looks like it's there on the copies that reached here.
