From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] Try to support analog audio codec at firefly reload
Date: Fri, 19 Aug 2016 16:16:00 +0200
Message-ID: <6373888.a6VB9iqPkj@phil>
References: <1471293727-26258-1-git-send-email-ayaka@soulik.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471293727-26258-1-git-send-email-ayaka-xPW3/0Ywev/iB9QmIjCX8w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Randy Li <ayaka-xPW3/0Ywev/iB9QmIjCX8w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Am Dienstag, 16. August 2016, 04:42:06 CEST schrieb Randy Li:
> Hello:
>   This patch could enabled the es8328 codec at firefly reload board,
> but it doesn't not really work. I disable the mute of channel
> Left mix and Right mix in alsamixer, I could hear the noise from
> my headphone, but it never be a music.
>   I just send this patch here to see whether somebody could figure
> out what is wrong, I am really not familiar with sound.

I can't really help here as I have neither the board nor that much sound 
experience, but it's definitly customary to label patches as rfc when they're 
expected to need more work, so make that

[PATCH RFC] ...

for stuff that requires more work before it can actually be merged.


Heiko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
