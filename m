From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: CIP Discontinuity with snd-firewire-digi00x
Date: Thu, 1 Sep 2016 21:58:31 +0900
Message-ID: <b0795c8d-dc78-e947-7e9a-689f186436f1@sakamocchi.jp>
References: <alpine.LNX.2.20.1606041726460.13950@anticlack.com>
 <57535D26.2080105@sakamocchi.jp>
 <alpine.LNX.2.20.1606041805260.17774@anticlack.com>
 <5753736F.6010902@sakamocchi.jp>
 <alpine.LNX.2.20.1606050916120.23467@anticlack.com>
 <5754AD09.3080807@sakamocchi.jp>
 <alpine.LNX.2.20.1608311949210.31059@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 7B3C0267333
 for <alsa-devel@alsa-project.org>; Thu,  1 Sep 2016 14:58:37 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.20.1608311949210.31059@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lin-alsa@noblejury.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 1 2016 09:52, lin-alsa@noblejury.com wrote:
> This issue went away for a while, sorry for the radio silence. I'm now
> running 4.4.17-rt25-1-rt-lts. I believe that the relevant driver was
> merged into mainline since then.

The firewire-digi00x module was exactly merged to Linux 4.4. See:
https://ieee1394.wiki.kernel.org/index.php/Release_Notes#Linux_4.4

> I've had a little more time to do some debugging, and I've discovered
> that the mixer connected light goes on and off a few times before
> turning off and requiring a hard reboot.

Hm. I have never experienced this kind of issue. For my information,
please show your OHCI 1394 host controller? Typically, 'lspci' is good
for this purpose.

For your information, I wrote 'hinawa-dg00x-cui' for this series of
units. It's in my repository in github.com:
https://github.com/takaswie/hinawa-utils

If you install libhinawa, gir1.2-hinawa-1.0, Python3 and PyGobject, the
command allows you to control your unit somewhat. For example, when you
change the mode of optical digital input interface, please run:
$ ./hinawa-dg00x-cui 1 optical-interface set ADAT

You can see all of sub-commands:
$ ./hinawa-dg00x-cui 1

And see parameters for each sub-commands just by run with the sub-command:
$ ./hinawa-dg00x 1 optical-interface

ALSA digi00x module still has several issues, but I think you have no
interests in it and don't address to it.


Regards

Takashi Sakamoto
