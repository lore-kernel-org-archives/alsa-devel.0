From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/2] ASoC: sgtl5000: clean up
	sgtl5000_enable_regulators()
Date: Tue, 17 Dec 2013 21:58:09 +0800
Message-ID: <20131217135804.GT6691@S2101-09.ap.freescale.net>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
 <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CA4D265139
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 14:57:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Xiubo Li <Li.Xiubo@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 13, 2013 at 02:43:03PM +0800, Shawn Guo wrote:
> Function sgtl5000_enable_regulators() is somehow odd in handling the
> optional external VDDD supply.  The driver can only enable this supply
> on SGTL5000 chip before revision 0x11, and of course when this external
> VDDD is present.  It currently does something like below.
> 
> 1. Check if regulator_bulk_get() on VDDA, VDDIO and VDDD will fail.  If
>    it fails, VDDD must be absent and it falls on internal LDO by calling
>    sgtl5000_replace_vddd_with_ldo().  Otherwise, VDDD is used.  And in
>    either case, regulator_bulk_enable() will be called to enable
>    3 supplies.
> 
> 2. In case that SGTL5000 revision is later than 0x11, even if external
>    VDDD is present, it has to roll back the 'enable' and 'get' calls
>    with regulator_bulk_disable() and regulator_bulk_free(), and starts
>    over again by calling sgtl5000_replace_vddd_with_ldo() and
>    regulator_bulk_enable().
> 
> Such back and forth calls sequence is complicated and unnecessary.
> Also, since commit 4ddfebd (regulator: core: Provide a dummy regulator
> with full constraints), regulator_bulk_get() will always succeeds
> because of the dummy regulator.  Thus the VDDD detection is broken.
> 
> The patch changes the flow to something like the following, which should
> be more reasonable and clear, and also fix the VDDD detection breakage.
> 
> 1. Check if we're running a chip before revision 0x11, on which an
>    external VDDD can possibly be an option.
> 
> 2. If it is an early revision, call regulator_get_optional() to detect
>    whether an external VDDD supply is available.
> 
> 3. If external VDDD is present, call sgtl5000_replace_vddd_with_ldo() to
>    update sgtl5000->supplies info.
> 
> 4. Drop regulator_bulk_get() call in sgtl5000_replace_vddd_with_ldo(),
>    and call it in sgtl5000_enable_regulators() no matter it's an
>    external VDDD or internal LDO.
> 
> 5. Call regulator_bulk_enable() to enable these 3 regulators.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Mark,

Since what Xiubo is concerned by is another issue apart from this patch
itself and being discussed, can you apply the patch?

Shawn
