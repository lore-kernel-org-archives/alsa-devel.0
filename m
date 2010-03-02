From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 4/4] ASoC: OMAP3: Report delay on playback
 caused by the internal FIFO
Date: Tue, 2 Mar 2010 14:06:32 +0000
Message-ID: <20100302140631.GA2502@opensource.wolfsonmicro.com>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267537191-25254-5-git-send-email-peter.ujfalusi@nokia.com>
	<20100302134707.GF10658@sirena.org.uk>
	<201003021552.36622.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3C501103905
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 15:06:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201003021552.36622.peter.ujfalusi@nokia.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 02, 2010 at 03:52:36PM +0200, Peter Ujfalusi wrote:
> On Tuesday 02 March 2010 15:47:07 ext Mark Brown wrote:

> > You're already handling the playback vs. capture thing here! :)

> Oh yes, I do. I have removed the capture (rx related) reporting, since as I 
> mentioned, I was not sure how to, and what to report.
> But is it OK to have initially support for playback delay handling, and if there 
> is a need, add the capture later?

The code is fine, this was more a comment on the earlier patch.
