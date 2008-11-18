From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] [ALSA] ASoc: TLV320AIC23B Cleanup
Date: Tue, 18 Nov 2008 11:09:47 +0000
Message-ID: <20081118110946.GB23217@sirena.org.uk>
References: <1226968244-13796-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E574224515
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 12:09:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1226968244-13796-1-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 17, 2008 at 05:30:44PM -0700, Troy Kisky wrote:
> Use #ifdef DEBUG to print actual sample rates.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

Excellent timing - I did a patch doing pretty much the same thing and
also fixing some build warnings last night.  Could you please check
against the for-tiwai branch of:

	git://opensource.wolfsonmicro.con/linux-2.6-asoc

and see if I've missed anything?
