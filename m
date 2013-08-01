From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: HBR audio with intel HDA
Date: Thu, 01 Aug 2013 19:37:48 +0300
Message-ID: <51FA8EDC.5040601@iki.fi>
References: <a7c323b2e500302c67f527c6b3b819e3@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
 [83.102.40.133])
 by alsa0.perex.cz (Postfix) with ESMTP id AD4352615CC
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 18:38:01 +0200 (CEST)
In-Reply-To: <a7c323b2e500302c67f527c6b3b819e3@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ashecrow42@free.fr
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, xingchao.wang@intel.com
List-Id: alsa-devel@alsa-project.org

01.08.2013 19:29, ashecrow42@free.fr kirjoitti:
> Hi there,

Hi!

> I have troubles using HBR audio (DTS-HD and Dolby TrueHD). With every 
> test, I get no signal in the AV receiver. I have tested using a dts-hd 
> encapsulated in spdif sample file (found there 
> http://samples.mplayerhq.hu/hdmi/) and commands bellow
> 
> - aplay -D hdmi devices
> - aplay -D hw devices
> - aplay -D plughw devices

You need to set the non-pcm bit in AES0. Use e.g. "-D hdmi:AES0=0x06".

> Note that I use ubuntu raring with 3.8 kernel that includes Xingchao's 
> HBR kernel patches.
> 
> 
> A. Configurations I have tested:
> 
> 
> - hda driver upgrade (alsa devel ubuntu team daily builds)
> 
> - upgrade alsa-lib & alsa-utils (alsa-testing launchpad)
> 
> - kernel upgrade to 3.9

IIRC 3.9 (or newer) may indeed be needed since you have both hdmi and spdif.

> - snd_hda_codec_realtek module backlist (to try to disable SPDIF) 
> /etc/modprobe.d/blacklist.conf
> 
> - snd_hda_codec_realtek index = -2 in /etc/modprobe.d/alsa-base.conf
> 
> - fresh new ubuntu raring install with no modifications at all: still 
> no signal
> 
> B. Info:
> 
> cat /proc/asound/card0/codec* | grep Codec
> Codec: Realtek ALC892
> Codec: Intel CougarPoint HDMI
> 
> I use zotac ZBOX ID82 (intel HM65 chipset with hdmi and spdif)
> 
> with alsa debug and alsa debug verbose enabled in kernel I got the 
> alsa-info.txt attached file produced on raring with no modification 
> while playing dts-hd sample file with command:
> 
> 
> aplay -D hdmi:CARD=PCH,DEV=0 -c8 -fs16_le -r192000 dts.spdif

As per above you need to use
aplay -D hdmi:CARD=PCH,DEV=0,AES0=0x06 -c8 -fs16_le -r192000 dts.spdif

> 
> C. I add that:
> 
> - In every test I have non HD audio protocols (DTS and dolby) working 
> well in the same configuration
> 
> - I have tried with windows just to see if my hardware is broken and I 
> get DTS-HD audio with no problem
> 
> - Takashi, I've read your HD-Audio.txt file and as far as I see, I have 
> no known error message in kernel log
> 
> 
> => I and Wingchao Wang have conclued that it is driver or codec 
> related. Can you help me please?
> 
> Thanks a lot
> PS: sorry if you receive this email twice, I have sent it again as I 
> was not member of the list the first time.


-- 
Anssi Hannula
