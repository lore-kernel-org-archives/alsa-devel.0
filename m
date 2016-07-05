From: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 2/6] ASoC: samsung: Add Samsung Low Power
 Audio Subsystem driver
Date: Tue, 05 Jul 2016 16:58:39 +0200
Message-ID: <577BCB1F.3000008@samsung.com>
References: <1466678715-19962-1-git-send-email-s.nawrocki@samsung.com>
 <1466678715-19962-3-git-send-email-s.nawrocki@samsung.com>
 <20160629215757.GX6247@sirena.org.uk> <577553FE.6080803@samsung.com>
 <20160701150709.GT6247@sirena.org.uk> <57769AE5.4050407@samsung.com>
 <20160702082548.GF6247@sirena.org.uk> <577A8BF7.8090900@samsung.com>
 <20160705142524.GW6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20160705142524.GW6247-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 07/05/2016 04:25 PM, Mark Brown wrote:
> There should be nothing in principle that stops you registering AMBA
> devices like MFDs currently register platform devices, or you could
> perhaps add platform device registration in the PL330 to let it be
> registered with either platform or AMBA?

As it turned out of_platform_populate() handles properly AMBA devices
by looking at the compatible string. If compatible contains
"arm,primecell" then an amba device instead of a platform device
is created for a DT node.

I used of_platform_populate() instead of mfd_add_devices() in the MFD
driver's probe(). Additionally I had to rearrange exynos5433.dtsi
and to make the LPASS devices specified as sub-nodes of the LPASS node.

It all seems to work fine, I will post v4 so we can continue commenting
on the actual patches.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
