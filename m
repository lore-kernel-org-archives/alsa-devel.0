From: Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [PATCH 1/2] Fix an OOB bug in parse_audio_mixer_unit
Date: Sun, 1 Sep 2019 14:58:09 +0200
Message-ID: <20190901125809.GA23334@eldamar.local>
References: <20190830214649.27761-1-benquike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190830214649.27761-1-benquike@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Hui Peng <benquike@gmail.com>
Cc: stable@vger.kernel.org, Mathias Payer <mathias.payer@nebelwelt.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wenwen Wang <wang6495@umn.edu>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 30, 2019 at 05:46:49PM -0400, Hui Peng wrote:
> The `uac_mixer_unit_descriptor` shown as below is read from the
> device side. In `parse_audio_mixer_unit`, `baSourceID` field is
> accessed from index 0 to `bNrInPins` - 1, the current implementation
> assumes that descriptor is always valid (the length  of descriptor
> is no shorter than 5 + `bNrInPins`). If a descriptor read from
> the device side is invalid, it may trigger out-of-bound memory
> access.
> 
> ```
> struct uac_mixer_unit_descriptor {
> 	__u8 bLength;
> 	__u8 bDescriptorType;
> 	__u8 bDescriptorSubtype;
> 	__u8 bUnitID;
> 	__u8 bNrInPins;
> 	__u8 baSourceID[];
> }
> ```
> 
> This patch fixes the bug by add a sanity check on the length of
> the descriptor.
> 
> CVE: CVE-2018-15117

FWIW, the correct CVE id should be probably CVE-2019-15117 here.

But there was already a patch queued and released in 5.2.10 and
4.19.68 for this issue (as far I can see; is this correct?)

Regards,
Salvatore
