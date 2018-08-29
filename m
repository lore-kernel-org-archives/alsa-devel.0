From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Adding DC offset to one channel in alsa config
Date: Wed, 29 Aug 2018 22:15:15 +0200
Message-ID: <fc7e6fe3-0421-76e0-2c84-c3bac338231a@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id DB53E2676BD
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2018 22:15:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id 8E9BBA1A40B05
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2018 22:15:25 +0200 (CEST)
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id niQsQUU5r9TB for <alsa-devel@alsa-project.org>;
 Wed, 29 Aug 2018 22:15:20 +0200 (CEST)
Received: from [192.168.105.12] (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id 0B9A9A1A40B01
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2018 22:15:20 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Please is there a way to add a fixed DC offset to one channel stream in 
alsa config (.asoundrc)?

We are playing with single-ended -> virtual balanced setup  ( 
http://www.diyaudio.com/forums/pc-based/326747-virtual-balanced-regular-soundcard-linux-results.html 
) using the route plugin. The setup works surprisingly nice.

Unless one of the input channel AD convertors has a DC offset which 
ruins the subtracted signal. It is easy to measure the offset.

Such as e.g.

type route
ttable {
		 0.0= 0.49 + 0.001
		 0.1= -0.49
	}


Thanks a lot for any suggestions.


Best regards,

Pavel.
