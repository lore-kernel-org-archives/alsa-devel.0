From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Duplicate wake-ups in pcm_lib.c
Date: Wed, 27 Jan 2010 10:46:23 +0000
Message-ID: <hjp5ht$bpr$1@ger.gmane.org>
References: <6160a5130912231228g29669e4ctfef9ea8f42633120@mail.gmail.com>	<alpine.LNX.2.00.0912240922460.2598@eeebox2.perex-int.cz>	<6160a5131001062059i1ef74831p4210987579feb759@mail.gmail.com>	<alpine.LNX.2.00.1001071552060.4210@eeebox2.perex-int.cz>	<hj29f0$v5d$1@ger.gmane.org>	<alpine.LNX.2.00.1001182233280.4324@eeebox2.perex-int.cz>	<hj5lvn$is9$1@ger.gmane.org>	<hj76gs$m9i$1@ger.gmane.org>
	<hjk0lg$3ti$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D61B103908
	for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2010 11:46:48 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1Na5Q2-0007WD-JI
	for alsa-devel@alsa-project.org; Wed, 27 Jan 2010 11:46:42 +0100
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2010 11:46:42 +0100
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2010 11:46:42 +0100
In-Reply-To: <hjk0lg$3ti$1@ger.gmane.org>
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

'Twas brillig, and Colin Guthrie at 25/01/10 11:52 did gyre and gimble:
> 'Twas brillig, and Colin Guthrie at 20/01/10 15:12 did gyre and gimble:
>> 'Twas brillig, and Colin Guthrie at 20/01/10 01:24 did gyre and gimble:
> Does this info help at all? Is there anything else I can get the guys
> suffering with this to do?

Following this thread:
hw_ptr_interrupt removal broke interrupt pointer updates

I'm guessing the fixes mentioned will address this bug. We're pushing
out a new kernel with these in so will let you know if any more problems
crop up. If I don't follow up, then assume it fixes things :)

Cheers

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
