From: Bo Shen <voice.shen@atmel.com>
Subject: Re: "disable" or "disabled" in DT?
Date: Thu, 13 Dec 2012 09:51:11 +0800
Message-ID: <50C9348F.3000209@atmel.com>
References: <s5hhanrfhpa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D3012615CD
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2012 02:52:07 +0100 (CET)
In-Reply-To: <s5hhanrfhpa.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 12/12/2012 22:50, Takashi Iwai wrote:
> Hi,
>
> in the recent commit for atmel-ssc to add DT support, you added the
> lines
> 	status = "disable";

Good catch, thanks.
I will send a patch to correct this.

Best Regards,
Bo Shen

>
> Now looking through all commits for merging 3.8-rc1, I noticed that
> other codes have
> 	status = "disabled";
>
> I think this should be kept consistent.
>
>
> Takashi
>
