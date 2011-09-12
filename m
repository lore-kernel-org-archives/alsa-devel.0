From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA ymfpci - Add "Playback" to FM Legacy
 Volume control
Date: Mon, 12 Sep 2011 10:45:25 +0800
Message-ID: <CAN8cciaqt_eBLGeSA0XYaLt0B5R1M0ituHt-DDFrZHRazcR_gA@mail.gmail.com>
References: <CAN8cciZ=vOBPK-EFKpX8f7tsUYqPZ5bZk1F_4nYYoDf_yGia-w@mail.gmail.com>
	<4E6CD899.2090000@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 54220103820
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 04:45:27 +0200 (CEST)
Received: by fxe22 with SMTP id 22so2079977fxe.38
	for <alsa-devel@alsa-project.org>; Sun, 11 Sep 2011 19:45:25 -0700 (PDT)
In-Reply-To: <4E6CD899.2090000@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/9/11 Clemens Ladisch <clemens@ladisch.de>:
> Raymond Yau wrote:
>> Add "Playback" to "FM Legacy Volume" control since
>>
>> - YDSXGR_LEGACYOUTVOL is a Playback Volume control for OPL3 FM Synth
>
> Applied; thanks!
>
>
> Clemens
>

How accurate is the ymfpci timer ?

my ymf724f seem play quite well with alsa "hw" device but with bad
noise with alsa-pulse plugin (e.g. aplay when not using default period
times )  and it also occurrs on   benshee on ubuntu 11.4 live cd

Does the driver really need periods_min =3 ?

it there any test case which it does not work with 2 periods

changing  default sample rate of PA server from 44100 to 48000 in
daemon.conf does not help to remove the noise
