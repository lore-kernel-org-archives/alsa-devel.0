From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Tests of the hda-jack branch
Date: Wed, 30 Nov 2011 09:26:53 +0000
Message-ID: <20111130092652.GA2791@opensource.wolfsonmicro.com>
References: <4ED535CA.1080108@canonical.com>
	<20111129200351.GF12111@sirena.org.uk>
	<s5hd3caw1rz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1546510398A
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2011 10:26:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hd3caw1rz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 30, 2011 at 07:41:04AM +0100, Takashi Iwai wrote:

> BTW, how will the multiswitch API look like?

It's taken the Android switch API as a starting point so the main
reporting mechanism is uevents.
