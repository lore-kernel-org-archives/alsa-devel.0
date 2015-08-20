From: Karsten Heymann <karsten.heymann@gmail.com>
Subject: Boss Micro BR-80 not workin
Date: Thu, 20 Aug 2015 23:46:37 +0200
Message-ID: <CAL017hBX6t9J-qqhmp4nKjt0++QoE_hhXdddWr+SqVEskKQMBQ@mail.gmail.com>
References: <CAL017hDWjsj3kCYmpugFqf0S9G_4_BoWYiaKzaO0CWyTvDNmfA@mail.gmail.com>
 <CAL017hCpHxFCLWDHm=k30W26_pJgkeYiyiAgi10cDdYdmp1DEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f180.google.com (mail-lb0-f180.google.com
 [209.85.217.180])
 by alsa0.perex.cz (Postfix) with ESMTP id A5063265388
 for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2015 23:46:38 +0200 (CEST)
Received: by lbbpu9 with SMTP id pu9so32426014lbb.3
 for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2015 14:46:38 -0700 (PDT)
In-Reply-To: <CAL017hCpHxFCLWDHm=k30W26_pJgkeYiyiAgi10cDdYdmp1DEw@mail.gmail.com>
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

I'm trying to get my Boss Micro BR-80 (id 0582:0130) usb device to work.
The device is detected, but with my limited knowledge of the alsa basics i
could not get any audio in or out of it, pulse audio and jack don't seem to
work too. I'm not a kernel hacker, but hope to be helpful with providing
output, testing patches and if necessary providing ssh access to a system
with this device attached to a more knowledgeable developer.

There used to be dedicated quirk code in sound/usb/quirk-table.h which was
removed in
http://thread.gmane.org/gmane.linux.alsa.devel/109660/focus=111768 during a
roland module update. Older postings on the net indicate that the br-80
seem to have worked in the past.

My questions:
* which command outputs do you need to debug this?
* should compiling an older version of the snd-usb module for a current
kernel work?

Regards,
Karsten
