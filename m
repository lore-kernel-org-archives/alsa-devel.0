From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 3/3] ALSA SoC: Add Texas Instruments
	TLV320AIC26 codec	driver
Date: Sat, 12 Jul 2008 19:10:00 +0100
Message-ID: <20080712180959.GB6523@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DFFD103830
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Jul 2008 20:10:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080712083939.15025.31192.stgit@trillian.secretlab.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 12, 2008 at 02:39:39AM -0600, Grant Likely wrote:

> ASoC Codec driver for the TLV320AIC26 device.  This driver uses the ASoC
> v1 API, so I don't expect it to get merged as-is, but I want to get it
> out there for review.

I've not reviewed this revision of these drivers yet but I just wanted
to point out that there's absoluely no problem with merging v1 drivers -
so long as a driver uses the existing merged APIs there's no issue from
that point of view.
