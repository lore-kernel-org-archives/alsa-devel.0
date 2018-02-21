From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 01/11] ASoC: rt5651: Avoid duplicating DMI
 quirks between codec and machine driver
Date: Wed, 21 Feb 2018 21:55:56 +0100
Message-ID: <03907877-c3cc-ec04-5255-fbda31dd766d@redhat.com>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <CAL9uMOH0AUvPJZzjfi6RJniJRQE=2wROG6Dny=os63K_zmhhtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f175.google.com (mail-wr0-f175.google.com
 [209.85.128.175])
 by alsa0.perex.cz (Postfix) with ESMTP id A8B7F267659
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 21:55:58 +0100 (CET)
Received: by mail-wr0-f175.google.com with SMTP id f14so8242890wre.8
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 12:55:58 -0800 (PST)
In-Reply-To: <CAL9uMOH0AUvPJZzjfi6RJniJRQE=2wROG6Dny=os63K_zmhhtw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carlo Caione <carlo@endlessm.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 21-02-18 18:36, Carlo Caione wrote:
> On Tue, Feb 20, 2018 at 10:15 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Instead of duplicating the DMI quirks between the codec and machine driver,
>> add a rt5651_set_pdata() codec private function which the machine driver
>> can use to pass in pdata.
> 
> Commenting here for the whole series (I don't see the cover letter):
> 
> Tested-by: Carlo Caione <carlo@endlessm.com>
> 
> (On the quirked KIANO laptop).

Great, thank you for testing, so are the issues with headset vs
headphone detection not working fixed after this series?

Regards,

Hans
