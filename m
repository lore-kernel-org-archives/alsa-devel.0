From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/8] extcon: arizona: Add support
	for	WM8998 and WM1814
Date: Thu, 23 Apr 2015 15:15:40 +0100
Message-ID: <20150423141540.GA17323@opensource.wolfsonmicro.com>
References: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1429619636-25478-7-git-send-email-rf@opensource.wolfsonmicro.com>
 <55373766.6060106@samsung.com>
 <20150422091941.GA4303@opensource.wolfsonmicro.com>
 <553775D9.9080606@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D961E261A84
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 16:15:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <553775D9.9080606@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, myungjoo.ham@samsung.com, ckeepax@opensource.wolfsonmicro.com, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 22, 2015 at 07:20:09PM +0900, Chanwoo Choi wrote:
> On 04/22/2015 06:19 PM, Richard Fitzgerald wrote:
> > On Wed, Apr 22, 2015 at 02:53:42PM +0900, Chanwoo Choi wrote:
> >> Hi Richard,
> >>
> >>> @@ -1176,6 +1182,11 @@ static int arizona_extcon_probe(struct platform_device *pdev)
> >>>  			break;
> >>>  		}
> >>>  		break;
> >>> +	case WM8998:
> >>> +	case WM1814:
> >>> +		info->micd_clamp = true;
> >>> +		info->hpdet_ip = 2;
> >>
> >> What is meaning of '2'? I prefer to use the definition for '2'.
> >>
> > 
> > '2' is the version number of the hpdet ip block in silicon. We're already using
> > it as a raw number '0', '1' or '2' all over extcon-arizona.c so changing it here
> > would mean making other patches to the file that aren't really part of adding
> > WM8998 support, so I'd prefer not to change that as a side-effect of adding WM8998.
> 
> I think that just you can define following definitions and use HPDET_IP_VER_V2 instead of '2'.
> 
> 	#define HPDET_IP_VER_V0		0
> 	#define HPDET_IP_VER_V1		1
> 	#define HPDET_IP_VER_V2		2
> 

Can we deal with that as a separate patch from this series? Like I said,
the code already uses '0' '1' and '2' for the existing codecs so making a
change to use #define means patching the code for the other codecs. That
is not part of adding WM8998 support and I don't like patches that make
unexpected extra side-effect changes that are not relevant to the actual
functionality being added by the patch. It's specially annoying when
cherry-picking or reverting those patches if they included some extra
code change.

If we can get this series submitted I can look at making a later patch
to improve readbility, but since this really is just a version number I
think it would be enough to rename the variable to hpdet_ip_version rather
than effectively doing #define TWO 2


> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
