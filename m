From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Expected behaviour for two mic jacks
Date: Tue, 30 Nov 2010 12:15:36 +0800
Message-ID: <AANLkTinNjvpsUn9X73CuZDQ6TLTzbUeoRw_-3isGSX42@mail.gmail.com>
References: <4CDD0DDB.9020509@canonical.com>
	<AANLkTikJR7D-4X2ivznG0-RgQDJXA8yx_RHMkc5nBens@mail.gmail.com>
	<ibp1sr$nvs$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A53FF1038D4
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 05:15:38 +0100 (CET)
Received: by ewy19 with SMTP id 19so2475636ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 20:15:38 -0800 (PST)
In-Reply-To: <ibp1sr$nvs$2@dough.gmane.org>
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

2010/11/15 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 14/11/10 01:01 did gyre and gimble:
> > The main point is pulseaudio does not support more than 2 sources on one
> > sound card
>
> Sure it does, it's just not something that is probed for by default. All
> you need to do is write an appropriate mixer profile (see
> /usr/share/pulse/alsa-mixer/
>  <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>
>

it look like PA use 1 period per buffer if skip-probe = yes when
implementing multiple sink/sources on one card (e.g. Native Instruments
Audio 4 DJ  )

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5209
