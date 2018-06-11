From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Order of device overrides in config files
Date: Mon, 11 Jun 2018 13:33:14 +0200
Message-ID: <fde2be1f-1e42-5e23-e1aa-77fb3e9a31bd@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id B1DD6266E91
 for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2018 13:33:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id 1D9F6A1A40B04
 for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2018 13:33:15 +0200 (CEST)
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EYGxw0Y61N3V for <alsa-devel@alsa-project.org>;
 Mon, 11 Jun 2018 13:33:15 +0200 (CEST)
Received: from [192.168.100.32] (unknown [192.168.100.32])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id 01C27A1A40B01
 for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2018 13:33:15 +0200 (CEST)
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

Hello,

Please in what order are devices specified in alsa conf overriden?

The  pcm.!default device is defined in /usr/share/alsa/pulse-alsa.conf. 
Also, I redefine this device in my .asoundrc. Strace dump shows my 
.asoundrc is loaded after /usr/share/alsa/pulse-alsa.conf. Yet the 
default device remains the pulse plugin.

Also, what is the exact meaning of the exclamation mark in the device name?

I very much appreciate any help.

Best regards,

Pavel.
