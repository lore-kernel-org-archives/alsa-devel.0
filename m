From: Torstein Hegge <hegge@resisty.net>
Subject: Re: VIA VT1731
Date: Thu, 11 Apr 2013 10:48:44 +0200
Message-ID: <20130411084844.GD14619@pvv.ntnu.no>
References: <CANbWPOaG-NoRcorvQRSFyUCvLpAnt1gTxZHTnuFJDk1ph6qseQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from microbel.pvv.ntnu.no (microbel.pvv.ntnu.no [129.241.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id BDC55265FD0
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 10:48:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CANbWPOaG-NoRcorvQRSFyUCvLpAnt1gTxZHTnuFJDk1ph6qseQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALEKSANDR BOIKO <carmagff@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 11, 2013 at 11:50:11 +0400, ALEKSANDR BOIKO wrote:
> I'm using DAC Audio-GD Master 7 with Voyage MPD. There is a problem with
> playback audio files
> different frequency. I've read there is a path - solution. How can I get
> it?

The CM6631 / VT1731 workaround is included in kernel 3.9-rc6.

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=690a863ff03d9a29ace2b752b8f802fba78a842f


Torstein
