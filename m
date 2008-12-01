From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/4] ASoC: TWL4030: Add pre-DAC digital mux
	controls
Date: Mon, 1 Dec 2008 11:43:48 +0000
Message-ID: <20081201114348.GD13758@sirena.org.uk>
References: <1228118628-22856-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228118628-22856-2-git-send-email-peter.ujfalusi@nokia.com>
	<1228118628-22856-3-git-send-email-peter.ujfalusi@nokia.com>
	<1228118628-22856-4-git-send-email-peter.ujfalusi@nokia.com>
	<1228118628-22856-5-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B3C72444A
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 12:43:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1228118628-22856-5-git-send-email-peter.ujfalusi@nokia.com>
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

On Mon, Dec 01, 2008 at 10:03:48AM +0200, Peter Ujfalusi wrote:

> Controls for selecting the digital inputs for the four
> DAC.

How often is this feature used at the minute?  While I've got no problem
with the code per se there's currently no framework in ASoC for handling
digital routing which means that having the flexibility creates problems
with DAPM (which isn't implemented yet for this codec).  There's no real
issue merging it, but it might make life easier to leave it for now.

Implementing digial routing support is on my radar but it's firmly below
the V2 merge.
