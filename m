From: drclaw@dogsolitude.org
Subject: Re: [linux-audio-dev] Re: [linux-audio-announce] ALSA Hammerfall DSP driver
Date: Mon, 24 Jun 2002 14:28:09 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020624182809.GA4206@dogsolitude.org>
References: <200205140133.g4E1XWJ32168@op.net> <3D17918B.4030801@homemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from pylon.dogsolitude.org (postfix@map-dsl-134.map.com [208.168.78.134])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA16919
	for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2002 00:13:32 +0200
Content-Disposition: inline
In-Reply-To: <3D17918B.4030801@homemail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "D. Sen" <dsen@homemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Apparently, check out this link:

http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg03324.html

By virtue of the way cardbus works, as soon as all of the kernel hooks
are in place it is treated as a pci card, therefore ALSA supports both
the pci and cardbus versions of the hammerfall dsp system equally well.
It seems that the problems people were having regarding the cardbus
interface were due to the kernel's cardbus support and/or configuration.
It isn't clear whether simply finding the right version of cardservices
will make everything work or if some laptop cardbus chipsets aren't
supported as well as they could be supported.  For more information, do
a search of the archive and read the previous posts on the subject.  

784 - Michael C. Piantedosi - drclaw@dogsolitude.org


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
