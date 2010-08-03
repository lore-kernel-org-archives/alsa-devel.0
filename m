From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Auto-muting line-outs?
Date: Tue, 3 Aug 2010 09:42:27 +0100
Message-ID: <20100803084226.GA7734@sirena.org.uk>
References: <4C57CB09.2090004@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DC6DB10388A
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 10:42:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C57CB09.2090004@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 03, 2010 at 09:53:45AM +0200, David Henningsson wrote:
> I'm getting bug reports from downstream about auto-muting not working,
> and when looking at some of them I find that the reason is that they
> have a headphone + line-out combination instead of headphone + speaker.

> Looking at commits such as 2a2ed0df, this is intentional. I'm not sure
> what the majority of users want or expect in this case though, of course
> the users who like it the way it is, aren't raising their voices. :-)

I'd certainly expect line outputs to stay live regardless of headphone
state - there's just too much diversity in what they could be connected
to to allow that sort of automated handling in kernel.
