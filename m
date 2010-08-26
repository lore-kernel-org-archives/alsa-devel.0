From: Keith Chew <keith.chew@gmail.com>
Subject: Re: 5.1 surround on 3 jacks (retasking)
Date: Fri, 27 Aug 2010 11:19:50 +1200
Message-ID: <AANLkTimRwKPFohM46pOKXDmGbcbnCuGWX1VwwcGbk+6o@mail.gmail.com>
References: <AANLkTin3DKSRuUZwARAadMTVPTrj17eHK8557bCsb3YM@mail.gmail.com>
	<4C75A7D9.1030604@canonical.com>
	<AANLkTinE8sjRWWsHYJYq1w_rLJu9Y91J4gs7k-Q_M3j-@mail.gmail.com>
	<4C76100C.3040205@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D8D4E24492
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 01:19:51 +0200 (CEST)
Received: by iwn4 with SMTP id 4so1968213iwn.38
	for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2010 16:19:50 -0700 (PDT)
In-Reply-To: <4C76100C.3040205@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> I'm not 100% sure, but I think that HDA-analyzer approach will probably
> not work here as you'll need a complete codec reconfig. After the
> reconfig, you shouldn't even have a "Line in" in alsamixer, instead you
> should have volume controls for "rear" and "center/lfe".
> Also make sure that the pin configs are configured as "front", "rear",
> and "center/lfe".
>

Hi David

It is now working! I couldn't find documentation on how to determine
the correct pin config values, but found in patch_realtek.c the values
for rear, clfe and front. So, I executed this:

echo 0x14 0x01014510 > /sys/class/sound/hwC0D2/user_pin_configs
echo 0x19 0x01011012 > /sys/class/sound/hwC0D2/user_pin_configs
echo 0x1b 0x01016011 > /sys/class/sound/hwC0D2/user_pin_configs
echo 1 > /sys/class/sound/hwC0D2/reconfig

And 6 channels is now working perfectly. I have also tried the early
patch method, and that works too!

Thanks again for all your help.

Regards
Keith
