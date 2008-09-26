From: Frank Mandarino <fmandarino@endrelia.com>
Subject: Re: ALSA:ATMEL: common arch for audio via ssc(patch
 3/3: adding directories)
Date: Fri, 26 Sep 2008 10:55:00 -0400
Message-ID: <48DCF7C4.9030300@endrelia.com>
References: <48DCAA3A.8030209@atmel.com> <20080926125035.GB15493@sirena.org.uk>
	<48DCEF39.40003@endrelia.com>
	<20080926142452.GF15493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ironport2-out.teksavvy.com (ironport2-out.teksavvy.com
	[206.248.154.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 92F49243A4
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 16:55:02 +0200 (CEST)
In-Reply-To: <20080926142452.GF15493@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, Sep 26, 2008 at 10:18:33AM -0400, Frank Mandarino wrote:
> 
>> Now that there are other Atmel ASoC machine drivers in the kernel, and
>> given the fact that our company does not have the resources to actively
>> maintain it, I think the eti_b1_wm8731.c driver should be removed.
> 
>> This reduces the effort in maintaining ASoC, as eti_b1_wm8731.c would no
>> longer have to be kept up-to-date with ASoC changes.  It also eases the
>> pressure on me to test ASoC updates against eti_b1_wm8731.c as they are
>> made.
> 
>> So unless you or Mark feels the eti_b1_wm8731.c driver should remain in
>> the kernel source, I'll submit a patch to remove it after your patches
>> are in place.
> 
> Sounds like a plan - may be just as well to submit the patch now given
> that Sedji is modifying the driver anyway, it might make his life
> slightly easier?

I have no problem submitting a patch sooner, but it might be a few days
before I can start on this.

I'll leave it up to Sedji to decide if I should wait until he is done or
not.

../fam
-- 
Frank Mandarino                                fmandarino(a)endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada
