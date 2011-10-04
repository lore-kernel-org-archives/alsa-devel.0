From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 03/12] ASoC: Consolidate use of controls with
 custom get/put function
Date: Tue, 4 Oct 2011 16:30:54 +0100
Message-ID: <20111004153054.GM6934@opensource.wolfsonmicro.com>
References: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
	<1317728389-22062-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D3F1D103960
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 17:30:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317728389-22062-4-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Arun KS <arunks@mistralsolutions.com>, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 04, 2011 at 02:39:40PM +0300, Peter Ujfalusi wrote:
> Use the macros for controls require custom get/put function.
> This is to make sure that the soc_mixer_control is used
> consistently among the drivers.

Hrm, this doesn't actually apply on for-3.2 - looks like it collides
with Axel's cleanups.  Can you check and regenerate please?
