From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/2] ALSA: include/linux/usb/audio.h: add
 __attribute__((packed))
Date: Wed, 12 May 2010 00:50:54 +0200
Message-ID: <20100511225054.GL30801@buzzloop.caiaq.de>
References: <1273594430-9356-1-git-send-email-daniel@caiaq.de>
	<s5hd3x2p3ds.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id B76A210380A
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 00:51:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hd3x2p3ds.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Tue, May 11, 2010 at 10:52:47PM +0200, Takashi Iwai wrote:
> At Tue, 11 May 2010 18:13:49 +0200,
> Daniel Mack wrote:
> > 
> > This was missing on the definition of struct uac_iso_endpoint_descriptor
> > 
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > Cc: Takashi Iwai <tiwai@suse.de>
> > Cc: Clemens Ladisch <clemens@ladisch.de>
> 
> Applied these fixes now.  Thanks.

Thanks! One of the noted TODOs is that UAC2 offers the ability to a
device to dynamically change the supported range of options for a given
control. So an enum-driven control can get new values, lose some,
whatever. What would be the best way to map that to ALSA controls?

Another thing that we would need to support at some time is clock
selectors to switch from an internal clock to some external one. And
this can also be notfied dynamically - so for example: once an external
S/PDIF transmitter is connected, the driver gets informed about a new
valid clock source. I haven't found anything how this could be passed on
to higher levels from a driver, but I might have missed something :)

Daniel
