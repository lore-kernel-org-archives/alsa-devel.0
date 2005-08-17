From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [parisc-linux] [PATCH] Support for AD1889 PCI
 Soundchip
Date: Wed, 17 Aug 2005 15:50:26 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508171547320.19860-100000@studcom.urz.uni-halle.de>
References: <20050817015119.GA18244@roadwarrior.mcmartin.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050817015119.GA18244@roadwarrior.mcmartin.ca>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: Thibaut VARENE <T-Bone@parisc-linux.org>, alsa-devel@lists.sourceforge.net, parisc-linux@lists.parisc-linux.org
List-Id: alsa-devel@alsa-project.org

Kyle McMartin wrote:
> Your patch appears to work fine in OSS mode, but native ALSA on
> PA-RISC still seems broken.

The biggest difference may be that OSS uses power-of-two period and
buffer sizes.

Does it work with "aplay --period-size=1024 --buffer-size=8192 ..."?


Regards,
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
