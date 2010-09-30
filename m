From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsactl adds volume controls?
Date: Thu, 30 Sep 2010 19:20:21 +0100
Message-ID: <4CA4D4E5.4080806@colin.guthr.ie>
References: <s5hr5hczi06.wl%tiwai@suse.de>
	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>	<i7viav$kjb$1@dough.gmane.org>
	<4CA46E98.10402@ladisch.de>	<4CA4A844.7060403@colin.guthr.ie>	<20100930164753.GB9431@sirena.org.uk>
	<s5hr5gb9k83.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 82C1910394E
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 20:20:31 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P1Nk5-0004eS-Mq
	for alsa-devel@alsa-project.org; Thu, 30 Sep 2010 20:20:29 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2010 20:20:29 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2010 20:20:29 +0200
In-Reply-To: <s5hr5gb9k83.wl%tiwai@suse.de>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Takashi Iwai at 30/09/10 19:09 did gyre and gimble:
> At Thu, 30 Sep 2010 17:47:53 +0100,
> Mark Brown wrote:
>>
>> On Thu, Sep 30, 2010 at 04:09:56PM +0100, Colin Guthrie wrote:
>>
>>> *shouldn't* use them, but at present it does and they *are* active and
>>> used, so it's not an issue for me), the problem is rather one of setting
>>> Master (not PCM) to 0% aka -46.5dB causes some kind of auto-mute that
>>> cuts off all sound. It shouldn't do that. I've not muted it. I've set it
>>
>> Is this perhaps just an error in the TLV information - should it be
>> flagging that the minimim gain is mute but isn't?
> 
> There is no clear (or consistent) definition in HD-audio codec, I guess.
> Some chips do mute at 0 and some not.  The capability bit shows only
> whether it can mute or not -- not about whether it mutes at zero.

Is there some way I can force this metadata into the driver of files for
my h/w in such a way that PA will pick up on it and thus work correctly?

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
