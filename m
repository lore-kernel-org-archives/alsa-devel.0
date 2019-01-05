From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usbcore: Select only first configuration for non-UAC3
 compliant devices
Date: Sat, 5 Jan 2019 15:35:39 +0100
Message-ID: <20190105143539.GC22044@kroah.com>
References: <CABqErrHKFshAMBPHJp2vmGFE6k1GL1oDMSMbDRcBJNfUSxt9KQ@mail.gmail.com>
 <1546696957-28294-1-git-send-email-saranya.gopal@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546696957-28294-1-git-send-email-saranya.gopal@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: saranya.gopal@intel.com
Cc: kernel@kolivas.org, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, tiwai@suse.de, felipe.balbi@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 05, 2019 at 07:32:37PM +0530, saranya.gopal@intel.com wrote:
> From: Saranya Gopal <saranya.gopal@intel.com>
> 
> In most of the UAC1 and UAC2 audio devices, the first
> configuration is most often the best configuration.
> However, with recent patch to support UAC3 configuration,
> second configuration was unintentionally chosen for
> some of the UAC1/2 devices that had more than one
> configuration. This was because of the existing check
> after the audio config check which selected any config
> which had a non-vendor class. This patch fixes this issue.
> 
> Fixes: f13912d (Select UAC3 configuration for audio if present)

That should read:
	Fixes: f13912d3f014 ("usbcore: Select UAC3 configuration for audio if present")

Please use the full commit name and more sha1 numbers :)

thanks,

greg k-h
