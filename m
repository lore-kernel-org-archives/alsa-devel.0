From: Karl Grill <kgrill@chello.at>
Subject: Re: hdsp rpm support
Date: Sun, 18 Nov 2012 18:30:41 +0100
Message-ID: <1353259841.4990.8.camel@chello084112006029.chello.at>
References: <1326877559.24738.84.camel@yoyo4>
 <20120118102658.GA5351@linuxaudio.org>  <1349046242.2195.6.camel@yoyo5>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep19.mx.upcmail.net (fep19.mx.upcmail.net [62.179.121.39])
 by alsa0.perex.cz (Postfix) with ESMTP id 8280526508E
 for <alsa-devel@alsa-project.org>; Sun, 18 Nov 2012 17:53:32 +0100 (CET)
In-Reply-To: <1349046242.2195.6.camel@yoyo5>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roman Haefeli <reduzent@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,
I finally got my hands on my son's RPM+cardbus, and my results were
exactly the same as Roman's (timeout at the beginning of firmware
upload). With a bit of experimenting (imitating the windows driver), I
am now at stage where the firmware loads, but there are still some
quirks (I had to bypass the iobox recognition code, and I have to eject
the card and push it back in for it to work - well that is at least
better than having to boot into XP and back out). I'll post a patch when
these are fixed.

Regards
Karl
