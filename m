From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 2/2] wm8750: add missing VREF output
Date: Mon, 11 Aug 2008 18:16:28 +0400
Message-ID: <48A049BC.80609@gmail.com>
References: <1218444346-19153-1-git-send-email-dbaryshkov@gmail.com>
	<1218444346-19153-2-git-send-email-dbaryshkov@gmail.com>
	<20080811091119.GC9668@rakim.wolfsonmicro.main>
	<48A0025C.6000903@gmail.com> <20080811101939.GB5560@sirena.org.uk>
	<s5h8wv3q1l2.wl%tiwai@suse.de>
	<20080811104204.GC5560@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.184])
	by alsa0.perex.cz (Postfix) with ESMTP id C23E8245DF
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Aug 2008 16:17:50 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id b27so1723866fka.0
	for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2008 07:17:50 -0700 (PDT)
In-Reply-To: <20080811104204.GC5560@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Mark Brown wrote:
> On Mon, Aug 11, 2008 at 12:37:45PM +0200, Takashi Iwai wrote:
> 
>> You mean both patches (spitz: MONO -> MONO1 and wm8750: add missing
>> VREF)?  Anyway, a bit more detailed changelog is needed - what's
>> broken in the real use and how fixed.
> 
> The long description is exactly what's broken - the names are wrong or
> undeclared and since DAPM works based on the control names this causes
> the drivers to fail to initialise DAPM for the device concerned.  It's
> pretty much equivalent to C code referencing an undeclared variable.
> 

I saw these patches got merged into asoc/dev tree. Should I repost them 
with more descriptive changelog, or are them suitable as is?

-- 
With best wishes
Dmitry
