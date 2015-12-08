From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/13] ASoC: wm_adsp: Fixup some minor
 formatting and checkpatch errors
Date: Tue, 8 Dec 2015 16:33:34 +0000
Message-ID: <20151208163334.GG6058@localhost.localdomain>
References: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AA3D260476
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 19:38:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 08, 2015 at 04:08:25PM +0000, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---

Apologies just realised I completely forgot to attach a cover
letter to this series that could have clearly done with one.

This series add support for voice control on wm8280/5110. This is
done by opening a compressed record channel, upon which data will
be available once the voice control functionality has been
triggered on the DSP.

Additionally the series starts with a few small clean ups and the
addition of some sorely missing locking in the ADSP driver.

Thanks,
Charles
