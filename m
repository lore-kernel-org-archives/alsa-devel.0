From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: hw_ptr accuracy with intel8x0 -> PulseAudio issue
Date: Wed, 09 Dec 2009 14:57:01 +0000
Message-ID: <hfodrt$ouf$1@ger.gmane.org>
References: <6160a5130912020115t45bd4635hceb0ac3de4fb1efe@mail.gmail.com>	<4f3252890912021826g732292ecv8959a7cfbf574446@mail.gmail.com>	<6160a5130912030828m5b2401f3w31a67b6b51e8d8b6@mail.gmail.com>	<4f3252890912031442i56ccc905g935a4d6ed48f40c6@mail.gmail.com>	<6160a5130912031650u5949c921jc86d0847b2844803@mail.gmail.com>	<4f3252890912041817u7ab83a3eh7643476d64d709f3@mail.gmail.com>	<s5h4oo1sisn.wl%tiwai@suse.de>	<4f3252890912090355n70a2b5cfu4fbb74d473480a94@mail.gmail.com>
	<s5hr5r4ntus.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 093D110383C
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 15:57:29 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NINyn-00060M-K0
	for alsa-devel@alsa-project.org; Wed, 09 Dec 2009 15:57:25 +0100
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 09 Dec 2009 15:57:25 +0100
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 09 Dec 2009 15:57:25 +0100
In-Reply-To: <s5hr5r4ntus.wl%tiwai@suse.de>
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

'Twas brillig, and Takashi Iwai at 09/12/09 13:46 did gyre and gimble:
>> PA only adjust the watermark/sleeping time in one direction only
> 
> Yes.

Actually there is code in PA to move the watermark in both ways, but
obviously reverting it backtowards the "underrun zone" is a bit
dangerous, so can't be just a simple "reduce it" back.

http://git.0pointer.de/?p=pulseaudio.git;a=commit;h=050a3a99e1d151b4f55c89f82073ef33f3399646

I can't remember the current status (i.e. if the code is disabled or
not) but AFAICT it's enabled.

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
