From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [V2 2/2] vgaswitchreoo: set audio client id in
 vgaswitchreoo enable function
Date: Mon, 16 Jul 2018 16:43:42 +0200
Message-ID: <20180716144342.GA23508@wunner.de>
References: <1531721195-4982-1-git-send-email-Jim.Qu@amd.com>
 <1531721195-4982-2-git-send-email-Jim.Qu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net
 [83.223.95.100])
 by alsa0.perex.cz (Postfix) with ESMTP id B63DC2675CF
 for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2018 16:43:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1531721195-4982-2-git-send-email-Jim.Qu@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jim Qu <Jim.Qu@amd.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 16, 2018 at 02:06:35PM +0800, Jim Qu wrote:
> +
> +	list_for_each_entry(client, &vgasr_priv.clients, list) {
> +		if (!client_is_audio(client) || client_id(client) !=
> +			VGA_SWITCHEROO_UNKNOWN_ID)

Don't you have to check for

      client_id(client) != VGA_SWITCHEROO_UNKNOWN_ID | ID_BIT_AUDIO

here?  That's the value you assign when the audio client registers,
yet you're checking for something else, so you're always skipping
over audio clients.  Did you actually test this patch?


> On modern laptop, there are more and more platforms
> have two GPUs, and each of them maybe have audio codec
> for HDMP/DP output. For some dGPU which is no output,
> audio codec usually is disabled.
> 
> In currect HDA audio driver, it will set all codec as
> VGA_SWITCHEROO_DIS, the audio which is binded to UMA
> will be suspended if user use debugfs to control power
> 
> In HDA driver side, it is difficult to know which GPU
> the audio has bound to. So set the bound gpu pci dev
> to vgaswitchreoo, the correct audio id will be set in
> vgaswitchreoo enable function.
> 
> Signed-off-by: Jim Qu <Jim.Qu@amd.com>

Apart from the issue above and that this approach doesn't work if
hda_intel registers after the two GPUs, some nits:

vgaswitchreoo => vga_switcheroo multiple times above and in the subject.


> --- a/drivers/gpu/vga/vga_switcheroo.c
> +++ b/drivers/gpu/vga/vga_switcheroo.c
> @@ -103,6 +103,7 @@
>   *	runtime pm. If true, writing ON and OFF to the vga_switcheroo debugfs
>   *	interface is a no-op so as not to interfere with runtime pm
>   * @list: client list
> + * @vga_dev: pci device, indicate which GPU is bound to current audio client
>   *
>   * Registered client. A client can be either a GPU or an audio device on a GPU.
>   * For audio clients, the @fb_info and @active members are bogus.

Please add a note here that vga_dev is bogus for GPU clients.


> @@ -192,14 +193,28 @@ static void vga_switcheroo_enable(void)
>  		vgasr_priv.handler->init();
>  
>  	list_for_each_entry(client, &vgasr_priv.clients, list) {
> -		if (client->id != VGA_SWITCHEROO_UNKNOWN_ID)
> +		if (!client_is_vga(client) || client_id(client) !=
> +			VGA_SWITCHEROO_UNKNOWN_ID)

Readability might improve if you break the line like this:

		if (!client_is_vga(client) ||
		    client_id(client) != VGA_SWITCHEROO_UNKNOWN_ID)


> @@ -339,9 +357,10 @@ EXPORT_SYMBOL(vga_switcheroo_register_client);
>   */
>  int vga_switcheroo_register_audio_client(struct pci_dev *pdev,
>  			const struct vga_switcheroo_client_ops *ops,
> -			enum vga_switcheroo_client_id id)
> +			struct pci_dev *vga_dev)
>  {
> -	return register_client(pdev, ops, id | ID_BIT_AUDIO, false, true);
> +	return register_client(pdev, ops, VGA_SWITCHEROO_UNKNOWN_ID |
> +			ID_BIT_AUDIO, vga_dev, false, true);

Again, I'd break the line such that the two operands to the bitwise or
are on the same line:

	return register_client(pdev, ops,
			       VGA_SWITCHEROO_UNKNOWN_ID | ID_BIT_AUDIO,
			       vga_dev, false, true);

Lukas
