From: Carlo Caione <carlo@endlessm.com>
Subject: Re: [PATCH 01/11] ASoC: rt5651: Avoid duplicating DMI
 quirks between codec and machine driver
Date: Wed, 21 Feb 2018 17:36:02 +0000
Message-ID: <CAL9uMOH0AUvPJZzjfi6RJniJRQE=2wROG6Dny=os63K_zmhhtw@mail.gmail.com>
References: <20180220221511.22861-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f45.google.com (mail-vk0-f45.google.com
 [209.85.213.45])
 by alsa0.perex.cz (Postfix) with ESMTP id A70F3266F68
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 18:36:04 +0100 (CET)
Received: by mail-vk0-f45.google.com with SMTP id t126so1432349vkb.11
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 09:36:04 -0800 (PST)
In-Reply-To: <20180220221511.22861-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 20, 2018 at 10:15 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Instead of duplicating the DMI quirks between the codec and machine driver,
> add a rt5651_set_pdata() codec private function which the machine driver
> can use to pass in pdata.

Commenting here for the whole series (I don't see the cover letter):

Tested-by: Carlo Caione <carlo@endlessm.com>

(On the quirked KIANO laptop).

Thanks!


-- 
Carlo Caione  |  +44.7384.69.16.04  |  Endless
