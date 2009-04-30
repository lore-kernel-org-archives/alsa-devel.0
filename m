From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: change DAPMs for analog
	microphone selection
Date: Thu, 30 Apr 2009 09:51:21 +0300
Message-ID: <200904300951.21620.peter.ujfalusi@nokia.com>
References: <49F69B56.4000902@samsung.com>
	<200904281506.41577.peter.ujfalusi@nokia.com>
	<49F79D09.6010901@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id DB28824453
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Apr 2009 08:52:12 +0200 (CEST)
In-Reply-To: <49F79D09.6010901@samsung.com>
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
Cc: "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, ext Joonyoung Shim <jy0922.shim@samsung.com>, "bhmin@samsung.com" <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 29 April 2009 03:19:21 ext Joonyoung Shim wrote:
> I read it at TRM too, but cannot believe it such mixer of outputs.
>
> Actually, i setted to 1 both HSMIC_EN bit and MAINMIC_EN bit for the
> ANAMICL register, and recorded sound from headset mic and main mic. The
> result is that both sounds are recorded.
>
> So, to be sure this part, can you inquire about it to TI side?

I'll ask Ti about this and also about the output mixer/mux thing, just to b=
e =

sure that we are not doing anything 'illegal' with those either.

We should wait with this until Ti responds, I'll let you know what is their =

opinion...

-- =

P=E9ter
