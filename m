From: dmummenschanz@web.de
Subject: No Headphone Jack Audio from Lenovo Docking Station
 with a T470 connected
Date: Thu, 6 Apr 2017 20:35:56 +0200
Message-ID: <trinity-7e1753b3-8d85-4c8b-a080-af2f5ca4cbf3-1491503756451@3capp-webde-bap66>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A2EE26684C
 for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2017 20:35:57 +0200 (CEST)
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

Hello,

I'm unable to get any sound from the Headphone Jack of a Lenovo Ultra Docking Station with a new Lenovo T470 connected. With a T440p however I get sound from the Docking Station Headphone Jack.

I did some research on my alsa configuration and found out that there is no pin configuration supplied from the Laptop BIOS that connects to the Docking Headphone Jack.

The hdajacksensetest tool only shows this when the Laptop is docked and a Headphone is pluged in:
Pin 0x18 (Black Mic, Left side): present = No
Pin 0x21 (Black Headphone, Left side): present = No

So I did some patching using a early firmware load patch floating around the web targeting the same docking station for my older T440p laptop:
echo 0x17 0x21211010 > /sys/class/sound/hwC0D0/user_pin_configs 
echo 1 > /sys/class/sound/hwC0D0/reconfig

Now my Docking Station Headphone Jack is being detected! :)

With the Headphone Connected:
Pin 0x17 (Black Headphone, Docking station, Rear side): present = Yes
Pin 0x18 (Black Mic, Left side): present = No
Pin 0x21 (Black Headphone, Left side): present = No

And disconnected:
Pin 0x17 (Black Headphone, Docking station, Rear side): present = No
Pin 0x18 (Black Mic, Left side): present = No
Pin 0x21 (Black Headphone, Left side): present = No

However there is STILL no sound even after unmuting everything in alsamixer!
I'm pretty sure 0x17 is the right pincfg but I'm not sure about 0x21211010 and how I obtain such an address for my laptop.

Could someone please help me out here or give me a hint?

Here is a alsa-info.sh dump when the Laptop is not connected to the Dock:
https://pastebin.com/eTNnfnzL

And here when the Laptop is connected to the Dock (No changes):
https://pastebin.com/ySBsKUeH

And here after setting the pin config 0x17 0x21211010:
https://pastebin.com/xmDfsNtQ

I'm sure I'm very close. But something is still missing. Any help is much apprechiated!

Thanks in advance
Dieter
