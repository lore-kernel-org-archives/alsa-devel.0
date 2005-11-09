From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: lo10K1 not working on x86_64 ?
Date: Wed, 09 Nov 2005 20:02:33 +0100
Message-ID: <1131562953.4679.12.camel@localhost.localdomain>
References: <20051102212009.6121d6c3@VikingPC.home>
	 <20051103120117.GA27985@skinner.hem.za.org>
	 <20051109141310.69fb39f4@VikingPC.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051109141310.69fb39f4@VikingPC.home>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Corvus Corax <corvus-ml@cybertrench.com>
Cc: Mikael Magnusson <mikaelmagnusson@glocalnet.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Could you send output of lo10k1 when this happen ?

lo10k1 --debug 1
lo10k1 --debug 2
lo10k1 --debug 3
lo10k1 --debug 4
lo10k1 --debug 5
lo10k1 --debug 6
lo10k1 --debug 7
lo10k1 --debug 8
lo10k1 --debug 9

and for every loaded effect (less loaded effect will be better)
lo10k1 --debug 100
lo10k1 --debug 101

up to last loaded (for example if there are 5 loaded last will be 104)

lo10k1 --debug 104

and content of fx8010_acode from /proc/asound card directory) too

Peter Zubaj

On Wed, 2005-11-09 at 14:13 +0100, Corvus Corax wrote:
> As soon as I load a more complex patch set - by init_live - or just by inserting
> multiple master_volume patches (Am I correct that the 6 channel master volume is
> the only one with a single slider to control 2 channels i.e. left and right
> component? because the 2-channel Vol sets up separate mixer sliders for each
> control) I get heavy distortion and the actual output seems to have nothing to
> do anymore with the intention of the patchset, I have then to load a different
> saved set from disk, or clear the DSP / unload all patches manually, and load
> new ones to get normal output again.






-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
