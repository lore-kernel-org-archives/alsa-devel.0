From: "lei.ge@freescale.com" <lei.ge@freescale.com>
Subject: about ALSA subdevice
Date: Mon, 21 Jul 2014 09:51:44 +0000
Message-ID: <2afeac6fba8b4d83af93129c65f0dfd9@BLUPR03MB325.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 0341B265141
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 11:51:46 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dear ALSA-devel members,
I want to add subdevices to our ASoC drivers, for example:
card 0: imxesai [imxesai], device 0: imxesai PCM [imxesai PCM]
  Subdevices: 3/4
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
I saw BCM2835 use 8 subdevices in sound/arm/, but it is not standard ASoC driver.
What should I do  if I want to add subdevices in standard ASoC driver?
Can anyone show me an example?
Thanks!
Ge Lei 2014-7-21
