From: Peter Niemayer <niemayer@isg.de>
Subject: Re: spdif/iec958 outputs at VT1708S not recognized
Date: Mon, 11 May 2009 10:56:29 +0200
Message-ID: <4A07E83D.5070608@isg.de>
References: <gt9gvo$ocq$1@ger.gmane.org>
	<s5hmy9zfqhn.wl%tiwai@suse.de>	<4A001971.5020803@isg.de>
	<s5hbpq52e1h.wl%tiwai@suse.de>	<4A03F9B2.2020904@isg.de>
	<s5hfxfgc56k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 461AD24710
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 10:56:43 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M3RJT-0002VP-1b
	for alsa-devel@alsa-project.org; Mon, 11 May 2009 08:56:43 +0000
Received: from barriere.frankfurter-softwarefabrik.de ([217.11.197.1])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 08:56:43 +0000
Received: from niemayer by barriere.frankfurter-softwarefabrik.de with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 08:56:43 +0000
In-Reply-To: <s5hfxfgc56k.wl%tiwai@suse.de>
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
Cc: Stephen.Randall@cw.com
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> In that case, you can build ALSA modules externally from alsa-driver
> tarball.  Grab the snapshot version from
>     ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz

I did that - this version works well for me. Thanks for your efforts!

(There is a minor glitch persistent that wasn't existing with
  my older AC97 based hardware: When pausing an AC3 stream
  to the amplifier, then resuming the playback, there is a loud
  "click" in the beginning as if there was a broken data packet
  sent to the amplifier - but one with a correct checksum, that
  has to be, as otherwise, the amplifier would not have played
  it. Or maybe the amp is misinterpreting some AC3 data as being PCM,
  but that wasn't the case with the previous audio card, though
  the software and the amp were the same.)

Regards,

Peter Niemayer
