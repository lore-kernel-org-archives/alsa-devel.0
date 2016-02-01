From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH] ASoC: fsl_ssi: remove explicit register
	defaults
Date: Mon, 01 Feb 2016 17:58:06 +0100
Message-ID: <56AF8E9E.5000100@maciej.szmigiero.name>
References: <569D3800.2040801@maciej.szmigiero.name>	<CAOMZO5DwQza+jDdkA80v4wkrB56y53tOjkP2-36YNq2WBLodaA@mail.gmail.com>	<56AF4A9F.4060401@maciej.szmigiero.name>
 <CAOMZO5DK86JCs_KivZ5MMFKsiP6aVpopG-zgXPE-+_GWjQNuMw@mail.gmail.com>
 <56AF4ED0.7030801@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 097F42604EF
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2016 17:58:17 +0100 (CET)
In-Reply-To: <56AF4ED0.7030801@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On 01.02.2016 13:25, Maciej S. Szmigiero wrote:
> On 01.02.2016 13:13, Fabio Estevam wrote:
>> Hi Maciej,
>>
>> On Mon, Feb 1, 2016 at 10:07 AM, Maciej S. Szmigiero
>> <mail@maciej.szmigiero.name> wrote:
>>> Is regmap patch from
>>> http://www.spinics.net/lists/kernel/msg2161934.html
>>> applied to the tested tree?
>>
>> Yes, linux-next 20160201 contains this patch.
> 
> Hmm, I will try to build this tree on UDOO board
> today and see what happens.

Looks like the problem occurs because commit
922a9f936e40 ("regmap: mmio: Convert to regmap_bus and fix accessor usage")
has removed ->read callback from MMIO regmap
implementation but it is used (via regmap_raw_read()) by
regcache code to initialize cache if reg default values
weren't provided explicitly.

If I revert this commit the SSI probes successfully again.

Looks like a possible solution would be to change
regmap_raw_read() to do read using _regmap_read in
case the cache is bypassed and there is no ->read
callback defined for regmap implementation.

Maciej
