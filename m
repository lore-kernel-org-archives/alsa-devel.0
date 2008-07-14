From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper
	for matching bus and codec drivers
Date: Mon, 14 Jul 2008 10:27:43 -0600
Message-ID: <fa686aa40807140927k23ab78eeg65ca84b2b74d01dd@mail.gmail.com>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714134930.GC25448@sirena.org.uk>
	<9e4733910807140713r5739efedw81e65632006d101d@mail.gmail.com>
	<20080714150527.GD25448@sirena.org.uk>
	<487B7B71.9060606@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.236])
	by alsa0.perex.cz (Postfix) with ESMTP id E1C472438A
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jul 2008 18:27:44 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id h30so2598804wxd.23
	for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2008 09:27:43 -0700 (PDT)
In-Reply-To: <487B7B71.9060606@freescale.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 14, 2008 at 10:14 AM, Timur Tabi <timur@freescale.com> wrote:
> Mark Brown wrote:
>
>>> The PowerPC side isn't without fault too. PowerPC still doesn't have a
>>> good way to load the fabric/machine driver.
>>
>> I'm finding it difficult to square these two statements - from an ASoC
>> point of view the main thing this patch is doing is adding a machine
>> driver and that's not something that's going to go away.
>
> Jon's concern is that there is no straightforward way to build a kernel with
> multiple fabric drivers and have the right one chosen via the device tree.  This
> is just a limitation of the device tree model, and no one has come up with a
> good solution yet.
>
> The problem still exists in ASoC V2.  However, it's not anything that ASoC
> itself needs to be concerned with.  It's purely a PowerPC problem.

It's purely an *OF Device Tree* problem.  PowerPC isn't the only
platform using the device tree.  :-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
