From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: smix plugin available?
Date: Wed, 27 Nov 2002 17:26:07 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211271708200.532-100000@pnote.perex-int.cz>
References: <E18H2PQ-0005AZ-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18H2PQ-0005AZ-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, Florian Bomers <Florian.Bomers@sun.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Nov 2002, Paul Davis wrote:

> i see this as more promising than the approach i think you are
> thinking of. you can't avoid the context switching - they *have* to
> happen so that the apps can run!! the question is *when* does it
> happen ... in JACK, they are initiated in a chain when the interface
> interrupts us. in the mserver model and/or the shared mmap'ed buffer
> approach, they just have to happen sometime between interrupts
> (otherwise the buffers are not handled in time). so there is no
> avoiding them, its just a matter of when they happen. the point of
> JACK's design is to force sample sync and to minimize latency - always
> generating and processing audio as close to when it is handled by the
> hardware as possible (hence the default 2 period setting). a model
> that allows the context switching to occur "sometime" between
> interrupts is more relaxed, but loses sample sync and slightly

Note that "sometime" means in same time as jack invokes the clients. The 
r/w applications blocks at the r/w or poll point, so they will be 
activated when the condition for the ring buffer is matched. Thus for 2 
periods - conditions are same as for jack.

Anyway, as Kai stated, we are reaching a consensus that both ways are 
useful for some cases.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
