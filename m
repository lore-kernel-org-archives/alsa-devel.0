From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Remove unused dapm_get_snd_card()
 and dapm_get_soc_card()
Date: Tue, 23 Jul 2013 19:57:15 +0200
Message-ID: <51EEC3FB.9050701@metafoo.de>
References: <1374570745-32224-1-git-send-email-lars@metafoo.de>
 <1374583782.2475.26.camel@loki> <20130723173646.GL9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EF3C265143
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 19:57:14 +0200 (CEST)
In-Reply-To: <20130723173646.GL9858@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/23/2013 07:36 PM, Mark Brown wrote:
> On Tue, Jul 23, 2013 at 01:49:42PM +0100, Liam Girdwood wrote:
>> On Tue, 2013-07-23 at 11:12 +0200, Lars-Peter Clausen wrote:
>
>>> Add methods to retrieve snd_card and soc_card from dapm context.") but have
>>> remained unused so far. Considering that the dapm context actually has a direct
>>> pointer to the card the functions also seem to be unnecessary. E.g. the
>>> expressions 'dapm_get_soc_card(dapm)' and 'dapm->card' yield the same result.
>
>> Peter may have a user for these, but maybe not ?
>
> We can always add them back in later if they get a user.
>

If there are any out of tree users they should just use dapm->card instead. 
It's much more simpler than this 'if (dapm->codec) return dapm->codec->card; 
else if (dapm->platform) return dapm->platform->card;' and at the same time 
more robust since it also works for dapm contexts which don't belong to a codec 
or platform.

- Lars
