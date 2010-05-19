From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH - alsa-lib] tlv: Check dB range only within
	the control's volume range
Date: Wed, 19 May 2010 14:33:11 +0300
Message-ID: <201005191433.11353.peter.ujfalusi@nokia.com>
References: <1274249966-31030-1-git-send-email-peter.ujfalusi@nokia.com>
	<201005191028.55258.peter.ujfalusi@nokia.com>
	<alpine.LNX.2.00.1005191239530.6856@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C1B824641
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 13:33:30 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1005191239530.6856@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 19 May 2010 13:42:03 ext Jaroslav Kysela wrote:
> I forgot that we carry the control value ranges in the DB_RANGE
> container. I applied your patch to alsa-lib's GIT tree. Thanks for it and
> for your detailed analysis.

Thank you!

I already prepared a backup plan to override the original TLV container, wh=
ich =

is a bit ugly, but could achieve identical results without change in alsa-l=
ib.
But with the fix in alsa-lib I don't need to convince the ASoC guys to acce=
pt =

that workaround.

Thanks again,
P=E9ter
