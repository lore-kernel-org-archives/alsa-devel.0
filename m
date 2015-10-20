From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFT] ASoC: wm8904: Make undocumented
 registers non-readable
Date: Tue, 20 Oct 2015 10:20:49 +0100
Message-ID: <20151020092049.GC10520@ck-lbox>
References: <1445051470.3014.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E6D42663E5
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 11:39:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1445051470.3014.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 17, 2015 at 11:11:10AM +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> I think the intention of wm8904_readable_register is to return false for
> undocumented registers, but current code returns true for all cases in
> wm8904_readable_register.
> Please review if this patch is correct or not.
> Thanks.

Ok so I have been through every register access in the driver
(yes that was a bit boring) and it looks like the driver only
accesses a register that isn't marked as readable once. But this
looks to be a bug. WM8904_EQ_REGS is set to 25, but there are
only 24 registers in the EQ. This appears to be a mistake caused
by the fact the registers start numbering from 1 rather than 0. I
will send a patch to fix this small bug and this patch looks fine
to me:

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Unfortunately I don't have hardware to test the patch, but I have
reviewed it pretty carefully and am happy.

Thanks,
Charles
