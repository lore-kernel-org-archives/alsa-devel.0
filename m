From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Help requested: new HSS1394 MIDI back-end
Date: Tue, 24 Jul 2012 13:44:30 +0200
Message-ID: <500E8A9E.6050604@ladisch.de>
References: <4FBFE0D5.8030501@mixxx.org> <4FC23123.8000702@ladisch.de>
 <4FC295AD.1030901@mixxx.org> <4FC3929F.4050304@ladisch.de>
 <4FC3E2AD.70802@mixxx.org> <4FC501DA.3050900@ladisch.de>
 <4FC5451A.9000107@mixxx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id D518C265264
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 13:44:30 +0200 (CEST)
In-Reply-To: <4FC5451A.9000107@mixxx.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Sean M. Pappalardo - D.J. Pegasus" <spappalardo@mixxx.org>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I wrote:
> I wrote:
>> Sean M. Pappalardo - D.J. Pegasus wrote:
>>> I also see an F9 message slip through once in awhile according to amidi -d:
>>
>> The driver currently assumes that there is exactly one MIDI message per
>> packet.  It appears that this is not true, and if F9 and real MIDI
>> commands are mixed in one packet, the result is not correct.
>
> New patch below.

Ping?  Does it work?  Wouldn't it be time to move it into the kernel?
Would you be OK with this tag on the patch?
  Tested-by: Sean M. Pappalardo - D.J. Pegasus <spappalardo@mixxx.org>


Regards,
Clemens
