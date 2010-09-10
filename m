From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC 0/1] ASoC: WL1273 FM: Change error
	handling.
Date: Fri, 10 Sep 2010 10:25:05 +0100
Message-ID: <20100910092505.GA3068@rakim.wolfsonmicro.main>
References: <1284104490-11226-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 482A3103981
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 11:25:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1284104490-11226-1-git-send-email-matti.j.aaltonen@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 10, 2010 at 10:41:29AM +0300, Matti J. Aaltonen wrote:

> This patch changes the error handling in the FM radio codec so that
> it's always permissible to set the audio routing to the previous value/

If you're just sending a single patch please don't send separate
covering mails - if there's useful additional information in them it
should probably go in the changelog for the patch so it gets recorded.
