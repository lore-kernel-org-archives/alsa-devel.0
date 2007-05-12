From: Ctirad Fertr <c.fertr@volny.cz>
Subject: Re: e-mu 1212m and 1820(m) patch
Date: Sat, 12 May 2007 17:38:03 +0200
Message-ID: <200705121738.03567.c.fertr@volny.cz>
References: <200705112354.15848.c.fertr@volny.cz>
	<200705121202.52741.c.fertr@volny.cz>
	<4645CB0A.4010707@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.vol.cz (smtp3.vol.cz [195.250.128.83])
	by alsa0.perex.cz (Postfix) with ESMTP id C252224585
	for <alsa-devel@alsa-project.org>;
	Sat, 12 May 2007 17:38:14 +0200 (CEST)
Received: from [10.16.3.4] (dsl-tn-6-43.static.adsl.vol.cz [83.148.7.43])
	by smtp3.vol.cz (Postfix) with ESMTP id 57BF059207
	for <alsa-devel@alsa-project.org>;
	Sat, 12 May 2007 17:38:12 +0200 (CEST)
In-Reply-To: <4645CB0A.4010707@superbug.co.uk>
Content-Disposition: inline
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

> The link between hana and emu10k2 is 32bit.
> The link between the emu10k2 and the PCI bus for capture is 16bit and
> limited to 16 channels. 

Really? I'm almost sure that emu10k2 is capable of 64 streams at 16/44.1
(48kHz) resolution. 

> I decided to instead make this link 32bit, by 
> using 2 16bit channels, thus resulting in 16/2 = 8 channels.
> I do have one datasheet that hints at a 24bit channel from emu10k2 and
> the PCI bus, but I have not checked if the 1212m version of the emu10k2
> supports it.

A friend of mine does 16 channel recordings on 1820m under windows, so it's 
definitely possible. I have only 1212M (old version) and it's capable of 12 
ins and 12 outs at 44.1/48kHz, 8 ins and 8 outs at 96kHz and finally 4 ins 
and 4 outs at 192kHz. 

> It might only be the 1616m that supports it, and I have not 
> added support for that in alsa yet.

How much difference is between current 1820 (old 1010)  and 1616 (new 1010) 
code? Do you have something working? Anyway, I have good relations with local 
e-mu delaer, so I can borrow any e-mu hardware currently available. I also 
have gear needed for testing S/PDIF/ADAT/sync card functionality. 

Regards,

Ctirad
