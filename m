From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: 5.1 surround sound playback XRUN /
 snd_pcm_writei() didn't unblock immediately / small 114 msec buffer
Date: Mon, 09 Oct 2006 17:21:29 +0200
Message-ID: <1160407289.6513.272893861@webmail.messagingengine.com>
References: <6.2.1.2.2.20060928013552.16a4b928@mailone.real.com>
	<s5hhcys2kr2.wl%tiwai@suse.de>
	<6.2.1.2.2.20060928125136.20c38030@mailone.real.com>
	<s5hhcyq52do.wl%tiwai@suse.de>
	<6.2.1.2.2.20061006012016.30ac5ee8@mailone.real.com>
	<1160140179.28711.272704715@webmail.messagingengine.com>
	<6.2.1.2.2.20061006123102.428226e0@mailone.real.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <6.2.1.2.2.20061006123102.428226e0@mailone.real.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Daniel Yek <dyek@real.com>, Alsa Developement <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Daniel Yek wrote:
> At 06:09 AM 10/6/2006, Clemens Ladisch wrote:
> >Daniel Yek wrote:
> > > I opened "surround51" PCM device and set the sampling rate to 48000, S16_LE
> > > format.
> >
> >Better use "plug:surround51".  There are chips like ICE1712 that do not
> >support any format except S32_LE.
> 
> It would be great if somebody could suggest an easy way for a media 
> application to identify if the system is 5.1-channels capable. After making 
> sure that 5.1-channels playback is preferable over 2-channels playback, I 
> can then use "plug:surround51" PCM device. I assume that Plug will convert 
> all 6 channels without dropping any here. If not, it is not usable.
> 
> Right now, I'm depending on opening "surround51" PCM device to fail to 
> indicate that the system isn't 5.1-channels capable. "plug:surround51" PCM 
> wouldn't open-fail even if the system isn't 5.1-channels capable, resulting 
> in a poor playback experience. Do you have a suggestion for me?

The configuration files won't define a "surround51" device if the
hardware is not capable of accepting 5.1 sound, so opening
"plug:surround51" should fail as expected.


HTH
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
