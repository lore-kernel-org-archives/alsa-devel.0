From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 09/39] firewire-lib: Add sort function for
 transmitted packet
Date: Tue, 11 Mar 2014 09:11:34 +0100
Message-ID: <531EC536.5020201@ladisch.de>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-10-git-send-email-o-takashi@sakamocchi.jp>
 <531CD7F9.1000303@ladisch.de> <531DBE48.7040800@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 6EE962615FC
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 09:11:35 +0100 (CET)
In-Reply-To: <531DBE48.7040800@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> (Mar 10 2014 06:07), Clemens Ladisch wrote:
>>> This commit add sorting of in-packets. [...]
>>
>> Only a single packet is out of order, i.e., only two packets are exchanged.
>> So it is not necessary to run a general-purpose sorting algorithm; it would
>> be sufficient to store a single packet if it is out of order.
>
> I cannot prove 'there are only two packets are exchanged'. What I can
> prove is 'the sequence of packets includes a bit disorder'.

AFAIK this error happens only on some specific devices with some
specific (now outdated) firmware versions, and two exchanged packets is
all that is actually observed.  Furthermore, hardware implementations of
IEC 16883-6 construct packets in nearly real time and _cannot_ store
many packets.

Thus, I think it is extremely unlikely that we will ever see more than
two exchanged packets.

> I think keeping packet sequence is important to all of devices.

But there is no other device with a similar bug.  I think the driver
should keep the ability to detect dropped packets.


Regards,
Clemens
