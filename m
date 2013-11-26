From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 06/17] firewire-lib: Add support for MIDI
 capture/playback
Date: Tue, 26 Nov 2013 18:50:00 +0100
Message-ID: <5294DF48.6000804@ladisch.de>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
 <1385186884-8259-7-git-send-email-o-takashi@sakamocchi.jp>
 <52936C6F.1030200@ladisch.de> <52948E38.4090601@sakamocchi.jp>
 <52949BD5.6010601@ladisch.de> <5294D616.9020000@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C1E7C2610A9
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 18:50:48 +0100 (CET)
In-Reply-To: <5294D616.9020000@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> (Nov 26 2013 22:02), Clemens Ladisch wrote:
>> Takashi Sakamoto wrote:
>>> /*
>>>   * This module supports maximum 2 MIDI comformant data channels.
>>
>> Are there devices that use more than one?
>
> I know nothing. As long as I know, in BeBoB and Fireworks models, maximum number of 'MIDI comformant data channel' is 1 and 'maximum number of MPX-MIDI data channel' is 2.
>
> Should I limit the number of MIDI comformant data channel by 1?

If it makes the code simpler.


Regards,
Clemens
