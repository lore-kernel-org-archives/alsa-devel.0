From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Adding ELD control to alsa-lib hdmi device
Date: Sun, 25 Sep 2011 21:15:14 +0800
Message-ID: <CAN8cciYYezp=xqBMmBE4mpyBg+vJC_R23Pychc8h++pUOmVtJw@mail.gmail.com>
References: <1316793246-819-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4e7cd40f.5558df0a.269f.ffffef98SMTPIN_ADDED@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9817A1037EE
	for <alsa-devel@alsa-project.org>;
	Sun, 25 Sep 2011 15:15:18 +0200 (CEST)
Received: by fxe22 with SMTP id 22so5362877fxe.38
	for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2011 06:15:18 -0700 (PDT)
In-Reply-To: <4e7cd40f.5558df0a.269f.ffffef98SMTPIN_ADDED@mx.google.com>
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

2011/9/24 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>:
> Hi,
> Now that I almost done with exposing a read-only ELD control for HDA/HDMI
> outputs, I was wondering how to read it from user-land. PulseAudio and
> others rely on the 'hdmi' device, and apparently I can't access this new ELD
> control, I have to use the 'hw:x,y' details.

If you are using iface_pcm



http://www.alsa-project.org/alsa-doc/alsa-lib/control_8c.html

CTL interface

use snd_ctl_open() to open "hw:x"


or  use

alsactl store
