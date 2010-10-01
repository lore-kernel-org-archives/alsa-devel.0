From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsactl adds volume controls?
Date: Fri, 01 Oct 2010 11:02:02 +0200
Message-ID: <4CA5A38A.7050006@ladisch.de>
References: <s5hr5hczi06.wl%tiwai@suse.de>	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>	<i7viav$kjb$1@dough.gmane.org>	<4CA46E98.10402@ladisch.de>	<4CA4A844.7060403@colin.guthr.ie>	<20100930164753.GB9431@sirena.org.uk>	<s5hr5gb9k83.wl%tiwai@suse.de>	<4CA5834D.5030408@ladisch.de>
	<4CA59976.2020306@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 926C71039E8
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 11:01:18 +0200 (CEST)
In-Reply-To: <4CA59976.2020306@colin.guthr.ie>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Colin Guthrie wrote:
> 'Twas brillig, and Clemens Ladisch at 01/10/10 07:44 did gyre and gimble:
> > Colin, please tell us the IDs of your codec so that we can add a TLV
> > workaround to the driver.
> 
> I presume the alsa-info.sh output is sufficient here?

| Codec: SigmaTel STAC9200
| Vendor Id: 0x83847690

Yes.

| Node 0x0b [Audio Selector] wcaps 0x300105: Stereo Amp-Out
|   Control: name="Master Playback Volume", index=0, device=0
|     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
|   Control: name="Master Playback Switch", index=0, device=0
|     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
|   Amp-Out caps: N/A

Is this still "N/A" when you try again?


Regards,
Clemens
