From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 0/2] ASoC: TWL4030 updates
Date: Fri, 27 Mar 2009 11:52:34 +0000
Message-ID: <20090327115234.GB9621@sirena.org.uk>
References: <1238143148-31894-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A2C9010388F
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2009 12:52:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1238143148-31894-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 27, 2009 at 10:39:06AM +0200, Peter Ujfalusi wrote:

> Two small updates for the TWL4030 codec driver:
> 1. Add support for 96KHz sample rate playback (96KHz capture is not supported)
> 2. Constrains to protect the already running stream from accidental
>    reconfiguration

Applied both, thanks.  

Someone (probably me, I'm working on something which could use it at the
minute) ought to factor out the implementation of symmetric rate
selection into the core.
