From: Daniel Yek <dyek@real.com>
Subject: Re: Multichannels channel-mapping application API for
 PCM?
Date: Fri, 20 Oct 2006 14:00:19 -0700
Message-ID: <6.2.1.2.2.20061020102144.03e85a90@mailone.real.com>
References: <6.2.1.2.2.20061018160033.5bab2b70@mailone.real.com>
	<s5hfydj2k3g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hfydj2k3g.wl%tiwai@suse.de>
References: <6.2.1.2.2.20061018160033.5bab2b70@mailone.real.com>
	<s5hfydj2k3g.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

At 06:27 AM 10/20/2006, Takashi Iwai wrote:
><snip...>
> > I'm looking if there is a solution (application API) provided by ALSA 
> to do
> > channel-mapping. If there is one, I can just ask ALSA to do the
> > "heavy-lifting" of swapping the surround sound channels. If not, I'll
> > iterate through the PCM data, mapping the channels to the format expected
> > by ALSA.
>
>Currently, there is no setup API for multi-channel binding.  The
>channels are statically defined as FL/FR/RL/RR/C/LFE.
>
>It'd be of course nice to have an API for multi-channel binding.
>We can define either a read-only or a read-write API, namely,
>
>1. The driver provides a channel mapping information for multi-channel
>    device
>
>2. Apps can change channel bindings dynamically as they like
>
>In each case, we can keep the original FL/FR/RL/RR/C/LFE order as a
>fallback so that old apps still run without modification.

Thanks much for answering all my question. That is very helpful.


>If you have any API proposal, please let us know.


We don't currently have an API for channel mapping. I think ALSA devs. or 
the sound card driver devs. would be in a better position to design an API 
that the application can just use, but I'll keep that in mind, if I see 
something that is useful for the API.



-- 
Daniel Yek


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
