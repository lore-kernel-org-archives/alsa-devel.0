From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [USB UAC2] How to route pcm stream for UAC2
	virtual	sound card for lowest latency?
Date: Tue, 10 Mar 2015 09:30:45 +0100
Message-ID: <54FEABB5.8060905@ladisch.de>
References: <54FEAAF5.1090306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 7A693261557
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 09:30:47 +0100 (CET)
In-Reply-To: <54FEAAF5.1090306@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xuebing Wang <xbing6@gmail.com>, alsa-devel@alsa-project.org, richard Jiang <Richard.Jiang@infocus.com>, niranjan Patil <Niranjan.Patil@infocus.com>
List-Id: alsa-devel@alsa-project.org

Xuebing Wang wrote:
> I am developing a commercial product based on Freescale iMX6SL + UAC2.
>
> I can get UAC2 working for below command. 'hw:1,0' is the virtual sound card. 'hw:0,0' is the physical sound card.
> export RATE=44100; arecord -D hw:1,0 -c 2 -r $RATE -f S16_LE | aplay -c 2 -r $RATE -f S16_LE &
>
> Any suggestions on what is the best way to get PCM stream from UAC2
> virtual sound card and feed to the physical sound card?

This will not work unless the clocks of the virtual sound card (i.e.,
the USB bus clock) and the clock of the actual sound device are
synchronized.

Otherwise, you have to write your own UAC2 driver.


Regards,
Clemens
