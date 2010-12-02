From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH_5/5=5D_ASoC=3A_tpa6130a2=3A_?=
 =?iso-8859-1?q?Make=09DAPM_registration_optional=2C_and_direct_interface?=
Date: Thu, 2 Dec 2010 09:06:26 +0200
Message-ID: <201012020906.26841.peter.ujfalusi@nokia.com>
References: <1291125604-10396-1-git-send-email-peter.ujfalusi@nokia.com>
	<201012011007.57750.peter.ujfalusi@nokia.com>
	<20101201114427.GB5688@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B9001037FB
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 08:06:33 +0100 (CET)
In-Reply-To: <20101201114427.GB5688@sirena.org.uk>
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
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wednesday 01 December 2010 13:44:28 ext Mark Brown wrote:
> You didn't mention any pop/click issues in the original patch or the
> discussion following it as far as I remember - in your original patch
> there was nothing motivating doing this

Correct. At that time I did not noticed this problem, and with that HW setu=
p it =

was OK. With different components however the ordering is a problem.
I only had chance/time to look for pop noise recently...

> I think this is a better approach since it solves an actual problem.  We
> may want to consider introducing a new widget type for edge PGAs, though
> I can see that getting overused.

Thanks, I'll send a patch to remove the DAPM things from the tpa driver.
It's a shame, sicne the DAPM things inside of the driver looks quite nice a=
fter =

the series ;)

-- =

P=E9ter
