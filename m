From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/2] Add MIDI stream support with data rate
 restriction
Date: Wed, 05 Jun 2013 16:38:39 +0200
Message-ID: <51AF4D6F.1030406@ladisch.de>
References: <1370100337-22463-1-git-send-email-o-takashi@sakamocchi.jp>
 <1370100337-22463-3-git-send-email-o-takashi@sakamocchi.jp>
 <51AC51D7.1040806@ladisch.de> <51AF24A7.9010005@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 445E32654BB
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 16:38:49 +0200 (CEST)
In-Reply-To: <51AF24A7.9010005@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
>> This comment might be misleading.  There is no such "negotiation
>> procedure"; RP27 mentions this only to allow for future extension.
>
> Here I can't find such a specification that define this "negotiation
> procedure".

No such procedure has ever been designed.
(Probably the bandwidth is large enough anyway.)

>> snd_rawmidi_receive() already reports errors; you can just ignore its
>> return value.
>
> I understand you mean "ALSA core prints debug message if
> snd_rawmidi_receive() failed so you don't need to check return value."

Yes.


Regards,
Clemens
