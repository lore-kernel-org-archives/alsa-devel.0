From: Madura Anushanga <madura.x86@gmail.com>
Subject: K42Jc Notebook(ALC269) port switch between headset,
	headphone, mic
Date: Mon, 28 Feb 2011 23:12:17 +0530
Message-ID: <AANLkTi=k0k1WqHcxJBSWXkeE5jkcTdG3iRUvERuoVoob@mail.gmail.com>
References: <AANLkTikZoGUFHpVXd6H1XbLchjEvuYd8j=mRfYCpayS5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E0B1103848
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 18:42:40 +0100 (CET)
Received: by iwc10 with SMTP id 10so3640207iwc.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 09:42:37 -0800 (PST)
In-Reply-To: <AANLkTikZoGUFHpVXd6H1XbLchjEvuYd8j=mRfYCpayS5@mail.gmail.com>
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
List-Id: alsa-devel@alsa-project.org

Hi,

I want to switch between headphone, headset, mic input/output modes when I
plug in devices. Alsamixer shows two capture channels, one is for the
internal mic. I don't know how to use the other. I've tried switching some
things on and off in hda-analyzer but I failed to get the functionality that
I wanted. This notebook only has one audio port(TRS 3.5mm), so the selection
is vital if I'm going to use an external mic. Currently the port is acting
as an output only port. And something fishy goes on when I select "Analog
Stereo Input" in profiles in Sound Preferences. It lets me use the external
mic through the audio port but only if I push the jack half way, the input
is detected and I can record it(but there's no sound output after I select
this profile, its input only). I some how think that this is the "mic" mode
and if I can get it to work on "headset" mode then I'd be able to use it for
input and output.

This is the information that I got from the script,
http://www.alsa-project.org/db/?f=e70dae201e5d830874536be93090aef0454c8c1e

Thank you,
            - Madura A.
