From: Cyril Hrubis <metan.lists@gmail.com>
Subject: TASCAM US-122mkII
Date: Fri, 19 Aug 2011 12:01:56 +0200
Message-ID: <20110819100156.GA31665@yumi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7CAA2245D4
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 12:01:54 +0200 (CEST)
Received: by bkar19 with SMTP id r19so2153700bka.38
	for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2011 03:01:54 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi!
The good news is that I have 122mkII to play with, the bad news is that
it doesn't work with the snd_usb_122l driver.

The probe function fails most likely in usb_stream_start(&us122l->sk),

The dmesg output:

...
status=-2
status=-2
us122l_start error -14
snd-usb-us122l: probe of 1-2:1.1 failed with error -22
usbcore: registered new interface driver snd-usb-us122l
...

I've set up a windows machine with usbsnoop and captured the init log (I
could upload it somewhere if anybody is interested). I would probably be
able to help fix/write the driver with some guidance. Just now I'm
trying to understand the log...

PS: I've send this mail to alsa-devel a couple of days ago, but without
    being subscribed, does anybody do the screening on incomming mails?

-- 
Cyril Hrubis
