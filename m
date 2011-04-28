From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/7] ASoC: DAPM: Pass snd_dapm_soc_update
	as parameter
Date: Thu, 28 Apr 2011 22:39:08 +0200
Message-ID: <4DB9D06C.5090006@metafoo.de>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
	<1304009173-5786-2-git-send-email-lars@metafoo.de>
	<20110428194054.GB16837@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 7630124380
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 22:39:11 +0200 (CEST)
In-Reply-To: <20110428194054.GB16837@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 04/28/2011 09:40 PM, Mark Brown wrote:
> On Thu, Apr 28, 2011 at 06:46:08PM +0200, Lars-Peter Clausen wrote:
>> Pass the snd_dapm_soc_update struct as parameter to dapm_widget_update instead
>> of passing it indirectly as a field of the snd_soc_dapm_context struct.
>> This should make it more obvious were the struct is coming from and make the
>> code easier to comprehend.
> 
> If we're going to do something like this it would be better to make the
> update a more complex object so we weren't passing the stream update
> separately.  The update should be "what we're doing right now" which
> includes the stream operation. [...]

Hm... the current update struct only contains information on register updates,
since we don't not always want to update a register when we sent a stream event
and vice versa it does make sense to keep them separate.
If we end up adding more context information later we might want to reconsider,
but currently keeping them separate is fine in my opinion.

> 
> TBH I'm not sure how much of a help I find this, it's nice to not have
> to pass the operation we're doing about all the time especially if we
> end up using more context information in the middle of the operation
> (which I suspect we may end up doing).  You still have to work back
> through the call chain to find where the data came from.

Well, but you know that it is a parameter to the function call. With the
current scheme you don't know this immediately. Right now dapm->update is some
random global variable and it is not quite clear that it is only valid for the
time dapm_power_widgets is called.

- Lars
