From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: Q1: Linked streams and drivers
Date: Fri, 2 Feb 2007 09:19:34 +1300
Message-ID: <200702020919.35105.linux@audioscience.com>
References: <45C15EF5.5010904@audioscience.com> <s5hodoekm9p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hodoekm9p.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 02 February 2007 03:03, Takashi Iwai wrote:
> At Thu, 01 Feb 2007 16:31:01 +1300,

>
> A PCM substream has a linked list of link members (via struct
> snd_pcm_group).  The macro, snd_pcm_group_for_each(), gives you the
> loop for checking each list memeber.
>
> When a driver supports the hardware-linked substreams, it needs to
> check whether multiple streams exist in that substream.  Set
> snd_pcm_trigger_done() at each stream, and trigger once.
>
> You can see examples in the driver implementations.  Grep
> snd_pcm_group_for_each() under alsa-kernel/pci directory.

Thanks Takashi,

I see that the above loops are in the trigger callbacks of the drivers.

But I wonder if the linked status known at hwparams or prepare callback.
This is because I need to send a message to our card to group each pair of 
streams,  I think this should not be in the trigger callback.

I.e.  group(stream0,stream1); group(stream0,stream2) etc

After this, start and stop commands on any stream in the group operate on them 
all simultaneously, and the simultaneous start is sample accurate.

I'd prefer to do this earlier in the setup process than at trigger callback.
-- 
--
Eliot Blennerhassett
AudioScience Inc.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
