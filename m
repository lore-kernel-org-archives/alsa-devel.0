From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/3] ASoC: davinci-mcasp: Optimize
 pm_runtime usage and clean up the init code
Date: Tue, 22 Apr 2014 15:20:33 +0300
Message-ID: <53565E91.9040200@ti.com>
References: <1398164594-29169-1-git-send-email-peter.ujfalusi@ti.com>
 <1398164594-29169-4-git-send-email-peter.ujfalusi@ti.com>
 <20140422114712.GO12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 5399C2625C4
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 14:20:39 +0200 (CEST)
In-Reply-To: <20140422114712.GO12304@sirena.org.uk>
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
Cc: daniel@zonque.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

On 04/22/2014 02:47 PM, Mark Brown wrote:
> On Tue, Apr 22, 2014 at 02:03:14PM +0300, Peter Ujfalusi wrote:
>> Move the pm_runtime_enable/disable to dai driver probe/remove callbacks =
from
>> module probe/remove callbacks.
>> With this change we can remove the platform driver's remove function sin=
ce
>> it became NULL.
> =

> This does mean that if the device gets enumerated but isn't used in the
> system it won't go to runtime idle since the DAI level probe is only
> called when we're building a card.

If the given mcasp is not used as part of a card, it should not have been
probed in the first place (at least with DT boot we can control this). If t=
he
driver is probed for a mcasp instance and it is not part of any card than it
can be left disabled IMHO no need for runtime pm to take care of it.
I might missed something related to runtime pm, but this is my understandin=
g.

>That doesn't seem like it's a win.
> How about creating a devm_pm_runtime_enable() instead?

I was also considered to do this but ended up moving the
pm_runtime_enable/disable instead.

-- =

P=E9ter
