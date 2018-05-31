From: Tzung-Bi Shih <tzungbi@google.com>
Subject: It seems return value of snd_soc_dapm_put_enum_double(
	) is inverted
Date: Thu, 31 May 2018 18:46:16 +0800
Message-ID: <CA+Px+wVLxw_0WrsjNays9Ab-Z-Qh=arRnUUSJpiaNLzAybf7oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f176.google.com (mail-ot0-f176.google.com
 [74.125.82.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BF922678FA
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 12:46:28 +0200 (CEST)
Received: by mail-ot0-f176.google.com with SMTP id 15-v6so24743315otn.12
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 03:46:28 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Dylan Reid <dgreid@google.com>, Jimmy Cheng-Yi Chiang <cychiang@google.com>
List-Id: alsa-devel@alsa-project.org

Hi,

snd_soc_dapm_put_enum_double( ) returns 0 to indicate success;
otherwise an error number.  The value in the function is retrieved
from dapm_kcontrol_set_value( ).

> change = dapm_kcontrol_set_value(kcontrol, val);

However, dapm_kcontrol_set_value( ) returns a boolean.

> static bool dapm_kcontrol_set_value(const struct snd_kcontrol *kcontrol,
>        unsigned int value)
> {
>        struct dapm_kcontrol_data *data = snd_kcontrol_chip(kcontrol);
>
>        if (data->value == value)
>                return false;
>
>        if (data->widget)
>                data->widget->on_val = value;
>
>        data->value = value;
>
>        return true;
> }

If the value has updated successfully, dapm_kcontrol_set_value( ) will
return 1 and snd_soc_dapm_put_enum_double( ) will also return 1.  The
value is inverted.
