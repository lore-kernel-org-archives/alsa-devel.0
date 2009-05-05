From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/1] ASoC: TWL4030: VIBRA output support
Date: Tue, 5 May 2009 09:12:45 +0300
Message-ID: <200905050912.45506.peter.ujfalusi@nokia.com>
References: <1241502947-18151-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FAAC24450
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 08:13:00 +0200 (CEST)
In-Reply-To: <1241502947-18151-1-git-send-email-peter.ujfalusi@nokia.com>
Content-Disposition: inline
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 05 May 2009 08:55:46 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> Hello,
>
> The VIBRA output can be driven with audio data or with local vibrator
> driver, the following patch adds VIBRA output support (for driving the
> VIBRA output with audio data) for the TWL4030 codec.

Forgot to mention, that this patch should be fine against Mark's =

sound-2.6:for-2.6.31 branch in regards of TWL4030 codec (on top of commit: =

ASoC: TWL4030: Add voice digital loopback: sidetone from Lopez Cruz, Misael)

-- =

P=E9ter
