From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 1/2] ALSA: add LaCie Firewire Speakers/Griffin FireWave
	surround driver
Date: Mon, 7 Feb 2011 15:40:25 +0100
Message-ID: <20110207154025.13fdeba3@stein>
References: <4D46933D.5050609@ladisch.de> <4D4FB7C8.7090501@ladisch.de>
	<4D4FB7F6.8000801@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4D4FB7F6.8000801@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, Jay Fenlason <fenlason@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Feb 07 Clemens Ladisch wrote:
> Add a driver for two playback-only FireWire devices based on the OXFW970
> chip.
> 
> v2: Better AMDTP API abstraction; fix fw_unit leak; small fixes.
>     Two- and four-channel output on the FireWave is experimental.
> 
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
> ---
>  drivers/firewire/core-iso.c     |    1
>  drivers/firewire/core.h         |    3
>  include/linux/firewire.h        |    7
>  sound/Kconfig                   |    2
>  sound/Makefile                  |    2
>  sound/firewire/Kconfig          |   25 +
>  sound/firewire/Makefile         |    6
>  sound/firewire/amdtp.c          |  511 ++++++++++++++++++++++++++++++++
>  sound/firewire/amdtp.h          |  151 +++++++++
>  sound/firewire/cmp.c            |  316 +++++++++++++++++++
>  sound/firewire/cmp.h            |   40 ++
>  sound/firewire/fcp.c            |  223 +++++++++++++
>  sound/firewire/fcp.h            |   12
>  sound/firewire/iso-resources.c  |  224 ++++++++++++++
>  sound/firewire/iso-resources.h  |   39 ++
>  sound/firewire/lib.c            |   68 ++++
>  sound/firewire/lib.h            |   19 +
>  sound/firewire/packets-buffer.c |   74 ++++
>  sound/firewire/packets-buffer.h |   26 +
>  sound/firewire/speakers.c       |  484 ++++++++++++++++++++++++++++++
>  20 files changed, 2229 insertions(+), 4 deletions(-)
[...]
> --- a/drivers/firewire/core-iso.c
> +++ b/drivers/firewire/core-iso.c
> @@ -369,3 +369,4 @@ void fw_iso_resource_manage(struct fw_ca
>  		*channel = ret;
>  	}
>  }
> +EXPORT_SYMBOL(fw_iso_resource_manage);
> --- a/drivers/firewire/core.h
> +++ b/drivers/firewire/core.h
> @@ -147,9 +147,6 @@ void fw_node_event(struct fw_card *card,
>  /* -iso */
>  
>  int fw_iso_buffer_map(struct fw_iso_buffer *buffer, struct vm_area_struct *vma);
> -void fw_iso_resource_manage(struct fw_card *card, int generation,
> -			    u64 channels_mask, int *channel, int *bandwidth,
> -			    bool allocate, __be32 buffer[2]);
>  
>  
>  /* -topology */
> --- a/include/linux/firewire.h
> +++ b/include/linux/firewire.h
> @@ -42,6 +42,10 @@
>  #define CSR_BROADCAST_CHANNEL		0x234
>  #define CSR_CONFIG_ROM			0x400
>  #define CSR_CONFIG_ROM_END		0x800
> +#define CSR_OMPR			0x900
> +#define CSR_OPCR(i)			(0x904 + (i) * 4)
> +#define CSR_IMPR			0x980
> +#define CSR_IPCR(i)			(0x984 + (i) * 4)
>  #define CSR_FCP_COMMAND			0xB00
>  #define CSR_FCP_RESPONSE		0xD00
>  #define CSR_FCP_END			0xF00
> @@ -441,5 +445,8 @@ int fw_iso_context_start(struct fw_iso_c
>  			 int cycle, int sync, int tags);
>  int fw_iso_context_stop(struct fw_iso_context *ctx);
>  void fw_iso_context_destroy(struct fw_iso_context *ctx);
> +void fw_iso_resource_manage(struct fw_card *card, int generation,
> +			    u64 channels_mask, int *channel, int *bandwidth,
> +			    bool allocate, __be32 buffer[2]);
>  
>  #endif /* _LINUX_FIREWIRE_H */
[...]

The firewire subsystem parts of this patch and their being routed through
the ALSA development repository are fine with me.  The export of
fw_iso_resource_manage is also going to be needed by
drivers/media/dvb/firewire/firedtv* eventually (maintained through the
v4l-dvb tree), but I suppose my lack of development speed with firedtv
will prevent any conflicts (which would be trivial to resolve in git
anyway).  Hence,

Acked-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

I am going to test this driver with LaCie FireWire Speakers and Griffin
FireWave RSN.  BTW, FireWave is a 6-channel-out device which is targeted to
be used on OS X as either a stereo or a 5.1-Dolby-surround output.  I heard
that the 5.1 mode is configured by a vendor-specific AV/C command.  (The
FireWave was sold with an OS X driver; without this vendor driver it just
works as a stereo-out soundcard with OS X' stock driver.)
-- 
Stefan Richter
-=====-==-== --=- --===
http://arcgraph.de/sr/

------------------------------------------------------------------------------
The modern datacenter depends on network connectivity to access resources
and provide services. The best practices for maximizing a physical server's
connectivity to a physical network are well understood - see how these
rules translate into the virtual world? 
http://p.sf.net/sfu/oracle-sfdevnlfb
