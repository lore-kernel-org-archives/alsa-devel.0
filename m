From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [Alsa-user] is this card supported by ALSA?
Date: Tue, 15 Jul 2008 17:36:14 +0200
Message-ID: <487CC3EE.4000001@keyaccess.nl>
References: <BLU137-W526424D3E9A79DA1437849959A0@phx.gbl>	<48701633.7040601@keyaccess.nl>	<loom.20080708T141841-614@post.gmane.org>	<4873AB3B.1070403@keyaccess.nl>	<4873CED6.2040704@keyaccess.nl>	<4873D033.8010604@keyaccess.nl>	<BLU137-W434EEB6A014E95FD1E225C95910@phx.gbl>	<48769D84.1050102@keyaccess.nl>	<BLU137-W51DDE8E1756609BBE5CF7F95910@phx.gbl>	<4876A0DE.2050803@keyaccess.nl>	<BLU137-W23A4FF48E97AC32476FD6095900@phx.gbl>	<4876AC75.2010305@keyaccess.nl>	<BLU137-W541C318CC744C4BF6461DE95900@phx.gbl>	<4876B329.80700@keyaccess.nl>	<BLU137-W3234537335E7D553F03AF195900@phx.gbl>	<48798CF7.6020303@keyaccess.nl>	<loom.20080714T232812-533@post.gmane.org>	<487BEB3D.6000209@keyaccess.nl>	<s5hvdz7uwb6.wl%tiwai@suse.de>
	<s5hod4zxm9v.wl%tiwai@suse.de> <487CB73D.4050808@keyaccess.nl>
	<BLU137-W34E0AFAD1183AF146DF6F8958C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id F07012447F
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 17:34:23 +0200 (CEST)
In-Reply-To: <BLU137-W34E0AFAD1183AF146DF6F8958C0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Landis McGauhey <b3zdomny@hotmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 15-07-08 17:25, Landis McGauhey wrote:
> 
> 
>  > Date: Tue, 15 Jul 2008 16:42:05 +0200
>  > From: rene.herman@keyaccess.nl
>  > To: b3zdomny@hotmail.com
>  > CC: tiwai@suse.de; alsa-user@lists.sourceforge.net; 
> alsa-devel@alsa-project.org
>  > Subject: Re: [Alsa-user] is this card supported by ALSA?
> <snip>
> 
> OK, interim report:
> 
> the patch, the make, the makemodules, and the modprobes all proceeded 
> without error.

the "make modules_install" I hope. "make modules" would just make the 
modules, not install them. You need to be very sure you're running the 
new;y compiled driver (ie, as said, unload any current driver, and 
reload after the make modules_install).

Whatever the result, sound or no, please also report the 
/proc/asound/AudioPCI/code97#0/ files

> # aplay /usr/share/sounds/startup3.wav
> ALSA lib pcm_dmix.c:864:(snd_pcm_dmix_open) unable to open slave
> aplay: main:564: audio open error: No such file or directory

Quite frankly, I haven't a clue what _that_ is now about again all of a 
sudden, but also try "aplay -D hw:AudioPCI foo.wav".

Rene.
