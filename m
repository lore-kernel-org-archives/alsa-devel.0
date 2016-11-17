From: Frederique <auspicious@inventati.org>
Subject: Sound Blaster Z works but ports are a mess
Date: Thu, 17 Nov 2016 10:01:51 +0100
Message-ID: <528fa7f8-051e-83c5-3e84-437317f3ead5@inventati.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fragranza.investici.org (fragranza.investici.org
 [178.175.144.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 39B402614A0
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2016 10:01:52 +0100 (CET)
Received: from [178.175.144.26] (fragranza [178.175.144.26]) (Authenticated
 sender: auspicious@inventati.org) by localhost (Postfix) with ESMTPSA id
 DDE932C00CC
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2016 09:01:51 +0000 (UTC)
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

Dear mailing list individuals,

I currently own a Sound Blaster Z from Creative. Testing on Linux Mint 
18 64-bit with the stock Linux 4.4 kernel, ALSA 1.0.25+dfsg-0ubuntu5 and 
ALSA utilities 1.1.0-0ubuntu5.

Output only works from the front panel headphone port when HP/Speaker is 
enabled. All audio enhancements available work as well.

Input only works via the microphone port on the card itself, and all 
audio enhancements like voice clarity and voice transformation work as well.

It seems only the ports are a mess. I do not know how to do any audio 
driver development so I not sure if it would require a lot of work to fix.

Does the team have any of these cards? They come in Z, Zx and ZxR 
editions, with the last card being significantly different port-wise. 
Would it help if this hardware would be donated possibly by Creative 
themselves?

A screenshot of alsamixer: http://i.imgur.com/OosqrER.png

Currently I only have the headset connected to the front panel 
headphones port as I am awaiting an extension cable to arrive to be able 
to connect it to the microphone port in the back.

A user called voron00 has been attempting development for the card 
series if it might help at all: 
http://forums.creative.com/showthread.php?t=741501

Sincerely yours,
Frederique
