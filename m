From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Why does Alsa sometimes not find the HDSP 9652? -SOLVED
Date: Mon, 29 Dec 2003 11:01:18 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGIELIEFAB.mknecht@controlnet.com>
References: <1072723808.20678.3.camel@lotte.street-vision.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1072723808.20678.3.camel@lotte.street-vision.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Justin Cormack <justin@street-vision.com>
Cc: alsa list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Justin
> Cormack
> Sent: Monday, December 29, 2003 10:50 AM
> To: Mark Knecht
> Cc: alsa list
> Subject: RE: [Alsa-devel] Why does Alsa sometimes not find the HDSP
> 9652? -SOLVED
>
>
> Ah. that explains why I have never seen it - I always let my machines
> boot up from grub on the full timeout and most of them have pretty slow
> bootup processes. It is probably best to retry for 1 minute or so in
> module init to allow for very fast boots (after all the pci id has
> matched, so only broken hardware will never succeed).
>
> Justin
>

Sure. I was thinking that the snd-hdsp driver could also have a config
option that specified how long I wanted it to wait and keep trying. If I set
if for 30 seconds, then I don't need abnormally long timeouts in SC7 or
grub, but if I forget and hit enter one morning early then the driver could
just sit there and work for whatever amount of time I told it to.

Anyway, I think that a couple of other people have seen things like this
before, so now I'll play a bit with minimum timeouts and probably end up
with a reasonable boot time but still 100% functionality.

Now, if I could only get someone to pay attention to the new problems in the
older Hammerfall 9636 driver...

Cheers,
Mark




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
