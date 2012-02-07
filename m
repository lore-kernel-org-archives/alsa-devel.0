From: "Heasley, Seth" <seth.heasley@intel.com>
Subject: RE: [alsa-devel] [PATCH 1/6] hda_intel: Add Lynx Point HD Audio
 Controller DeviceIDs
Date: Tue, 7 Feb 2012 00:13:10 +0000
Message-ID: <DEC3922D1904474A8862C7BFF516EA9A37FB3863@ORSMSX101.amr.corp.intel.com>
References: <201201231624.31275.seth.heasley@intel.com>
	<4F1E7DC0.5060208@canonical.com> <s5h7h0h2znx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h7h0h2znx.wl%tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "perex@perex.cz" <perex@perex.cz>, "Ralston, James D" <james.d.ralston@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

>> > This patch adds the HD Audio DeviceIDs for the Intel Lynx Point PCH.
>>
>> Thanks. As we asked for oak trail: can you confirm you prefer DMA
>> Position buffers for detecting current playback/recording position,
>over
>> using the LPIB register?
>
>Yes, thanks for the notice.
>
>I guess this won't need it since it's the successor of PPT.
>But it's always good to check it for the new hardware, indeed.

I'm also in favor of not rocking the boat, but I'm curious what changing this would entail, and what would be the advantage or rationale for making the change?

-Seth
