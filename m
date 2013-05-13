From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: sgtl5000: Simplify the handling
	of VDDD
Date: Mon, 13 May 2013 14:36:00 -0300
Message-ID: <51912480.90700@freescale.com>
References: <1368459567-26780-1-git-send-email-fabio.estevam@freescale.com>
 <CAKGA1bmKEnp9aLqu46c8Gn+h6-aoYu1yajOFgX-c3+5wkgysNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 287F3261741
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2013 19:35:39 +0200 (CEST)
In-Reply-To: <CAKGA1bmKEnp9aLqu46c8Gn+h6-aoYu1yajOFgX-c3+5wkgysNw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, festevam@gmail.com, Eric Nelson <eric.nelson@boundarydevices.com>, "troy.kisky" <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On 05/13/2013 01:41 PM, Matt Sealey wrote:
> Nack.
>
> While I like the concept, I don't like the following:
>
> * That the regulator-before-read-chip-id should be a separate patch (please)
I thought about doing like this initially and that would require some 
heavy cleanup.
> * That this revision check went away without anyone fully knowing WHY
> it was there in the first place
> * I am fairly certain the first run consumer-purchased Efika MX boards
> have an older SGTL5000 on them and I would like to know if the
> internal LDO actually operates on those.. and don't want to churn by
> reintroducing such a patch.
Can you test on this platform, please?

>
> As far as I see the operation after patch would be that VDDD is
> accepted in the DT, enabled, and then LDO is enabled (thus shunting
> VDDD-LDO supply to the highest of VDDA or VDDIO, or VDDA in the case
> VDDA&VDDIO >3.1V) which leaves the board VDDD enabled until the driver
> is removed.
How does this differ from current code?
>
> If you're enabling the LDO, please disable board VDDD.
Agree, but that would be another patch.

> And please
> consider that on Efika MX and Babbage, VDDD is supplied at 1.2V by a
> separate on-board regulator, so using VDDIO->LDO->1.2V is completely
> obtuse and doubles codec power consumption.
Babbage leaves VDDD unconnected.

>
> I am leaning towards the case that the revision check is redundant, in
> that since there is no design data that says the LDO was
> non-operational or has any differences between versions the only
> difference is in the particulars of the implementation on the board
> itself. It seems like it is coded as a non-intrusive hack on the
> assumption that "any board with SGTL5000 0x11 is a production
> Freescale reference platform which does not supply VDDD" rather than
> having to go and re-validate a ridiculous number of supported
> reference designs. Unless I see data otherwise..
Yes, I also do not find any data for this revision check.

>
> If that's true, what we need here is to keep VDDD if it's supplied,
> and remove VDDD from the DT where it is not, and optionally tell the
> codec to force usage of the internal LDO in the case of supplied VDDD
> (i.e. please disable VDDD), and WHICH source to use for the charge
> pump (VDDIO or VDDA) in case the automated default setting is not
> desirable..
Yes, but this would also need to be another patch.
