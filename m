From: Amit Nagal <helloin.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: snd_usb_hardware definition
Date: Wed, 25 Apr 2012 14:34:16 +0530
Message-ID: <CA+F9FsBp+f_nLCRLKBRstU7Ke=naSrnTNjKME9dhwUjvXt0arQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: alsa-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi ,

In H/W Descriptor snd_usb_hardware (sound/usb/pcm.c) , the following
values are used :

static struct snd_pcm_hardware snd_usb_hardware =
{
         ....
        .buffer_bytes_max =     1024 * 1024,
        .period_bytes_min =     64,
        .period_bytes_max =     512 * 1024,
        .periods_min =          2,
        .periods_max =          1024,
};


can i be guided what criterion is used to set the values of above
fields ( periods_min, periods_max , period_bytes_min ,
period_bytes_max , buffer_bytes_max)
as defined above for a snd usb h/w .

Regards
Amit Nagal
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
