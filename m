From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 07/17] firewire-lib: give syt value to
	handle_out_packet()
Date: Tue, 26 Nov 2013 19:59:12 +0900
Message-ID: <52947F00.9010306@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
 <1385186884-8259-8-git-send-email-o-takashi@sakamocchi.jp>
 <52936C78.1050204@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 86CAB26509E
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 11:59:14 +0100 (CET)
In-Reply-To: <52936C78.1050204@ladisch.de>
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

(Nov 26 2013 00:27), Clemens Ladisch wrote:
>> +	for (i = 0; i < packets; ++i) {
>> +		syt = calculate_syt(s, ++cycle);
>>   		handle_out_packet(s, ++cycle);
>> +	}
>
> The syt is thrown away, and cycle is incremented twice.

Yes. This is my fault to create patches...

> ... I'll review the other patches later.

Thank you


Takashi Sakamoto
