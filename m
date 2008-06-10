From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 1/2] opti93x: add support for Opti93x codec
 in cs4231-lib
Date: Tue, 10 Jun 2008 07:04:49 +0200
Message-ID: <20080610070449.955c9429.krzysztof.h1@poczta.fm>
References: <20080609230728.273c9e1e.krzysztof.h1@poczta.fm>
	<484DBB07.1080802@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 7201A24A4C
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jun 2008 07:02:09 +0200 (CEST)
In-Reply-To: <484DBB07.1080802@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 10 Jun 2008 01:21:43 +0200
Rene Herman <rene.herman@keyaccess.nl> wrote:

> On 09-06-08 23:07, Krzysztof Helt wrote:
> 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > This patch adds support for WSS compatible Opti93x
> > codec to the cs4231-lib.
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > ---
> > This patch was sent some time ago but was not accepted
> > due to regression of the driver on the  opti 930 chip.
> > The regression is fixed with already accepted patch, so 
> > it should work now. 
> 
> Could you elaborate a bit? Yesterday's patch removing the QS1000 from 
> 82C930 fixed the 930 staying silent but the regression this introduced 
> previously at least appeared to be a different one.
> 
> Post QS1000, 82C930 appeared to work fine, just didn't actually produce 
> a signal onto its analog out. Post CS4231, 82C930 wasn't just silent but 
> didn't even generate any interrupts anymore.
> 

It seems that setting something in the digital input register broke sound
on the Opti930 before cs4321 patches (silence) and after using cs4231 library
(no interrupts). 

> I didn't compare with your old code...
> 

No changes in the code. Finally, I hunted the opti 930 on an online auction, so
I was able to test the old patches. After the QS1000 patch everything got
magically fixed and no changes were required.

> 
> also on 930, 931 and 933 for playback, capture on 930 and 931. So 
> whatever the answer to the above, it appears that problem is now also 
> fixed. Which is very good; this is a rather welcome unification/cleanup 
> as far as I'm concerned.
> 
> The mixer levels do seem different between the old and new driver. Does 
> that make sense? The new one appears to  be a bit louder so there might 
> be an offset issue somewhere I suppose. I didn't compare that closely.
> 

I will check this. I haven't had time yet. I will try investigating this week.

Regards,
Krzysztof

---------------------------------------------------------------
Sprawdz jak zdobyc zdrowy usmiech!
Kliknij >> http://link.interia.pl/f1e26
