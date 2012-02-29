From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: HDA intel, wired headset w/mic, jack mic detect
Date: Wed, 29 Feb 2012 15:26:25 +0000
Message-ID: <20120229152624.GA8994@sirena.org.uk>
References: <87ehtlwen3.fsf@ti.com> <4F472D4F.3000904@canonical.com>
	<CALyTGODsDRToe7efiHoVecvQ2JAYVj+G1Rv+upf2tBDDjPpzCg@mail.gmail.com>
	<CAN8cciZm2s-1Y69cohepoNNYsyBq4qQzyvbkXF2K4aDspfVtGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C8DF924482
	for <alsa-devel@alsa-project.org>; Wed, 29 Feb 2012 16:26:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAN8cciZm2s-1Y69cohepoNNYsyBq4qQzyvbkXF2K4aDspfVtGQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 29, 2012 at 11:05:25PM +0800, Raymond Yau wrote:

> Does your headset/mic has a TRRS (Tip, ring, ring, sleeve) connector
> instead of TRS (Tip, ring, sleeve) connector ?

> You can use David's hda-jack-sense-test to find out any jack sense at
> the node of External mic when you plug the headset , if not , you may
> need to modify unsol event of  headphone to select the external mic ,
> internal mic.

Given that this is a MacBook Air it'll be the Apple pinout with ground
on pin 3; any Apple headset and most third party ones ought to be happy.
