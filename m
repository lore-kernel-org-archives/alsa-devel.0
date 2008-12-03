From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: TWL4030: Add input selection
	and?gain controls
Date: Wed, 3 Dec 2008 10:40:10 +0000
Message-ID: <20081203104008.GA2556@sirena.org.uk>
References: <1228243738-9561-1-git-send-email-notasas@gmail.com>
	<20081202203800.GB6972@sirena.org.uk>
	<200812030922.07399.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B0B74243D1
	for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2008 11:40:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200812030922.07399.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 03, 2008 at 09:22:07AM +0200, Peter Ujfalusi wrote:

> Just out of curiosity... Should not this be done with the DAPM - at least the input selection?

Yes, the input should ideally be DAPM controlled too.  Since the driver
doesn't use DAPM at all but has power managment entirely in the bias
level control it's fine for now, though.
