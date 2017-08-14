From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: No Headphone Jack Audio from Lenovo Docking Station
 with a T470 connected
Date: Mon, 14 Aug 2017 12:00:21 +0200
Message-ID: <d336e939-cec1-e56f-ce8a-2cf1dab2b6dd@secunet.com>
References: <0ab67d57-7c49-d9c8-58df-c0aec7298d81@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B4BB267323
 for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2017 12:00:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by a.mx.secunet.com (Postfix) with ESMTP id 0B9E7201B1
 for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2017 12:00:18 +0200 (CEST)
Received: from a.mx.secunet.com ([127.0.0.1])
 by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YOCq-bGrYXnp for <alsa-devel@alsa-project.org>;
 Mon, 14 Aug 2017 12:00:16 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de
 [10.53.40.204])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by a.mx.secunet.com (Postfix) with ESMTPS id 4011E2018D
 for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2017 12:00:16 +0200 (CEST)
In-Reply-To: <0ab67d57-7c49-d9c8-58df-c0aec7298d81@secunet.com>
Content-Language: de-DE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

are there any news on this?

I tested pin cfg 0x17 0x21211010 too. In general it looks good, but I
can not hear anything.

Does anyone have some hints what can I do or test to get the sound
working on Dock HP?

Thanks,

Best regards,
Dennis

> Hello,
> 
> I'm unable to get any sound from the Headphone Jack of a Lenovo Ultra
> Docking Station with a new Lenovo T470 connected. With a T440p however I
> get sound from the Docking Station Headphone Jack.
> 
> I did some research on my alsa configuration and found out that there is
> no pin configuration supplied from the Laptop BIOS that connects to the
> Docking Headphone Jack.
> 
> The hdajacksensetest tool only shows this when the Laptop is docked and
> a Headphone is pluged in:
> Pin 0x18 (Black Mic, Left side): present = No
> Pin 0x21 (Black Headphone, Left side): present = No
> 
> So I did some patchingOn 14.08.2017 11:36, Stefan Mark (JIRA) wrote:
>  using a early firmware load patch floating around the web targeting the
> same docking station for my older T440p laptop:
> echo 0x17 0x21211010 > /sys/class/sound/hwC0D0/user_pin_configs
> echo 1 > /sys/class/sound/hwC0D0/reconfig
> 
> Now my Docking Station Headphone Jack is being detected! :)
> 
> With the Headphone Connected:
> Pin 0x17 (Black Headphone, Docking station, Rear side): present = Yes
> Pin 0x18 (Black Mic, Left side): present = No
> Pin 0x21 (Black Headphone, Left side): present = No
> 
> And disconnected:
> Pin 0x17 (Black Headphone, Docking station, Rear side): present = No
> Pin 0x18 (Black Mic, Left side): present = No
> Pin 0x21 (Black Headphone, Left side): present = No
> 
> However there is STILL no sound even after unmuting everything in alsamixer!
> I'm pretty sure 0x17 is the right pincfg but I'm not sure about
> 0x21211010 and how I obtain such an address for my laptop.
> 
> Could someone please help me out here or give me a hint?
> 
> Here is a alsa-info.sh dump when the Laptop is not connected to the Dock:
> https://pastebin.com/eTNnfnzL
> 
> And here when the Laptop is connected to the Dock (No changes):
> https://pastebin.com/ySBsKUeH
> 
> And here after setting the pin config 0x17 0x21211010:
> https://pastebin.com/xmDfsNtQ
> 
> I'm sure I'm very close. But something is still missing. Any help is
> much apprechiated!
> 
> Thanks in advance
> Dieter
> 
