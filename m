From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Auto-muting line-outs?
Date: Tue, 3 Aug 2010 16:53:04 +0800
Message-ID: <AANLkTin=o=EG53P6Su=M38M5T6iYrwRY12onR1dsjpM6@mail.gmail.com>
References: <4C57CB09.2090004@canonical.com>
	<20100803084226.GA7734@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 601E92414D
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 10:53:08 +0200 (CEST)
Received: by qyk8 with SMTP id 8so2689341qyk.17
	for <alsa-devel@alsa-project.org>; Tue, 03 Aug 2010 01:53:07 -0700 (PDT)
In-Reply-To: <20100803084226.GA7734@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/8/3 Mark Brown <broonie@opensource.wolfsonmicro.com>

> On Tue, Aug 03, 2010 at 09:53:45AM +0200, David Henningsson wrote:
> > I'm getting bug reports from downstream about auto-muting not working,
> > and when looking at some of them I find that the reason is that they
> > have a headphone + line-out combination instead of headphone + speaker.
>
> > Looking at commits such as 2a2ed0df, this is intentional. I'm not sure
> > what the majority of users want or expect in this case though, of course
> > the users who like it the way it is, aren't raising their voices. :-)
>
> I'd certainly expect line outputs to stay live regardless of headphone
> state - there's just too much diversity in what they could be connected
> to to allow that sort of automated handling in kernel.
>

Some of the case not handled by the driver are those laptops which equipped
with 4.1 or 5.1 internal speakers and they need auto mute more that one pair
of speakers

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4555

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5083
