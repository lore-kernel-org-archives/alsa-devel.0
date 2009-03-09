From: "Cai, Cliff" <Cliff.Cai@analog.com>
Subject: RE: [alsa-devel] [PATCH 2/5] ASoC: ssm2602 codec: fix bug - kernelwill crash when record and play in bf527-ezkit
Date: Mon, 9 Mar 2009 19:07:26 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA03AB85FE@chinexm1.ad.analog.com>
References: <1236326010-683-1-git-send-email-cooloney@kernel.org> <1236326010-683-3-git-send-email-cooloney@kernel.org> <20090306123515.GG6493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753895AbZCILEg@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <20090306123515.GG6493@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>, Bryan Wu <cooloney@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


 This patch should be named :set constraint only if the value is not 0.
 I found that sometimes substream may be not NULL,but runtime can be
NULL,So the previous way will cause
Kernel to crash.

Cliff

>-----Original Message-----
>From: Mark Brown [mailto:broonie@sirena.org.uk] 
>Sent: Friday, March 06, 2009 8:35 PM
>To: Bryan Wu
>Cc: Cliff Cai; alsa-devel@alsa-project.org; 
>linux-kernel@vger.kernel.org
>Subject: Re: [alsa-devel] [PATCH 2/5] ASoC: ssm2602 codec: fix 
>bug - kernelwill crash when record and play in bf527-ezkit
>
>On Fri, Mar 06, 2009 at 03:53:27PM +0800, Bryan Wu wrote:
>
>> set constraint only if the value is not 0, change the 
>configuring way 
>> for sport
>
>This changelog doesn't appear to apply to this patch - it 
>looks like was copied from the previous one?  This patch 
>appears to suffer from a similar issue where only the first 
>format set by an application can ever be used, though since 
>this changes the constraints that are set by the driver 
>there's no possibility that applications will end up trying to 
>use a sample format that the hardware is not configured for.
>
>Do we really need such a heavy handed fix here - what is the 
>issue that's being fixed?
>
