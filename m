From: Doug McLain <doug@nostar.net>
Subject: ALSA Fireworks driver
Date: Fri, 17 Jun 2011 02:26:52 -0400
Message-ID: <4DFAF3AC.3030506@nostar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9304724407
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 08:27:58 +0200 (CEST)
Received: by iwc10 with SMTP id 10so2075220iwc.38
	for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2011 23:27:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

I came across your fireworks driver the other day, and would like to get 
involved.  Has there been any discussion on this anywhere or have you 
been completely on your own?  I did a search of alsa-devel and didn't 
find anything, suprisingly.  It seems like native alsa support of what 
seems to me to be the first FW device would be the talk of the town. :)

I built the driver as a module on F15 and loaded it on my AF12, and 
found it in /proc/asound/cards, and tried to start jack on it and it 
failed to start for duplex, capture, or playback, just FYI.

Doug
