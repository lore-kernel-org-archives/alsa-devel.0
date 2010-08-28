From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: 5.1 surround on 3 jacks (retasking)
Date: Sat, 28 Aug 2010 16:55:33 +0200
Message-ID: <4C792365.6050308@canonical.com>
References: <AANLkTin3DKSRuUZwARAadMTVPTrj17eHK8557bCsb3YM@mail.gmail.com>	<4C75A7D9.1030604@canonical.com>	<AANLkTinE8sjRWWsHYJYq1w_rLJu9Y91J4gs7k-Q_M3j-@mail.gmail.com>	<4C76100C.3040205@canonical.com>	<AANLkTimRwKPFohM46pOKXDmGbcbnCuGWX1VwwcGbk+6o@mail.gmail.com>
	<AANLkTinzKoqc7xDgU1r4yL4AxS4OwUPzkwQ3ieJuXA4h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id DA7F4244E1
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Aug 2010 16:55:36 +0200 (CEST)
In-Reply-To: <AANLkTinzKoqc7xDgU1r4yL4AxS4OwUPzkwQ3ieJuXA4h@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Keith Chew <keith.chew@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010-08-28 16:11, Keith Chew skrev:
>> And 6 channels is now working perfectly. I have also tried the early
>> patch method, and that works too!
>>
>> Thanks again for all your help.
>>
> 
> Hi David
> 
> Just a quick follow up on this. I have found the volume on the output
> jacks to be quite soft. 100% (master, front, clfe, surround) volume in
> alsamixer gives the same volume as 60% percent using a soundblaster
> card (driver CA0106). Is it a known issue with realtek ALC888 hardware
> that the output volume is generally lower? Or perhaps there is some
> "gain" setting I can use for the pin config?

Answering as a layman - make sure there are no other volume controls you
need turn up. There is also the -10 dBv <=> +4 dBu difference, could be
that your old card had the other voltage reference. Other than that, I
don't know.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
