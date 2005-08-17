From: Kyle McMartin <kyle@parisc-linux.org>
Subject: Re: [parisc-linux] [PATCH] Support for AD1889 PCI Soundchip
Date: Tue, 16 Aug 2005 21:51:19 -0400
Message-ID: <20050817015119.GA18244@roadwarrior.mcmartin.ca>
References: <20050812021423.GB14400@roadwarrior.mcmartin.ca> <Pine.HPX.4.33n.0508120911590.10052-200000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0508120911590.10052-200000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Thibaut VARENE <T-Bone@parisc-linux.org>, alsa-devel@lists.sourceforge.net, parisc-linux@lists.parisc-linux.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 12, 2005 at 09:17:47AM +0200, Clemens Ladisch wrote:
> It should apply against both, but it seems somewhere some whitespaces
> got lost ...
> 
> Here you go again.

Sorry for taking so long to get back to you. Your patch appears to work
fine in OSS mode, but native ALSA on PA-RISC still seems broken. Thibaut
seems to point out that this is not the driver, but a more deep seated
problem, as the driver seems to function properly in native ALSA playback
mode on powerpc.

I'll keep the patch in my tree, and give it a few days of beating.

Cheers,
-- 
Kyle McMartin


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
