From: "'Markus Mitsch' via linux-sunxi" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Subject: [BUG] sound: soc: sunxi: sun4i-codec.c left control in
 right mixer
Date: Sat, 19 May 2018 15:15:08 +0200
Message-ID: <CAJnOVsnoPozDMJxjeErPE-OU6K8qipKSTPizsjOmgZo4CQcE1w@mail.gmail.com>
Reply-To: markusmitsch86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDSJZK6URQGRBZ6ZQDMAKGQEC6DXGBA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi,

in linux/sound/sunxi/sun4i-codec.c there is a control for the left
channel in the section of routes for the right channel at line number
770. I dont know if this is wanted.

And, i dont know if it is related, but to get sound out of my left
speaker i have to MUTE the "Power Amplifier Mixer" channel with
alsamixer.

Regards
