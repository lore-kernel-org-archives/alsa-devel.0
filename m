From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] ALSA:usb audio Higher sample rates on usb audio no
 longer working.
Date: Fri, 4 Jan 2019 09:23:38 -0600
Message-ID: <5c7b2c6b-5dcc-7170-f6e1-bf6021bbb72a@linux.intel.com>
References: <CABqErrECNH+gRiZXM+z=igjAw895e7KLeV6H0EKvMkW0UsVvJw@mail.gmail.com>
 <s5hsgy96fiu.wl-tiwai@suse.de>
 <CABqErrHKFshAMBPHJp2vmGFE6k1GL1oDMSMbDRcBJNfUSxt9KQ@mail.gmail.com>
 <s5hd0pdey4e.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hd0pdey4e.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Con Kolivas <kernel@kolivas.org>
Cc: saranya.gopal@intel.com, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, felipe.balbi@linux.intel.com
List-Id: alsa-devel@alsa-project.org


> [ Adding linux-usb ML to Cc, as it's a core USB issue ]
>
> So the device seems incorrectly advertising as if it were supporting
> UAC3 -- assuming the device is still not UAC3-capable.
>
> IOW, it's a buggy firmware.  We need some blacklisting, or revert the
> commit for now, unless any real UAC3 device comes up to the market.

IIRC an UAC3-capable device is required to expose a backwards-compatible 
configuration (either UAC1 or UAC2). Maybe an additional test can be 
done to harden the detection so that UAC3 is only chosen if indeed a 
second audio configuration is present as well.

I also vaguely recall there was talk about adding information in the BOS 
descriptor, but I don't know if this was ever published.

-Pierre
