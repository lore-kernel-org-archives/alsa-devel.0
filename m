From: Corvus Corax <corvus-ml@cybertrench.com>
Subject: Re: lo10K1 not working on x86_64 ?
Date: Wed, 9 Nov 2005 14:13:10 +0100
Message-ID: <20051109141310.69fb39f4@VikingPC.home>
References: <20051102212009.6121d6c3@VikingPC.home>
	<20051103120117.GA27985@skinner.hem.za.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051103120117.GA27985@skinner.hem.za.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have tested it again now, and failed to get a useable configuration doe to the
following problems.

As soon as I load a more complex patch set - by init_live - or just by inserting
multiple master_volume patches (Am I correct that the 6 channel master volume is
the only one with a single slider to control 2 channels i.e. left and right
component? because the 2-channel Vol sets up separate mixer sliders for each
control) I get heavy distortion and the actual output seems to have nothing to
do anymore with the intention of the patchset, I have then to load a different
saved set from disk, or clear the DSP / unload all patches manually, and load
new ones to get normal output again.

That happens already when loading the patchsets, usually before actually
connecting their I/O channels together. Its almost like they would overwrite
eachother on loading, creating garbage in the DSP memory...

However a single patch does work as expected as it seems, at least for volume
controls and routings.

I haven't tested the FX-BUS because I dont know how that one is supposed to
work. On loading that patch over an existing routing I usually get the mentioned
distortion and most mixer controls cease to function.

By the way, is there a way to control custom volume sliders with OSS mixer
controls? Does the OSS emulation driver have to be re-loaded after loading the
patchset? I get mixer program hangs when trying to use OSS mixer controls, and
when overriding Alsa PCM or Master sliders with new ones, their OSS counterparts
still control only the left/right channels like with no patchset.

regards

Corvus



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
