From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [BUG] sound: soc: sunxi: sun4i-codec.c left control
 in right mixer
Date: Tue, 22 May 2018 21:55:57 +0200
Message-ID: <20180522195557.px34rkiifwig3jd6@flea>
References: <CAJnOVsnoPozDMJxjeErPE-OU6K8qipKSTPizsjOmgZo4CQcE1w@mail.gmail.com>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBWPLSHMAKGQERCRWK3I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAJnOVsnoPozDMJxjeErPE-OU6K8qipKSTPizsjOmgZo4CQcE1w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Markus Mitsch <markusmitsch86-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Sat, May 19, 2018 at 03:15:08PM +0200, Markus Mitsch wrote:
> in linux/sound/sunxi/sun4i-codec.c there is a control for the left
> channel in the section of routes for the right channel at line number
> 770. I dont know if this is wanted.

It is.

> And, i dont know if it is related, but to get sound out of my left
> speaker i have to MUTE the "Power Amplifier Mixer" channel with
> alsamixer.

On which board? with which kernel version? What configuration are you
setting?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
