From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [alsa-devel][PATCH] ALSA: hda - Fix the headset mic jack
 detection on Dell machine
Date: Fri, 24 Jun 2016 08:35:24 -0700
Message-ID: <20160624153524.GA3285@kroah.com>
References: <1466755114-18477-1-git-send-email-woodrow.shen@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466755114-18477-1-git-send-email-woodrow.shen@canonical.com>
Sender: stable-owner@vger.kernel.org
To: woodrow.shen@canonical.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 24, 2016 at 03:58:34PM +0800, woodrow.shen@canonical.com wrote:
> From: Woodrow Shen <woodrow.shen@gmail.com>
> 
> The new Dell laptop with codec 3246 can't detect headset mic when
> headset was inserted on the machine. So adding pin configurations
> into quirk table makes headset mic work correctly.
> 
> Codec: Realtek ALC3246
> Vendor Id: 0x10ec0256
> Subsystem Id: 0x10280781
> 
> Signed-off-by: Woodrow Shen <woodrow.shen@canonical.com>
> ---
>  sound/pci/hda/patch_realtek.c | 4 ++++
>  1 file changed, 4 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
