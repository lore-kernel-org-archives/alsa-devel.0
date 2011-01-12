From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Adding a "capture" device naming scheme
Date: Wed, 12 Jan 2011 09:10:10 +0000
Message-ID: <igjr5i$jjb$1@dough.gmane.org>
References: <igi861$q8o$1@dough.gmane.org>	<AANLkTikGo8FMVf_9UMBa+iOhgXXdtWFdePk_7=6zwDhA@mail.gmail.com>
	<s5h62tuipeh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CBB024478
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 10:10:34 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Pcwin-0003DH-Tv
	for alsa-devel@alsa-project.org; Wed, 12 Jan 2011 10:10:25 +0100
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 10:10:25 +0100
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 10:10:25 +0100
In-Reply-To: <s5h62tuipeh.wl%tiwai@suse.de>
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

'Twas brillig, and Takashi Iwai at 12/01/11 06:53 did gyre and gimble:
> I read Colin meant front:CARD=x is incorrect while hw:CARD is a lowlevel
> access that one doesn't always want.

For capture. Yes that's what I was meaning.

> I'm fine with creating a new name, but wondering which name is best.
> Basically what you want here is the default use-case but without
> dsnoop like the current "default".  (If dsnoop were acceptable,
> "default" should have been used in most places.)
> "capture" may be also too ambiguous for defining that, I'm afraid.

Yeah, "default" wont work here due to it being redirected to PulseAudio
(as opposed to dsnoop) in this use case, so we need to avoid that name :s

IMO "capture" is quite clear (or at least as clear as "front" is for
playback!), but here are a few other suggestions:

"record"
"input"
"read"


Personally, "input" and "capture" are my two favourites.

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
