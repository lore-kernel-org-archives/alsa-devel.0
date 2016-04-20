From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: A&H Zed R16 not completely working (DICE Jr)
Date: Thu, 21 Apr 2016 00:21:53 +0900
Message-ID: <57179E91.1070202@sakamocchi.jp>
References: <CA+aoAJc6JQvy_yk-5HJZpqv5GW6DygdmLB5=HGyW9q3yn12mKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 395B7261B0A
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 17:22:01 +0200 (CEST)
In-Reply-To: <CA+aoAJc6JQvy_yk-5HJZpqv5GW6DygdmLB5=HGyW9q3yn12mKA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Allan Klinbail <aklinbail@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Apr 20 2016 23:31, Allan Klinbail wrote:
> Using kernel 4.4.0 from Ubuntu
> 
> The ALSA driver limited the device to only 16 inputs and outputs, however
> it has a total capability of 26
> This is comprises of 16 inputs and outputs on the desk channels, a stereo
> main pair of outputs and inputs for the master bus
> 8 additional ins and outs to support the ADAT ports on the back (availoable
> in 44.1 and 48 khz modes, but not 88.2 or 96 Khz

This is fixed in Linux kernel 4.6.
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105462.html

The backported codes are available in my private repository. After
installing, You can see two PCM character devices to handle these PCM
channels.
https://github.com/takaswie/snd-firewire-improve

To clarify the capabilities of your model, please show me output of proc
node, like

$ cat /proc/asound/card1/dice
sections:
  global: offset 10, size 95
  tx: offset 105, size 142
...


Regards

Takashi Sakamoto
