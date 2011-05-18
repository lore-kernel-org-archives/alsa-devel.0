From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] Max98095: Move existing NULL check before
 pointer dereference.
Date: Wed, 18 May 2011 10:32:39 +0100
Message-ID: <4DD39237.5040905@ti.com>
References: <1305680634-10484-1-git-send-email-thutt@chromium.org>
	<B2150E1E4418E1438554A300EA5040E40DDDA179DA@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id CC1E110383E
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 11:32:42 +0200 (CEST)
In-Reply-To: <B2150E1E4418E1438554A300EA5040E40DDDA179DA@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Taylor Hutt <thutt@chromium.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 18/05/11 02:28, Peter Hsiang wrote:
> On Tue, May 17, 2011, Taylor Hutt wrote:
> 
>> Visual inspection shows that max98095_put_eq_enum() and
>> max98095_put_bq_enum() each have a possible NULL deref of 'pdata'.
>>
>> This change moves the NULL check above the use.
>>
>> BUG=none
>> TEST=Visual inspection
> 
> Mark, this patch looks good.
> Thank you Taylor.
> 

Acked-by: Liam Girdwood <lrg@ti.com>
