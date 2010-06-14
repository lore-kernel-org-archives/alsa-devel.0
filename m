From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: wrong decibel data?
Date: Mon, 14 Jun 2010 11:17:00 +0100
Message-ID: <hv4vhb$84a$1@dough.gmane.org>
References: <htls4d$phr$1@dough.gmane.org>
	<4BFE7840.4070004@ladisch.de>	<htm0et$eb4$1@dough.gmane.org>
	<htm9mn$n1c$1@dough.gmane.org>	<AANLkTinK1xWFSpudCrdHwfgnaGyMEn41DY0VGakJlHX6@mail.gmail.com>	<huicj9$t30$1@dough.gmane.org>	<AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>	<hulnlp$m00$1@dough.gmane.org>	<AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>	<hur2pt$uaa$1@dough.gmane.org>	<20100613135349.GB5818@tango.0pointer.de>	<AANLkTimwvTxPe66fk4hq2-eiky-8Yqd12vN6WYkh9qdQ@mail.gmail.com>	<hv4pfi$gqr$3@dough.gmane.org>
	<AANLkTikknwiaVOWUwtWsiNOc0j3VtG3YMEMkRO1o2w2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 83F9A24689
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jun 2010 12:16:22 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OO6iL-000763-H1
	for alsa-devel@alsa-project.org; Mon, 14 Jun 2010 12:16:21 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2010 12:16:21 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2010 12:16:21 +0200
In-Reply-To: <AANLkTikknwiaVOWUwtWsiNOc0j3VtG3YMEMkRO1o2w2f@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 14/06/10 09:45 did gyre and gimble:
> 2010/6/14 Colin Guthrie <gmane@colin.guthr.ie>
> 
>> 'Twas brillig, and Raymond Yau at 14/06/10 01:25 did gyre and gimble:
>>> if your sound card have ac97 codec ., you can use audacity to record the
>>> output from hw:0,0 and you will see clipping occur when you set "PCM"
>> volume
>>> above 0dB
>>
>> So the standard response is "don't do that then" :)
>>
>> That's why the base volume is shown to the user via GUIs so that they
>> can gauge the best point on the slider to use. Currently there is no
>> indication with alsa sliders at which point the 0dB "sweet spot" lies.
>>
>> IMO this is a good improvement for usability.
>>
>> Col
>>
> 
> 
> The correct way is to provide the real ALSA 's 0dB point (Playback volume)
> for the user of AC97 sound card so that they can record without any
> distortion using line in with the loopback cable connected to line out.

Raymond, can you please, please stop replying to messages multiple
times. It makes threads extremely hard to follow and makes replying to
your points consistently next to impossible.


>From Lennarts description, the 0dB point (according to alsa) IS the base
volume and thus is shown to the user as such. Am I missing something?

The fact that the 0dB point is shifted is fairly irrelevant to the user.

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
