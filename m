From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 05/17] firewire-lib: Add support for AMDTP transmit stream
	and PCM capture
Date: Tue, 26 Nov 2013 20:17:15 +0900
Message-ID: <5294833B.2040308@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
	<1385186884-8259-6-git-send-email-o-takashi@sakamocchi.jp>
	<52936C65.9020602@ladisch.de> <52947CF1.3000004@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52947CF1.3000004@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

(Nov 26 2013 19:50), Takashi Sakamoto wrote:
>>> +    s->data_block_counter = (s->data_block_counter + data_blocks) &
>>> 0xff;
>>> +    if (s->data_block_counter != data_block_counter) {
>>> +        dev_err(&s->unit->device,
>>> +            "Detect uncontinuity of CIP packets\n");
>>> +        s->data_block_counter = data_block_counter;
>>> +        return;
>>> +    }
>>
>> The correct thing to do would be to insert the missing samples, or to
>> stop the stream.
>
> OK. But I remember there are some devices which transmits packets with
> 0x0000 in its SYT field (Digidesign 003 Rack, I don't touch its
> development.). So I want to remove these codes if possible.

Oops! I was confused between DBC and SYT. Digidesign 003 Rack transmits 
DBC correctly. Please forget my reply about this...

Here I think it better to insert the missing samples. Then just output 
information and continue to handle samples.


Thank you

Takashi Sakamoto


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
