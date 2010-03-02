From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 3/4] OMAP3: McBSP: Add interface for	transmit
	FIFO state query
Date: Tue, 2 Mar 2010 13:45:58 +0000
Message-ID: <20100302134557.GE10658@sirena.org.uk>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267537191-25254-4-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 72DCA1038E1
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 14:45:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1267537191-25254-4-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 02, 2010 at 03:39:50PM +0200, Peter Ujfalusi wrote:
> New function for reading the XBUFFSTAT register, which holds
> the fill state of the transmit buffer on McBSP.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

It'd be really nice if this could go into 2.6.34 to avoid cross-tree
issues but for that you'd need to submit via OMAP.  It'll need their
ack anyway.
