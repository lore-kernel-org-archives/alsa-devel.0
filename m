From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ALSA: hda - Add headset mic quirk for Dell Inspiron 5468
Date: Mon, 29 Aug 2016 13:36:45 +0200
Message-ID: <20160829113645.GA15460@kroah.com>
References: <1472455167-13643-1-git-send-email-shrirang.bagul@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472455167-13643-1-git-send-email-shrirang.bagul@canonical.com>
Sender: stable-owner@vger.kernel.org
To: Shrirang Bagul <shrirang.bagul@canonical.com>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 29, 2016 at 03:19:27PM +0800, Shrirang Bagul wrote:
> This patch enables headset microphone on some variants of
> Dell Inspiron 5468. (Dell SSID 0x07ad)
> 
> BugLink: https://bugs.launchpad.net/bugs/1617900
> Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
> ---
>  sound/pci/hda/patch_realtek.c | 4 ++++
>  1 file changed, 4 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
