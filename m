From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsactl adds volume controls?
Date: Sun, 17 Oct 2010 12:22:41 +0100
Message-ID: <i9ema1$kdf$3@dough.gmane.org>
References: <s5hr5hczi06.wl%tiwai@suse.de>
	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>	<i7viav$kjb$1@dough.gmane.org>
	<4CA46E98.10402@ladisch.de>	<4CA4A844.7060403@colin.guthr.ie>	<20100930164753.GB9431@sirena.org.uk>	<s5hr5gb9k83.wl%tiwai@suse.de>
	<4CA5834D.5030408@ladisch.de>	<4CA59976.2020306@colin.guthr.ie>
	<4CA5A38A.7050006@ladisch.de>	<i8ce5u$fj3$1@dough.gmane.org>
	<4CAD7F3D.3090205@ladisch.de>	<4CAF1AF2.3060907@colin.guthr.ie>
	<4CAF1FA3.5000402@ladisch.de>	<4CAF2533.1060102@colin.guthr.ie>
	<4CAF27B7.9080909@colin.guthr.ie>	<4CAF2DD1.5050306@ladisch.de>
	<s5htyklurs1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id BB4EB244FB
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Oct 2010 13:30:04 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P7RRE-0005rC-IF
	for alsa-devel@alsa-project.org; Sun, 17 Oct 2010 13:30:04 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 17 Oct 2010 13:30:04 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 17 Oct 2010 13:30:04 +0200
In-Reply-To: <s5htyklurs1.wl%tiwai@suse.de>
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

'Twas brillig, and Takashi Iwai at 17/10/10 09:50 did gyre and gimble:
> At Sat, 16 Oct 2010 16:49:21 +0100,
> Colin Guthrie wrote:
>>
>> 'Twas brillig, and Colin Guthrie at 15/10/10 09:39 did gyre and gimble:
>>> 'Twas brillig, and Clemens Ladisch at 15/10/10 09:32 did gyre and gimble:
>>>> Colin Guthrie wrote:
>>>>> Clemens, are you able to commit the two patches here (my modification of
>>>>> your alsa-lib patch and your kernel patch).
>>>>
>>>> I would be able to commit them, but I've rewritten them.
>>>> Please test again.
>>>
>>> Sure thanks. I should be able to take a look over the weekend.
>>
>> Tested-by: Colin Guthrie <cguthrie@mandriva.org>
>>
>> Tested and confirmed
> 
> Thanks for testing.
> I applied Clemens' patch to sound git tree.
> (And applied to alsa-lib, too.)
> 
> I guess there are still other codecs showing the same behavior.
> I wonder whether other STAC/IDT codecs show the same behavior.
> Will check some others in the next week.

Ahh fantastic. Thanks Takashi. Any help in fixing these volume range
issues is very much appreciated.

Thanks Clemens for kicking this off :)


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
