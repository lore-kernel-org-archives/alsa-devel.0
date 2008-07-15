From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [Alsa-user] is this card supported by ALSA?
Date: Tue, 15 Jul 2008 19:02:46 +0200
Message-ID: <487CD836.3030600@keyaccess.nl>
References: <BLU137-W526424D3E9A79DA1437849959A0@phx.gbl>	<48701633.7040601@keyaccess.nl>	<loom.20080708T141841-614@post.gmane.org>	<4873AB3B.1070403@keyaccess.nl>	<4873CED6.2040704@keyaccess.nl>	<4873D033.8010604@keyaccess.nl>	<BLU137-W434EEB6A014E95FD1E225C95910@phx.gbl>	<48769D84.1050102@keyaccess.nl>	<BLU137-W51DDE8E1756609BBE5CF7F95910@phx.gbl>	<4876A0DE.2050803@keyaccess.nl>	<BLU137-W23A4FF48E97AC32476FD6095900@phx.gbl>	<4876AC75.2010305@keyaccess.nl>	<BLU137-W541C318CC744C4BF6461DE95900@phx.gbl>	<4876B329.80700@keyaccess.nl>	<BLU137-W3234537335E7D553F03AF195900@phx.gbl>	<48798CF7.6020303@keyaccess.nl>	<loom.20080714T232812-533@post.gmane.org>	<487BEB3D.6000209@keyaccess.nl>	<s5hvdz7uwb6.wl%tiwai@suse.de>
	<s5hod4zxm9v.wl%tiwai@suse.de> <487CB73D.4050808@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id BBB37244BB
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 19:00:54 +0200 (CEST)
In-Reply-To: <487CB73D.4050808@keyaccess.nl>
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

On 15-07-08 16:42, Rene Herman wrote:

> On 15-07-08 16:19, Takashi Iwai wrote:
> 
>> The below is a patch to improve the codec access routines in a bit
>> more robust way (and clean-ups, too).  Give it a try.
> 
> Thank you for taking this...
> 
> Landis, if it's easier for you due to webmail stuff, I'm attaching the 
> patch to this message so that it might be easier for you to save it 
> (Takashi posted it "inline" in the message).
> 
> The way to use this is very similar to what you did for the OSS driver 
> patch. You save this somewhere, then from the root of the source tree 
> (from /usr/src/linux-2.6.25.9 it was...) you do
> 
> # patch -p1 --dry-run < /some/where/ens1371-ac97.diff
> 
> and upon seeing that complete without errors, without the --dry-run:
> 
> # patch -p1 --dry-run < /some/where/ens1371-ac97.diff

Just in case... I did _say_ "without the --dry-run" but then neglected 
to actually delete it from the second line here. You _did_ delete it, right?

> You then recompile the kernel with "make" (which should now only 
> recompile the snd-ens1371 driver) and do a "make modules_install" after 
> it finishes.
> 
> Then, make sure no old driver for the card is loaded:
> 
> # modprobe -r snd-ens1371
> # modprobe -r es1371
> 
> and load the new one:
> 
> # modprobe snd-ens1371
> 
> then up and unmute volumes in alsamixer again and try if you have sound 
> with "speaker-test" or "aplay foo.wav".
> 
> If you do, you should blacklist the now installed OSS es1371 driver (add 
> "blacklist es1371" to /etc/modprobe.d/blacklist) and make sure 
> snd-ens1371 is no longer blacklisted. If all's well, working sound 
> should then survive a reboot (and a future kernel would include the fix 
> autonmatically so things just work out of the box).

Off,
Rene.
