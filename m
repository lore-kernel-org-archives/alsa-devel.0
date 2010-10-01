From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsactl adds volume controls?
Date: Fri, 01 Oct 2010 09:19:02 +0100
Message-ID: <4CA59976.2020306@colin.guthr.ie>
References: <s5hr5hczi06.wl%tiwai@suse.de>	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>	<i7viav$kjb$1@dough.gmane.org>	<4CA46E98.10402@ladisch.de>	<4CA4A844.7060403@colin.guthr.ie>	<20100930164753.GB9431@sirena.org.uk>	<s5hr5gb9k83.wl%tiwai@suse.de>
	<4CA5834D.5030408@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 269B21039E2
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 10:19:17 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P1apm-00035F-33
	for alsa-devel@alsa-project.org; Fri, 01 Oct 2010 10:19:14 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 01 Oct 2010 10:19:14 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 01 Oct 2010 10:19:14 +0200
In-Reply-To: <4CA5834D.5030408@ladisch.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Clemens Ladisch at 01/10/10 07:44 did gyre and gimble:
> Takashi Iwai wrote:
>> Mark Brown wrote:
>>> On Thu, Sep 30, 2010 at 04:09:56PM +0100, Colin Guthrie wrote:
>>>> *shouldn't* use them, but at present it does and they *are* active and
>>>> used, so it's not an issue for me), the problem is rather one of setting
>>>> Master (not PCM) to 0% aka -46.5dB causes some kind of auto-mute that
>>>> cuts off all sound. It shouldn't do that.
>>>
>>> Is this perhaps just an error in the TLV information - should it be
>>> flagging that the minimim gain is mute but isn't?
>>
>> There is no clear (or consistent) definition in HD-audio codec, I guess.
> 
> The HDA spec is quite clear that muting is done only with the mute bit.

Good :)

>> Some chips do mute at 0 and some not.
> 
> Those that do are violating the specification.
> 
> But we have to support them anyway.
> Colin, please tell us the IDs of your codec so that we can add a TLV
> workaround to the driver.

I presume the alsa-info.sh output is sufficient here?

http://colin.guthr.ie/alsa-info.txt

snd_hda_intel   : Intel Corporation|82801G (ICH7 Family) High Definition
Audio Controller (vendor:8086 device:27d8 subv:1028 subd:01bd) (rev: 01)


Many thanks

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
