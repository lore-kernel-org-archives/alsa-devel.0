From: John Keeping <john-HooS5bfzL4hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] Try to support analog audio codec at firefly reload
Date: Sat, 20 Aug 2016 19:33:38 +0100
Message-ID: <20160820183338.33pcyfbtmwjulogk@john.keeping.me.uk>
References: <1471293727-26258-1-git-send-email-ayaka@soulik.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1471293727-26258-1-git-send-email-ayaka-xPW3/0Ywev/iB9QmIjCX8w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Randy Li <ayaka-xPW3/0Ywev/iB9QmIjCX8w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 16, 2016 at 04:42:06AM +0800, Randy Li wrote:
>   This patch could enabled the es8328 codec at firefly reload board,
> but it doesn't not really work. I disable the mute of channel 
> Left mix and Right mix in alsamixer, I could hear the noise from
> my headphone, but it never be a music. 
>   I just send this patch here to see whether somebody could figure
> out what is wrong, I am really not familiar with sound.

Have you tried adding an mclk-fs setting to the simple-audio-card?  You
probably want to set it to 256, which will allow 44.1kHz, 48kHz, 88.2kHz
and 96kHz at the codec.  This will give more functionality than pinning
the clock to a specific rate.

For the Rock2 Square, I write a machine driver for the sound because the
headphone GPIO setup cannot be made to work with simple-audio-card; I
found the Firefly Reload schematic and it looks like the configuration
hardware is very similar.  It's a bit of a mess but you can find it on
Github [1] if you want to take a look.

[1] https://github.com/johnkeeping/linux/tree/topic/audio
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
