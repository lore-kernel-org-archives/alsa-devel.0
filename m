From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ALSA: hda - Add inverted internal mic quirk for Lenovo
 IdeaPad U310
Date: Tue, 25 Sep 2012 19:05:26 -0700
Message-ID: <20120926020526.GA21782@kroah.com>
References: <1348615244-26952-1-git-send-email-felix@fetzig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1348615244-26952-1-git-send-email-felix@fetzig.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Felix Kaechele <felix@fetzig.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 26, 2012 at 01:20:44AM +0200, Felix Kaechele wrote:
> The Lenovo IdeaPad U310 has an internal mic where the right channel
> is phase inverted.
> 
> Signed-off-by: Felix Kaechele <felix@fetzig.org>
> ---
>  sound/pci/hda/patch_conexant.c | 1 +
>  1 file changed, 1 insertion(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
