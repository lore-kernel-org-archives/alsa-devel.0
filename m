From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Bug in alsa-lib or alsamixer and amixer
Date: Sat, 19 Jun 2010 09:13:45 +0100
Message-ID: <hvhu61$cov$3@dough.gmane.org>
References: <AANLkTikawWMIPuuahzJuqnqHTW0MsRZWaP1c3O4pY8N7@mail.gmail.com>	<hv912l$j53$1@dough.gmane.org>	<AANLkTimeqs9dKkCemPzmrdYCboH-uxW5FkfLgiWFZEPl@mail.gmail.com>	<hvbgo6$3fg$1@dough.gmane.org>	<AANLkTinYBKzxiITOnspsn2QOh_Rdv8FHu_PC7K7cGCXm@mail.gmail.com>	<4C1951F1.4000504@colin.guthr.ie>	<AANLkTim8q8dbV5-jyeHev1lh1b8HQOzhEETKBSa4o1Ol@mail.gmail.com>	<AANLkTimjd_PDBv9agMxqCeMr_Kd1lTuwo2TIwLVRp00U@mail.gmail.com>
	<AANLkTinZFz6NyImuanu7guAg1fiP2hynu55NqeN4apyH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 8ACDB1037FF
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jun 2010 10:15:09 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OPtCg-0005Db-WF
	for alsa-devel@alsa-project.org; Sat, 19 Jun 2010 10:15:03 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 19 Jun 2010 10:15:02 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 19 Jun 2010 10:15:02 +0200
In-Reply-To: <AANLkTinZFz6NyImuanu7guAg1fiP2hynu55NqeN4apyH@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 19/06/10 01:39 did gyre and gimble:
> To simpify the implementation of the slider ,  a new "PA dB scale" is used
> by shift those +12dB(base volume) to 0dB and insist that every sound card 's
> minimum_dB is -inf dB ,

No. -inf dB is -inf dB. If the card does not go down to -inf dB, PA will
extend the range in software. If a card only goes down to -12dB minimum
the range -12dB -> -infdB will be done in software. Lennart explained
this very clearly to you already.

> This mean that all sound cards will now have same "PA  dB range" , the
> volume slider does not need resize or rescaling any more. This is why they
> prefer to use percentage to make you believe their calculation of dB is
> correct

WTF? "prefer to use percentage"? What the hell are you talking about?

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
