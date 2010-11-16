From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Expected behaviour for two mic jacks
Date: Tue, 16 Nov 2010 09:52:26 +0800
Message-ID: <AANLkTimySCfhsvscfAyogiH8jW1AM-2z8ZrVWUX2-+xH@mail.gmail.com>
References: <4CDD0DDB.9020509@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1989824580
	for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2010 02:52:33 +0100 (CET)
Received: by eyg24 with SMTP id 24so56147eyg.38
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 17:52:26 -0800 (PST)
In-Reply-To: <4CDD0DDB.9020509@canonical.com>
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

2010/11/12 David Henningsson <david.henningsson@canonical.com>

> Hi,
>
> A while ago I asked for the default/expected behaviour for auto-mute.
> Here's the same question for mics:
>
> If there are two mic jacks, e g one on the front and one on the back, is
> the standard/default behaviour that we should:
>

The main problem is the "pink jack" and "blue jack" at rear panel can be
retasked as output pin for those motherboard with 3 audio jack at rear panel
(e.g. those VIA codec has "Smart51" switch

Some realtek codec has "Line/Mic jack mode" or "Mic Jack Mode" controls

How about those laptop docked into a docking station ?

Did pulseaudio changed the profile from "Internal Mic" or "External Mic" to
"Dock Mic" automatically
