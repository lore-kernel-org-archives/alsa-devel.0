From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/7] ASoC: DAPM: Pass snd_dapm_soc_update
	as parameter
Date: Thu, 28 Apr 2011 20:40:55 +0100
Message-ID: <20110428194054.GB16837@opensource.wolfsonmicro.com>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
	<1304009173-5786-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 95EDE103809
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 21:40:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304009173-5786-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 28, 2011 at 06:46:08PM +0200, Lars-Peter Clausen wrote:
> Pass the snd_dapm_soc_update struct as parameter to dapm_widget_update instead
> of passing it indirectly as a field of the snd_soc_dapm_context struct.
> This should make it more obvious were the struct is coming from and make the
> code easier to comprehend.

If we're going to do something like this it would be better to make the
update a more complex object so we weren't passing the stream update
separately.  The update should be "what we're doing right now" which
includes the stream operation (even though the stream operation is only
used to keep the pre and post widgets limping along) and looking at the
code they mostly don't care about the streams at all, only tlv320dac33
is using them and I think it can live without.

TBH I'm not sure how much of a help I find this, it's nice to not have
to pass the operation we're doing about all the time especially if we
end up using more context information in the middle of the operation
(which I suspect we may end up doing).  You still have to work back
through the call chain to find where the data came from.
