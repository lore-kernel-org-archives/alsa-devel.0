From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/7] ASoC: Fix cards getting stuck in a
	powered state.
Date: Fri, 29 Apr 2011 01:14:00 +0200
Message-ID: <4DB9F4B8.20602@metafoo.de>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
	<20110428191533.GA16837@opensource.wolfsonmicro.com>
	<4DB9C440.7090201@metafoo.de>
	<20110428195221.GD16837@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 6335B1039CA
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 01:14:09 +0200 (CEST)
In-Reply-To: <20110428195221.GD16837@opensource.wolfsonmicro.com>
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

On 04/28/2011 09:52 PM, Mark Brown wrote:
> On Thu, Apr 28, 2011 at 09:47:12PM +0200, Lars-Peter Clausen wrote:
>> On 04/28/2011 09:15 PM, Mark Brown wrote:
> 
>>> For CODECs we can easily add some widgets for them based on the DAI, for
>>> cards we should just shove a random widget in there with the name of the
>>> card, it doesn't need to be wired up to anything.
> 
>> For codecs we can use SND_SOC_DAPM_AIF_{IN,OUT} widgets.
> 
> Quite, but they do also need to be connected to outputs and inputs so
> that they're part of complete paths.

Hm... right.
I know this isn't optimal, but would it be accepable to have a
SND_SOC_DAPM_STREAM(sname) widget, where the power_check function would just
consider stream's state, so we can get rid of the special casing without having
to mess with the codec drivers to much?

- Lars
