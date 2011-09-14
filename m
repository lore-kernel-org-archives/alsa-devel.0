From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 4/4] ALSA: snd-usb: move code from urb.c to
	endpoint.c
Date: Wed, 14 Sep 2011 12:45:22 +0200
Message-ID: <CACTFLAPVOyYhGzxp4nmHyBcOBQY8-osGBe7fgcM27TXX8eCAxQ@mail.gmail.com>
References: <1315846453-5036-1-git-send-email-zonque@gmail.com>
	<1315846453-5036-5-git-send-email-zonque@gmail.com>
	<s5haaa7tq4x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f41.google.com (mail-pz0-f41.google.com
	[209.85.210.41]) by alsa0.perex.cz (Postfix) with ESMTP id 9D7802436D
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 12:45:23 +0200 (CEST)
Received: by pzk4 with SMTP id 4so2978022pzk.14
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2011 03:45:22 -0700 (PDT)
In-Reply-To: <s5haaa7tq4x.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 14, 2011 at 11:44 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 12 Sep 2011 18:54:13 +0200,
> Daniel Mack wrote:
>>
>> No code altered at this point, simply preparing for upcoming
>> refactorizations.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> ---
>> =A0sound/usb/Makefile =A0 | =A0 =A03 +-
>> =A0sound/usb/card.c =A0 =A0 | =A0 =A01 -
>> =A0sound/usb/endpoint.c | =A0924 +++++++++++++++++++++++++++++++++++++++=
++++++++++
>> =A0sound/usb/endpoint.h | =A0 17 +
>> =A0sound/usb/pcm.c =A0 =A0 =A0| =A0 =A02 +-
>> =A0sound/usb/stream.c =A0 | =A0 =A01 -
>> =A0sound/usb/urb.c =A0 =A0 =A0| =A0941 ---------------------------------=
-----------------
>> =A0sound/usb/urb.h =A0 =A0 =A0| =A0 21 --
>> =A08 files changed, 943 insertions(+), 967 deletions(-)
>> =A0delete mode 100644 sound/usb/urb.c
>> =A0delete mode 100644 sound/usb/urb.h
>
> This patch wasn't applied cleanly to my tree. =A0urb.c was rejected.
> Could you refresh the patches based on the latest sound git tree?
> =A0 git://github.com/tiwai/sound.git
>
> The branch topic/misc should contain the latest status for USB.

Ah, the reason for the conflict is that Pierre-Louis Bossart's delay
information patch was merged before mine. New version coming up.

If that's easier, you can also pull from

  git://github.com/zonque/linux-2.6.git usb-audio


Daniel
