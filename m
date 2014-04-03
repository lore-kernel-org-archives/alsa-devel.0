From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 05/44] firewire-lib: Add support for MIDI
	capture/playback
Date: Thu, 03 Apr 2014 17:33:56 +0900
Message-ID: <533D1CF4.1040302@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
 <1395400229-22957-6-git-send-email-o-takashi@sakamocchi.jp>
 <533C6510.7000605@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DB85265653
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 10:41:19 +0200 (CEST)
In-Reply-To: <533C6510.7000605@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Adrian Knoth <adi@drcomp.erfurt.thur.de>, jan.svitok@gmail.com
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Clemens, Adrian and Jano,

>> +		len = b[0] - 0x80;
>> +		if ((len > 1) &&  (3 < len) && (s->midi[port]))
>
> This condition is true only for len==2.

Oh... It's my fault. I think I did focus on device's quirk for sequence 
of dbc value and didn't pay enough attension to these lines...

In these lines I allow this module to pick up MIDI messages according to 
IEC 61883-6. 1/2/3 bytes can be transmitted. So it should be:

  +		len = b[0] - 0x80;
  +		if ((1 < len) &&  (len < 3) && (s->midi[port]))


Thank you


Takashi Sakamoto
o-takashi@sakamocchi.jp
