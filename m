From: "S. Christian Collins" <s.chriscollins@gmail.com>
Subject: X-Fi Titanium S/PDIF output sample rate
Date: Mon, 07 Mar 2011 10:32:26 -0600
Message-ID: <4D75089A.3020609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D865244C8
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 17:32:30 +0100 (CET)
Received: by iwc10 with SMTP id 10so4469103iwc.38
	for <alsa-devel@alsa-project.org>; Mon, 07 Mar 2011 08:32:29 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have two sound cards in my system, a Sound Blaster X-Fi Titanium 
(PCI-Express) and an Echo Gina 3G, with the optical output from the X-Fi 
connected to the optical input on the Gina 3G.  I'm looking for a way to 
change the S/PDIF output sample rate on the X-Fi to 48 KHz.  I've tried 
using iecset, but none of the commands change any of the values reported 
by iecset.  Here is the output from iecset:

Mode: consumer
Data: audio
Rate: 48000 Hz
Copyright: protected
Emphasis: none
Category: PCM coder
Original: original
Clock: 1000 ppm

Now, here's the weird thing: even though iecset reports the X-Fi S/PDIF 
rate at 48 KHz, my Echo Gina 3G seems to pick up the stream as 96 KHz 
instead, ie. the Gina 3G becomes "locked" at 96 KHz upon activating its 
S/PDIF input and getting its clock from the optical stream.

I noticed in the Windows driver that the X-Fi's internal sampling rate 
can be adjusted in the driver setting (44.1, 48, 88.2, 96), but the 
S/PDIF rate can't be adjusted.  Instead, the X-Fi's S/PDIF rate seems to 
be locked to the internal sampling rate.

So, it appears that I may need to adjust the X-Fi's internal sampling 
rate somehow, but I have no idea how to do this.  Does anybody know if 
this can even be done?

-~Chris
