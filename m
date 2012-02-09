From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] sound/soc/mxs/mxs-saif.c: use devm_
	functions
Date: Thu, 9 Feb 2012 19:45:41 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1202091945150.1845@localhost6.localdomain6>
References: <1328721262-20993-1-git-send-email-Julia.Lawall@lip6.fr>
	<7FE21149F4667147B645348EC60578850C1864@039-SN2MPN1-012.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail4-relais-sop.national.inria.fr
	(mail4-relais-sop.national.inria.fr [192.134.164.105])
	by alsa0.perex.cz (Postfix) with ESMTP id D0CA3103937
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2012 19:45:41 +0100 (CET)
In-Reply-To: <7FE21149F4667147B645348EC60578850C1864@039-SN2MPN1-012.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng-B29396 <B29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 9 Feb 2012, Dong Aisheng-B29396 wrote:

>> -----Original Message-----
>> From: Julia Lawall [mailto:Julia.Lawall@lip6.fr]
>> Sent: Wednesday, February 08, 2012 9:14 AM
>> To: Liam Girdwood
>> Cc: kernel-janitors@vger.kernel.org; Mark Brown; Jaroslav Kysela; Takashi Iwai;
>> alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; Dong Aisheng-B29396
>> Subject: [PATCH] sound/soc/mxs/mxs-saif.c: use devm_ functions
>> Importance: High
>>
>> From: Julia Lawall <Julia.Lawall@lip6.fr>
>>
>> The various devm_ functions allocate memory that is released when a driver
>> detaches.  This patch uses these functions for data that is allocated in the
>> probe function of a platform device and is only freed in the remove function.
>>
>> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>>
>> ---
>> patch against git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
>>
> I still failed to apply against for-3.4 branch.
> Can you switch to for-3.4 branch and then re-generate the patch based on it?

OK.

julia
