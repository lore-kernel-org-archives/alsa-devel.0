From: Xuebing Wang <xbing6@gmail.com>
Subject: [USB UAC2] How to route pcm stream for UAC2 virtual
 sound card for lowest latency?
Date: Tue, 10 Mar 2015 16:27:33 +0800
Message-ID: <54FEAAF5.1090306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f51.google.com (mail-qg0-f51.google.com
 [209.85.192.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 45A30261548
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 09:27:37 +0100 (CET)
Received: by qgdq107 with SMTP id q107so5226qgd.6
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 01:27:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, richard Jiang <Richard.Jiang@infocus.com>, niranjan Patil <Niranjan.Patil@infocus.com>
List-Id: alsa-devel@alsa-project.org

Hi Community,

I am developing a commercial product based on Freescale iMX6SL + UAC2.

I can get UAC2 working for below command. 'hw:1,0' is the virtual sound 
card. 'hw:0,0' is the physical sound card.
export RATE=44100; arecord -D hw:1,0 -c 2 -r $RATE -f S16_LE | aplay -c 
2 -r $RATE -f S16_LE &

Any suggestions on what is the best way to get PCM stream from UAC2 
virtual sound card and feed to the physical sound card, for the lowest 
latency purpose?

Thanks.

-- 
Xuebing
