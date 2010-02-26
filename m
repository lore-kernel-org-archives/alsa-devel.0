From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add support for Cirrus Logic CS42L52
 LowpowerStereo Codec
Date: Fri, 26 Feb 2010 10:12:59 +0000
Message-ID: <20100226101259.GA18053@rakim.wolfsonmicro.main>
References: <1267142855-12854-1-git-send-email-brian.austin@cirrus.com>
	<20100226005349.GA3800@opensource.wolfsonmicro.com>
	<C8CA3F5B-3BB3-497C-98AC-EAC10536BD93@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4CF35103A09
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 11:13:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <C8CA3F5B-3BB3-497C-98AC-EAC10536BD93@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, heelrod@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 25, 2010 at 07:59:29PM -0600, Austin, Brian wrote:

> Thanks alot for the feedback, I'll start fixing it up tomorrow.
> Should I send the smdk2443 driver, or wait till this is fixed up?

May as well send it, there should be relatively little coupling to the
CODEC driver.  Is this a plugin module for the SMDK or does it need
flying wires or mods to get it hooked up?
