From: Martin Tarenskeen <m.tarenskeen@zonnet.nl>
Subject: Re: [v7 PATCH] amidi: add sysex-interval option
Date: Wed, 14 Sep 2016 07:43:37 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1609140730140.7857@192.168.2.4>
References: <20160830160248.4595-1-eu@felipetonello.com>
 <ceba2296-1973-0a6f-aa1e-8c04b9f533f0@felipetonello.com>
 <84e1a053-73bc-392b-4348-73ed26734ab4@sakamocchi.jp>
 <dbdfd6ad-5586-f3dc-3950-85974f783bef@felipetonello.com>
 <bd1656a5-cb69-02d9-d449-0f93897b8124@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cpsmtpb-ews09.kpnxchange.com (cpsmtpb-ews09.kpnxchange.com
 [213.75.39.14]) by alsa0.perex.cz (Postfix) with ESMTP id 11FE0261740
 for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2016 07:43:44 +0200 (CEST)
In-Reply-To: <bd1656a5-cb69-02d9-d449-0f93897b8124@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, Felipe Ferreri Tonello <eu@felipetonello.com>
List-Id: alsa-devel@alsa-project.org



>>>>> +        "-i, --sysex-interval=mseconds   delay in between each SysEx

I really appreciate this new option. It's by no means useful only for 
firmware upgrades that's often mentioned in this thread. IMO that's a 
special case.

More common is that (older) synths expect a delay between SyxEx blocks to 
prevent "MIDI buffer full" type of messages on the synth's display. I have 
read in the manual of some Yamaha synths (can't remember which) a 
recommendation to use an interval of 10 ms. When I programmed YSEDITOR, a 
Yamaha synth editor/librarian in the old Atari days, I often used series 
of sysex messages simulating button presses to put the synth in a certain 
mode, before sending bulkdumps and parameter change messages. Some 
messages took more time inside the synth to be processed and I had to 
insert time intervals before I could send another message.

If I combine such a sequence of sysex messages in a single .syx file and 
use amidi to send the message, I will surely need the new -i parameter.

Apart from that, every sysex dump utility I have seen has a similar 
feature. MIDI-OX for Windows is probably the best known example.

So, thanks guys.

-- 

MT
