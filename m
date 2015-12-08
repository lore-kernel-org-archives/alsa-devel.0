From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/3] fireface: add transaction support
Date: Tue, 8 Dec 2015 12:29:07 +0100
Message-ID: <5666BF03.7060102@ladisch.de>
References: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
 <1449408224-13955-3-git-send-email-o-takashi@sakamocchi.jp>
 <5666AF4E.9000100@ladisch.de> <5666BE1A.80304@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 8F40F266042
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 12:29:09 +0100 (CET)
In-Reply-To: <5666BE1A.80304@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> On Dec 08 2015 19:22, Clemens Ladisch wrote:
>> Takashi Sakamoto wrote:
>>> +		/* Calculate consume bytes. */
>>> +		consume = calculate_message_bytes(status);
>>> +		if (consume <= 0)
>>> +			return;
>>
>> As far as I can see, sending one of the "undefined" bytes can stop the
>> stream permanently.  Invalid bytes need to be acked to ignore/remove
>> them.
>
> Exactly. We should find better way to handle such messages. Do you have
> any good ideas?

Call snd_rawmidi_transmit_ack(, 1) and continue.


Regards,
Clemens
