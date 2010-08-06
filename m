From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 3/3] ASoC: multi-comp: OMAP2, 3,
	4 McBSP: register correct number of ports
Date: Fri, 6 Aug 2010 11:18:56 +0300
Message-ID: <201008061118.56711.peter.ujfalusi@nokia.com>
References: <1281080355-22589-1-git-send-email-peter.ujfalusi@nokia.com>
	<1281080355-22589-4-git-send-email-peter.ujfalusi@nokia.com>
	<20100806110808.8452ec7a.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id E6F58103975
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 10:19:22 +0200 (CEST)
In-Reply-To: <20100806110808.8452ec7a.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "arunks@mistralsolutions.com" <arunks@mistralsolutions.com>, "jkrzyszt@tis.icnet.pl" <jkrzyszt@tis.icnet.pl>
List-Id: alsa-devel@alsa-project.org

On Friday 06 August 2010 11:08:08 ext Jarkko Nikula wrote:
> This must be done at runtime since we can have multi omap builds now.
> So use cpu_is_omapxxx instead of conditional compilation. Simplifies
> patch too :-)

Yes, you are right, I'll do that.
I'll do the same with OMAP1 (2 vs 3 ports)..

Thanks,
P=E9ter
