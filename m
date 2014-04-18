From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l51: Fix SOC_DOUBLE_R_SX_TLV
 shift values for ADC, PCM, and Analog kcontrols
Date: Fri, 18 Apr 2014 09:00:35 -0500
Message-ID: <alpine.DEB.2.02.1404180851570.9674@heelrod>
References: <1395243602-18012-1-git-send-email-brian.austin@cirrus.com>
 <20140417162625.21d072e7@skate> <alpine.DEB.2.02.1404171007510.9674@heelrod>
 <20140418112355.4c1fe3ac@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0088.outbound.protection.outlook.com [207.46.100.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E4ACC260376
 for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2014 16:00:07 +0200 (CEST)
In-Reply-To: <20140418112355.4c1fe3ac@skate>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, alsa-devel@alsa-project.org, paul.handrigan@cirrus.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, 18 Apr 2014, Thomas Petazzoni wrote:


> Simple mixer control 'Analog',0
>  Capabilities: pvolume
>  Playback channels: Front Left - Front Right
>  Limits: Playback 0 - 177
This is wrong

>  Mono:
>  Front Left: Playback 204 [115%] [0.00dB]
>  Front Right: Playback 204 [115%] [0.00dB]

root@beagleboard:~# amixer sget 'Analog'
Simple mixer control 'Analog',0
   Capabilities: pvolume penum
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 229
   Mono:
   Front Left: Playback 204 [89%] [0.00dB]
   Front Right: Playback 204 [89%] [0.00dB]

root@beagleboard:~# i2cdump -y -f 1 0x4b
No size specified (using byte-data access)
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 d9 7e ae 00 00 a0 00 60 44 00 00 00 00 84 84    .?~?..?.`D....??
10: 19 19 00 00 00 88 00 00 00 00 7f 00 01 3f 00 00    ??...?....?.??..
[...]

As you can see the output of amixer is wrong on your system. There are 229 
steps for gain on this control. At 89% we are at 0dB which is correct 
according to I2C Tools (0h)

root@beagleboard:~# amixer sset 'Analog' 0
Simple mixer control 'Analog',0
   Capabilities: pvolume penum
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 229
   Mono:
   Front Left: Playback 0 [0%] [-102.00dB]
   Front Right: Playback 0 [0%] [-102.00dB]
root@beagleboard:~# i2cdump -y -f 1 0x4b
No size specified (using byte-data access)
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 d9 7e ae 00 00 a0 00 60 44 00 00 00 00 84 84    .?~?..?.`D....??
10: 19 19 00 00 00 88 34 34 00 00 7f 00 01 3f 00 00    ??...?44..?.??..

-102dB gives the correct output and register writes as well. (34h)

My regmap output maps correctly too. Weird.

So lets get a few versions of some things to see what and where things 
went wrong.

What kernel version?
Alsa-lib version?
What distro are you using?

Thanks,
Brian
