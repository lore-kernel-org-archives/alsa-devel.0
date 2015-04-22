From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/8] extcon: arizona: Add support for WM8998 and WM1814
Date: Wed, 22 Apr 2015 10:19:41 +0100
Message-ID: <20150422091941.GA4303@opensource.wolfsonmicro.com>
References: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com> <1429619636-25478-7-git-send-email-rf@opensource.wolfsonmicro.com> <55373766.6060106@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55373766.6060106@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, myungjoo.ham@samsung.com, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 22, 2015 at 02:53:42PM +0900, Chanwoo Choi wrote:
> Hi Richard,
> 
> > @@ -1176,6 +1182,11 @@ static int arizona_extcon_probe(struct platform_device *pdev)
> >  			break;
> >  		}
> >  		break;
> > +	case WM8998:
> > +	case WM1814:
> > +		info->micd_clamp = true;
> > +		info->hpdet_ip = 2;
> 
> What is meaning of '2'? I prefer to use the definition for '2'.
> 

'2' is the version number of the hpdet ip block in silicon. We're already using
it as a raw number '0', '1' or '2' all over extcon-arizona.c so changing it here
would mean making other patches to the file that aren't really part of adding
WM8998 support, so I'd prefer not to change that as a side-effect of adding WM8998.


> Except for upper one comment, looks good to me.
> 
> Thanks,
> Chanwoo Choi
