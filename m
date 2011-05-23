From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA - HDA - Change "Mic" to "Rear Mic" in
	ad1988_6stack_capture_source
Date: Mon, 23 May 2011 16:03:31 +0800
Message-ID: <BANLkTim3SuBd6RLMeT4LQLFefL1HBK1jqg@mail.gmail.com>
References: <BANLkTim35Trrj+_x+74SEUFA3ud+9Xcc_Q@mail.gmail.com>
	<s5h62p16gwm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DA0CF1037E3
	for <alsa-devel@alsa-project.org>;
	Mon, 23 May 2011 10:03:32 +0200 (CEST)
Received: by fxm5 with SMTP id 5so4212975fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 23 May 2011 01:03:31 -0700 (PDT)
In-Reply-To: <s5h62p16gwm.wl%tiwai@suse.de>
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

2011/5/23 Takashi Iwai <tiwai@suse.de>:
> At Mon, 23 May 2011 14:58:05 +0800,
> Raymond Yau wrote:
>>
>> Change "Mic" to "Rear Mic" in ad1988_6stack_capture_source
>
> Which reason? =A0Please elaborate in the changelog.
>

Sorry, no need to change any thing since it is only model=3Dauto create
the "rear mic" volume controls/boost/switch which is not compatible
with alsactl init
