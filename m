From: Dennis Veatch <dveatch@woh.rr.com>
Subject: Re: 0.9.7c, cs4236b and kernel oops
Date: Wed, 15 Oct 2003 09:20:53 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310150920.54003.dveatch@woh.rr.com>
References: <200310142124.56447.dveatch@woh.rr.com> <s5h7k36kcye.wl@alsa2.suse.de>
Reply-To: dveatch@woh.rr.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7k36kcye.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 15 October 2003 06:33 am, Takashi Iwai wrote:
> At Tue, 14 Oct 2003 21:24:56 -0400,
>
> Dennis Veatch wrote:
> > This is a Dell GX1 with a cs4236b integrated sound card. Running kernel
> > version 2.4.20. I have tried recompiling the kernel any number of ways
> > making the sound stuff modules and part of the kernel all with the same
> > results. I have wiped out /lib/modules and /usr/src/linux entirely,
> > re-downloaded all the kernel stuff and still had the same results. If I
> > use the 0.9.6 version of alsa-driver there are no problems.
>
> is it a pnp device or non-pnp?
>
> there are no big changes in the cs423x codes.
> so the problem must be in either pnp layer or the change in the core
> part.
>
> if it's pnp card, please try to replace snd-pnp.o with the old one in
> 0.9.6.
>
>

Actually I am not sure if its pnp or not. During boot it says "isapnp: Card 
'CS4236B' so I assume its pnp? 

There is definitely something different in snd-pnp.o between version 0.9.6 and 
0.9.7 on up. Tried your suggestion of copying snd-pnp.o (version 0.9.60) over 
the same of version 0.9.7c and there was no Oops.

One thing I forgot to mention about 0.9.6. As said it boots fine and all. 
During the install of snd-cs4236 there is a non-fatal error that says;

Starting sound driver: snd-cs4236 CS4236+ WSS PnP configure failed for WSS 
(out of resources?)
isapnp detection failed and probing for CS4236+ is not supported.


-- 
Registered Linux user 193414
http://counter.li.org

"Trying"? My contribution was much closer to a "feeble wave in the general 
direction of something that might lead you one step closer to a solution 
if you squint really hard and do all of the work."



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
