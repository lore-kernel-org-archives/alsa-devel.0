From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] ASoC: Merge the soc_value_enum to
	soc_enum struct
Date: Thu, 8 Jan 2009 13:48:51 +0000
Message-ID: <20090108134850.GC25876@sirena.org.uk>
References: <1231414470-24690-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C26B2443A
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 14:48:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1231414470-24690-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 08, 2009 at 01:34:29PM +0200, Peter Ujfalusi wrote:

> Merge the recently introduced soc_value_enum structure to the soc_enum.
> The value based enums are still handled separately from the normal enum types,
> but with the merge some of the newly introduced functions can be removed.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

This looks good, thanks for doing the cleanup.  Applied both.
