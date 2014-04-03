From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 05/44] firewire-lib: Add support for MIDI
	capture/playback
Date: Thu, 03 Apr 2014 10:54:53 +0200
Message-ID: <533D21DD.10400@ladisch.de>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
 <1395400229-22957-6-git-send-email-o-takashi@sakamocchi.jp>
 <533C6510.7000605@ladisch.de> <533D1CF4.1040302@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 788EE265645
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 10:54:54 +0200 (CEST)
In-Reply-To: <533D1CF4.1040302@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Adrian Knoth <adi@drcomp.erfurt.thur.de>, jan.svitok@gmail.com
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
>>> +        len = b[0] - 0x80;
>>> +        if ((len > 1) &&  (3 < len) && (s->midi[port]))
>>
>> This condition is true only for len==2.
>
> Oh... It's my fault. I think I did focus on device's quirk for sequence of dbc value and didn't pay enough attension to these lines...
>
> In these lines I allow this module to pick up MIDI messages according to IEC 61883-6. 1/2/3 bytes can be transmitted. So it should be:
>
>  +        len = b[0] - 0x80;
>  +        if ((1 < len) &&  (len < 3) && (s->midi[port]))

This is still wrong.  It should be:

		len = b[0] - 0x80;
		if (1 <= len && len <= 3 && s->midi[port])


Regards,
Clemens
