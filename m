From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: dmix plugin
Date: Wed, 12 Feb 2003 20:21:31 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302122015190.30420-100000@pnote.perex-int.cz>
References: <08F1D234AF91E540BC1F43889E2A6AA70AEBFD@digiexch.digigram.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA11164
	for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2003 20:21:38 +0100
In-Reply-To: <08F1D234AF91E540BC1F43889E2A6AA70AEBFD@digiexch.digigram.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Marc Titinger <titinger@digigram.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Feb 2003, Marc Titinger wrote:

> This looks Great !
> 
> I haven't yet experimented a lot with .asoundrc files, so please excuse
> me if the following questions are irrelevant or OTO, but:
> 
> I was wondering if one could define a plug pcm, that offers two stereo
> pairs routed with policy "average" to a single-stereo "hw" slave.
> 
> My understanding is that until this dmix pcm, there was no "official"
> means supported by alsalib to achieve software mix of streams comming
> from differents apps.

Yes, that's true.

> Could I have one app open the first pair of my hypothetic plug pcm, and
> another app open the second pair ? I guess this would be managed like a
> concurrent access to a pcm, and block or fail the second open() call.
> 
> Would'nt it be nice to create a dmix pcm "behind"  a such plug pcm, to
> provide mix in a transparent way ?

Some cards with multiple open hardware acceleration doesn't need this 
default. Also, the dmix plugin has some limited things so I don't prefer 
to select it as default.

> 
> thanks for your light over this 
> Marc.

I've just added the definition of dmix plugin to the global alsa
configuration file. Usage (device name only):

plug:dmix
"plug:'dmix:RATE=44100'"
"plug:'dmix:SLAVE=\'hw:0,0,2\',RATE=44100'"

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
