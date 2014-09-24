From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/2] ALSA: hda - Sort input pins depending
 on amp caps
Date: Wed, 24 Sep 2014 08:33:17 +0200
Message-ID: <542265AD.1000005@canonical.com>
References: <1411461498-11837-1-git-send-email-david.henningsson@canonical.com>	<1411461498-11837-2-git-send-email-david.henningsson@canonical.com>
 <CAN8cciZHw69AfLJGKB-e7e=PAw7Jqx7bDmAvfVP=NUuw3xwdeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 23A69261A0A
 for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2014 08:33:19 +0200 (CEST)
In-Reply-To: <CAN8cciZHw69AfLJGKB-e7e=PAw7Jqx7bDmAvfVP=NUuw3xwdeQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2014-09-24 05:31, Raymond Yau wrote:
>  >
>  > If one input has a boost and another one has not, and they're equal
>  > otherwise, it's more likely you want to use the input with the boost
>  > as your primary input.
>  >
>  > See
> hda-emu.git/codecs/canonical/cx20590-lenovo-20b2z00bus-ccert-201305-13496
>  > for an example.
>
> Is this a firmware bug since your firmware 1.02 have two internal Mic
> 0x1e and 0x23 but firmware 1.09 only have one internal mic 0x23
>
> http://www.alsa-project.org/db/?f=a265ed3ac422c0ea77b0ada8596338c6421b4de1
>
> Cannot detect the codec with firmware 1.10
>
> http://www.alsa-project.org/db/?f=a60449e5a19b3dbb7a422defd5a9d51f56216693
>
> The proper fix is remove the redundant internal Mic since auto Mic is
> disabled

The E545 has dual-array mics, so probably both pins are actual internal 
mics.
It seems reasonable that upgrading the firmware would also resolve this 
problem, but either way I believe this is a good patch for potentially 
future codecs in the same situation.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
