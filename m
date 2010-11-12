From: Dan Christensen <jdc@uwo.ca>
Subject: Re: wrong channel mappings for HDMI audio
Date: Fri, 12 Nov 2010 08:16:02 -0500
Message-ID: <8762w2of71.fsf@uwo.ca>
References: <87fwv8puuo.fsf@uwo.ca> <4CDB941A.7020606@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 147E7103932
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 14:16:15 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PGtUD-0008JD-Pv
	for alsa-devel@alsa-project.org; Fri, 12 Nov 2010 14:16:13 +0100
Received: from bas3-london14-1096778080.dsl.bell.ca ([65.95.129.96])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 14:16:13 +0100
Received: from jdc by bas3-london14-1096778080.dsl.bell.ca with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 14:16:13 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch <clemens@ladisch.de> writes:

> Dan Christensen wrote:
>> When I try to use 5.1 audio over HDMI, the front left and front right
>> channels are correct, but the others are wrong:
>> ...
>> asound.conf:
>> 
>> pcm.!default {
>> type hw
>> card 0
>> device 3
>> }
>
> With this definition, you are disabling ALSA's channel mapping.
...
> or just tell you applications to use the device "hdmi".

I get exactly the same problem if I do

  speaker-test -c6 -twav -Dhdmi

Any other suggestions?

Dan
