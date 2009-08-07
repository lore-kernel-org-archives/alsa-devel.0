From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: DaVinci: i2s: don't bounce
	through rtd to	get dai
Date: Fri, 7 Aug 2009 11:41:44 +0100
Message-ID: <20090807104144.GF639@sirena.org.uk>
References: <1249602935-1267-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 13C1F10390B
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 12:41:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1249602935-1267-1-git-send-email-troy.kisky@boundarydevices.com>
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
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 06, 2009 at 04:55:31PM -0700, Troy Kisky wrote:
> dai is a parameter to the functions, so use it instead of
> looking it up.

> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

I've applied this and patch 1, thanks.  The other patches look OK at
first glance but I've not reviewed them properly yet.
