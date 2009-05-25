From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3 take2] ASoC: TWL4030: Handsfree pop
	removal and mute
Date: Mon, 25 May 2009 11:55:02 +0100
Message-ID: <20090525105501.GA7344@rakim.wolfsonmicro.main>
References: <1243239133-18996-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F081510385A
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 12:55:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1243239133-18996-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2009 at 11:12:10AM +0300, Peter Ujfalusi wrote:

> The following series fixes the HandsfreeL/R pop removal sequence:
> The pop removal is moved from the MUX_E to PGA_E DAPM control and also
> the sequence is modified to match with the sequence described in the TRM.
> Note, that the power-down sequence is not described in the TRM, it has been
> implemented in a way that it should make sense.

Applied all, thanks.
