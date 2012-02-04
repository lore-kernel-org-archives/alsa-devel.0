From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Jack detection on HDA vs SoC
Date: Sat, 4 Feb 2012 11:41:07 +0800
Message-ID: <CAN8ccib=5S6V+tpoN8TjHVBkpXL5LH8f4spPpVL+9v5UsgUQ-g@mail.gmail.com>
References: <CAEUnVG4AGOk4tTC+KKiY_HgXNZs2wx5dD_mOy0vsaYP-ag24jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 55461243ED
	for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2012 04:41:09 +0100 (CET)
Received: by wgbdy1 with SMTP id dy1so3296626wgb.20
	for <alsa-devel@alsa-project.org>; Fri, 03 Feb 2012 19:41:07 -0800 (PST)
In-Reply-To: <CAEUnVG4AGOk4tTC+KKiY_HgXNZs2wx5dD_mOy0vsaYP-ag24jA@mail.gmail.com>
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

2012/2/4, Dylan Reid <dgreid@chromium.org>:
> under hda I see: new, control-based jack notification, and
> auto-switching of the output/input done in the driver.
> under soc it is: /dev/input used for jack notification, with the
> switching _not_ done in the driver.
>
> Is there a plan for the soc code to use the control-based method?
> Is there a consensus on whether new drivers should auto-switch or not?
>

Is there any solution for those combo jack of lenovo t400 and ideapad s200 ?

http://forums.lenovo.com/t5/T400-T500-and-newer-T-series/Audio-combo-jack-vs-headphone-earphone-with-mic-and-speaker/ta-p/240186

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5272

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5523
