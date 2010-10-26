From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: snd-hda-intel (Cirrus Logic CS4206): MacBookPro6,
 2 : No S/PDIF with Linux 2.6.36C
Date: Tue, 26 Oct 2010 14:02:24 +0100
Message-ID: <4CC6D160.3090008@colin.guthr.ie>
References: <loom.20101026T061309-466@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A53E2442F
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Oct 2010 15:02:39 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PAjAf-0001vt-61
	for alsa-devel@alsa-project.org; Tue, 26 Oct 2010 15:02:33 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2010 15:02:33 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2010 15:02:33 +0200
In-Reply-To: <loom.20101026T061309-466@post.gmane.org>
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

'Twas brillig, and Mohammad Bahathir Hashim at 26/10/10 06:08 did gyre
and gimble:
> Hi,
> I want to use MacBook Pro (6,2) Mid-2010 15" with GNU/Linux all the time.
> IMHO, GNU/Linux provides me the best performance and flexibility for
> audio and video. 
> 
> Problem 1:
> No SPDIF when using Linux 2.6.36, but it working fine with 2.6.35
> 
> Problem  2 ? :
> xFront Speaker -> controls the woofer sound level
> Surround -> controls the left and right channel speakers' sound level.
> 
> Both kernels 2.6.3[56] show the same problem/feature :). 


My guess at the fix:

ALSA: hda - Fix wrong SPDIF NID assignment for CA0110

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commit;h=24b55c69b66eb2a122842820ec14ab215fc8572f

(the base64 encoding of your alsa-info attachment didn't come through in
a friendly way so I didn't bother decoding it, and hence this is just a
guess)

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
