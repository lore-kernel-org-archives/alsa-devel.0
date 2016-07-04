From: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 2/6] ASoC: samsung: Add Samsung Low Power
 Audio Subsystem driver
Date: Mon, 04 Jul 2016 18:16:55 +0200
Message-ID: <577A8BF7.8090900@samsung.com>
References: <1466678715-19962-1-git-send-email-s.nawrocki@samsung.com>
 <1466678715-19962-3-git-send-email-s.nawrocki@samsung.com>
 <20160629215757.GX6247@sirena.org.uk> <577553FE.6080803@samsung.com>
 <20160701150709.GT6247@sirena.org.uk> <57769AE5.4050407@samsung.com>
 <20160702082548.GF6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20160702082548.GF6247-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 07/02/2016 10:25 AM, Mark Brown wrote:
> On Fri, Jul 01, 2016 at 06:31:33PM +0200, Sylwester Nawrocki wrote:
> 
>> > In the SoC there is a dedicated power domain for the whole audio subsystem 
>> > and LPASS also contains a VIC itself. We could try to decompose the LPASS 
>> > top block into various subsystems but I seriously doubt it's a good way
>> > forward. I think LPASS should rather be some top level SoC platform entity.
>
> So a MFD then?

It might a best match, however I yet need to figure out what to do with
the PL330 DMAC which is a child of the amba bus.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
