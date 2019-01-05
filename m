From: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH V2] usbcore: Select only first configuration for non-UAC3
 compliant devices
Date: Sun, 6 Jan 2019 09:02:05 +1100
Message-ID: <CABqErrEyF0Fr57gk12_XNNhLdQX0A9b9OPyGeVfGVh1dvHhRrw@mail.gmail.com>
References: <CABqErrHKFshAMBPHJp2vmGFE6k1GL1oDMSMbDRcBJNfUSxt9KQ@mail.gmail.com>
 <1546709942-28634-1-git-send-email-saranya.gopal@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546709942-28634-1-git-send-email-saranya.gopal@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gopal, Saranya" <saranya.gopal@intel.com>
Cc: gregkh@linuxfoundation.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, felipe.balbi@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi Saranya

On Sun, 6 Jan 2019 at 04:41, <saranya.gopal@intel.com> wrote:
>
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
> Fixes: f13912d3f014 ("usbcore: Select UAC3 configuration for audio if present")
> Reported-by: Con Kolivas <kernel@kolivas.org>
> Signed-off-by: Saranya Gopal <saranya.gopal@intel.com>>

I can confirm the above patch fixes my problem.
Tested-by: Con Kolivas <kernel@kolivas.org>

Thanks!
Con
