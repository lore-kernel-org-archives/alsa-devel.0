From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsactl adds volume controls?
Date: Thu, 07 Oct 2010 00:29:59 +0100
Message-ID: <i8j0pn$308$1@dough.gmane.org>
References: <s5hr5hczi06.wl%tiwai@suse.de>
	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>	<i7viav$kjb$1@dough.gmane.org>
	<4CA46E98.10402@ladisch.de>	<4CA4A844.7060403@colin.guthr.ie>	<20100930164753.GB9431@sirena.org.uk>	<s5hr5gb9k83.wl%tiwai@suse.de>
	<4CA5834D.5030408@ladisch.de>	<AANLkTi=zwH4CK+=eC-NaY+wTy-W90HiBFp7Vk67xN0Wk@mail.gmail.com>	<i8cecd$gge$1@dough.gmane.org>
	<AANLkTi=9yMV8FrQJpZdEjW2tv4+xdujJaRBzRG7Zp+T9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 68D781039B8
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 01:30:11 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P3dR0-0005BD-To
	for alsa-devel@alsa-project.org; Thu, 07 Oct 2010 01:30:06 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 07 Oct 2010 01:30:06 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 07 Oct 2010 01:30:06 +0200
In-Reply-To: <AANLkTi=9yMV8FrQJpZdEjW2tv4+xdujJaRBzRG7Zp+T9@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 06/10/10 01:05 did gyre and gimble:
> 2010/10/4 Colin Guthrie <gmane@colin.guthr.ie>
>> Just for clarity, the 0 -> -51dB range is for the PCM control (i.e.
>> softvol) only. The Master control gives me -46.5dB in addtiion to that
>> giving a total of -97.5dB. This still isn't as high as the -120dB you
>> are mentioning, but it's a lot closer.
>>
>> Of course I am lucky in that my Master apparently works fine but for
>> those souls without any Master control, I presume the full range should
>> be offered by the PCM softvol?
>>
>> Col
>>
>>
> Did it happen on both channels or only left channel ?
> 
> The workaround mentioned in errata is to lock the sample rate

Did what happen? I was talking about dB ranges, not an event.

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
