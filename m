From: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH V3 3/4] ASoC: tas571x: New driver for TI TAS571x power amplifiers
Date: Mon, 4 May 2015 06:51:32 -0700
Message-ID: <CAJzqFtYm6W40B05DG5yfa5iOaUo3ShJOm6AXcOQ1ehUOG0yO6A@mail.gmail.com>
References: <1430697619-22773-1-git-send-email-cernekee@chromium.org>
 <1430697619-22773-4-git-send-email-cernekee@chromium.org> <20150504114558.GD15510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150504114558.GD15510-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, May 4, 2015 at 4:45 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Sun, May 03, 2015 at 05:00:18PM -0700, Kevin Cernekee wrote:
>> +     if (dev->of_node) {
>> +             const struct of_device_id *of_id;
>> +
>> +             of_id = of_match_device(tas571x_of_match, dev);
>> +             if (of_id)
>> +                     priv->chip = of_id->data;
>> +     }
>
> Doesn't of_match_device() do the right thing with devices not registered
> from DT?

Not sure.  What kinds of situations are you concerned about?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
