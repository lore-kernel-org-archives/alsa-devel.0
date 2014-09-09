From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCHv3 3/3] ASoC: simple-card: binding: update
 binding to support the new style.
Date: Tue, 9 Sep 2014 16:25:29 +0300
Message-ID: <540EFFC9.4050207@ti.com>
References: <1409711021-19277-1-git-send-email-Li.Xiubo@freescale.com>
 <1409711021-19277-4-git-send-email-Li.Xiubo@freescale.com>
 <20140909120948.GZ2601@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C825265176
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 15:25:35 +0200 (CEST)
In-Reply-To: <20140909120948.GZ2601@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Xiubo Li <Li.Xiubo@freescale.com>
Cc: mark.rutland@arm.com, moinejf@free.fr, alsa-devel@alsa-project.org, pawel.moll@arm.com, kuninori.morimoto.gx@renesas.com, andrew@lunn.ch, tiwai@suse.de, linux-kernel@vger.kernel.org, ijc+devicetree@hellion.org.uk, lgirdwood@gmail.com, devicetree@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On 09/09/2014 03:09 PM, Mark Brown wrote:
> On Wed, Sep 03, 2014 at 10:23:41AM +0800, Xiubo Li wrote:
>> This update patch will split the DT node into old style and new style:
>> The new style will will be easier to add muti DAI links from old single
>> DAI link DTs.
>
>> This patch will maintian compatibility with the old DTs.
>
> Is everyone happy with this new style binding?
>

If I read the diff correctly the only change in the syntax is moving the 
bitclock-inversion and frame-inversion properties to DAI nodes also for 
the new style bindings.

I am Ok with that.

The document does not indicate that the same properties could be also 
placed to DAI link level like they used to, from where they would apply 
to both DAI nodes.

I am Ok with this too, but this breaks the backwards compatibility, 
which I guess is generally considered a problem. However, I doubt anyone 
but me has yet used this part of the new syntax and I am happy to fix my 
dts files.

Best regards,
Jyri

ps. I could not find the corresponding code changes in the previous 
patch, so I assume they are coming later.
