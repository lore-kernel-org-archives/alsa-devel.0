From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 10/39] firewire-lib: Add transfer delay to
 synchronized duplex streams
Date: Tue, 11 Mar 2014 09:13:30 +0100
Message-ID: <531EC5AA.7090705@ladisch.de>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-11-git-send-email-o-takashi@sakamocchi.jp>
 <531CD97A.6040507@ladisch.de> <531DC17E.7020400@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 940C02610B7
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 09:13:33 +0100 (CET)
In-Reply-To: <531DC17E.7020400@sakamocchi.jp>
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
> (mar 10 2014 06:13), Clemens Ladisch wrote:
>> The frame in which the out-packet will be sent is QUEUE_LENGTH
>> frames later than that of the in-packet, so we need to adjust the
>> SYT by that amount.  (However, 48 % 16 == 0.)
>
> So basically we need to add nothing to SYT for out-packet.

It would be possible to do the QUEUE_LENGTH adjustment in the code and
rely on the compiler to optimize it away, but that would be silly.
OTOH a comment might be useful.


Regards,
Clemens
