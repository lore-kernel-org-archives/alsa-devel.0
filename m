From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 06/17] firewire-lib: Add support for MIDI
	capture/playback
Date: Wed, 27 Nov 2013 02:10:46 +0900
Message-ID: <5294D616.9020000@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
 <1385186884-8259-7-git-send-email-o-takashi@sakamocchi.jp>
 <52936C6F.1030200@ladisch.de> <52948E38.4090601@sakamocchi.jp>
 <52949BD5.6010601@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BD0E2610A1
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 18:10:55 +0100 (CET)
In-Reply-To: <52949BD5.6010601@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

(Nov 26 2013 22:02), Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> In my understanding of RP-027:
>> 'MIDI data stream' is a data stream to/from each MIDI ports
>> 'MPX-MIDI data channel' is a data channel for each 'MIDI data stream'
>> 'MIDI comformant data channel' has multiplexed 8 'MPX-MIDI data channel's
>
> Yes.

OK. Here I use 'midi_channels' as 'MIDI comformant data channels' for 
struct amdtp_stream.

>> /*
>>   * This module supports maximum 2 MIDI comformant data channels.
>
> Are there devices that use more than one?

I know nothing. As long as I know, in BeBoB and Fireworks models, 
maximum number of 'MIDI comformant data channel' is 1 and 'maximum 
number of MPX-MIDI data channel' is 2.

Should I limit the number of MIDI comformant data channel by 1?


Thank you

Takashi Sakamoto
