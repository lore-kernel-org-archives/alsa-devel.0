From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH - alsa-lib] tlv: Check dB range only within
 the control's volume range
Date: Wed, 19 May 2010 08:55:40 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005190854200.6856@eeebox2.perex-int.cz>
References: <1274249966-31030-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5256824533
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 08:55:41 +0200 (CEST)
In-Reply-To: <1274249966-31030-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 19 May 2010, Peter Ujfalusi wrote:

> The DB_RANGE need to be used on some HW, since the gain on
> volume control is not continuous, and has to be divided into
> several sub DB_SCALE ranges.
> ASoC has a feature to override the HW default volume range,
> and in this case when the volume range is less than the
> HW maximum we do not need to go through the whole DB_RANGE,
> but we need to stop where the kcontrol's maximum tell us.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Unfortunately, it does not look like a clean way in my eyes. If the driver 
pushes some limits to the control (volume) range, it should do it also 
for TLVs.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
