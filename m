From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] asoc/multi-component: mpc8610: replace
 of_device with platform_device
Date: Fri, 20 Aug 2010 10:49:19 -0500
Message-ID: <AANLkTi=nAR=qCikxMK25a6u_vT5t_hz0RGo2Us+sba6T@mail.gmail.com>
References: <1282249618-27137-1-git-send-email-timur@freescale.com>
	<20100820094113.GB13668@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id ECC881038F7
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 17:49:19 +0200 (CEST)
Received: by vws20 with SMTP id 20so3142042vws.38
	for <alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 08:49:19 -0700 (PDT)
In-Reply-To: <20100820094113.GB13668@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 20, 2010 at 4:41 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Aug 19, 2010 at 03:26:58PM -0500, Timur Tabi wrote:
>> 'struct of_device' no longer exists, and its functionality has been merg=
ed
>> into platform_device. =A0Update the MPC8610 HPCD audio drivers (fsl_ssi,=
 fsl_dma,
>> and mpc8610_hpcd) accordingly.
>>
>> Also add a #include for slab.h, which is now needed for kmalloc and kfre=
e.
>>
>> Signed-off-by: Timur Tabi <timur@freescale.com>
>
> This doesn't apply against current for-2.6.37 (presumably as a result of
> the merge up of 2.6.36-rc1) - could you check please?

I believe that this is because you are missing this patch:

[v2] asoc/multi-component: fsl: add support for variable SSI FIFO depth

Liam, would you please ask Mark to pull from your for-2.6.37 branch,
so that he can pick up this patch?

-- =

Timur Tabi
Linux kernel developer at Freescale
