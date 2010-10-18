From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCH] Per Application Volume Control plugin for
	ALSA
Date: Mon, 18 Oct 2010 13:14:44 +0100
Message-ID: <i9hdnk$k10$1@dough.gmane.org>
References: <AANLkTikq=9HHQgsdK6CJfNfdOnX5xkBgcLTLrS_Y7Fv8@mail.gmail.com>
	<AANLkTimZgTBaGyK=g5UTkHQ--e=Q5ZpONrrB-7wk8pOp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 9ADE610380C
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Oct 2010 14:15:00 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P7ocB-0000xx-SR
	for alsa-devel@alsa-project.org; Mon, 18 Oct 2010 14:14:55 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2010 14:14:55 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2010 14:14:55 +0200
In-Reply-To: <AANLkTimZgTBaGyK=g5UTkHQ--e=Q5ZpONrrB-7wk8pOp@mail.gmail.com>
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

'Twas brillig, and James Huk at 17/10/10 22:54 did gyre and gimble:
> Thanks for the answers, everyone.
> 
> @Colin Guthrie:
> 
>> Is there a specific use case targeted with this patch or is it really
>> just a "proof of concept" demonstration that alsa can do this sans PA?
> 
> Before I written this plugin I tried to use PulseAudio -
> unfortunately, applications I use didn't worked to well with it so I
> had to get rid of it, however I liked the idea of PAVC. Then I tried
> OSS4 but again - unfortunately it doesn't support my ALC1200 too well
> (interesting info for those out there who says "Get rid of ALSA, get
> rid of PA, install OSS4 because it just works" well, not always guys -
> this time ALSA is the winner - this is not intended as a flame-war
> starter, just as information). Finally I found "copy" plugin for ALSA,
> started to tamper with it a bit, and found out that writing PAVC
> plugin wouldn't be, all that hard. I created this because I liked this
> feature on PA and OSS4 and ALSA lacked it - nothing more to this, than
> that.

No worries, seems like a reasonable reason to have a go at this
implementation.

As a PA hacker, I'd be interested to know what apps were causing you
problems when you used PA so that we could help make them better for
other users who do want to use PA. If you could provide any details or
debug info, that would be great.

> Sorry for my English.

No need to apologise for that, I think it was fine :)

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
