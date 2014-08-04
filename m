From: thomas schorpp <thomas.schorpp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ARM: sun7i: Fix HDMI Audio driver's Alsa
 interface and do 8CH IEC60958 output
Date: Mon, 04 Aug 2014 02:15:33 +0200
Message-ID: <53DED0A5.1090009@gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDYY3S6C5QNBBKNB7OPAKGQEBMRI2RQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Version 0.2

Users doc:

All You need to get a HDMI- Pulseaudio Server on Your sunxi board to output Multichannel PCM is this line in default.pa, ttable pcms in asound.conf get ignored:

+load-module module-alsa-sink device="hw:1,0" channels=8 channel_map="front-left,front-right,lfe,front-center,rear-left,rear-right,side-left,side-right"

### Automatically load driver modules depending on the hardware available
.ifexists module-udev-detect.so
load-module module-udev-detect

Probe with speaker-test, You may need other channel mapping than I.

If you run PA in system mode please read the security documentation before, see PA log for link.

y
tom
