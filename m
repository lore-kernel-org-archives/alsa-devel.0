From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: Need your advice: Add a new communication inteface
 between HD-Audio and Gfx drivers for hotplug notification/ELD update
Date: Thu, 23 Jan 2014 09:26:56 +0100
Message-ID: <CAKMK7uGT1My5hrVCZgnO5UGP5QQkXw=UBxxnaAdqTFTOxptCyw@mail.gmail.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B231778@SHSMSX101.ccr.corp.intel.com>
	<CAKMK7uFYNfVhXsEmikDZCaFGM8k7g7VMcGqGM4U+1bA_9MX1zQ@mail.gmail.com>
	<F46914AEC2663F4A9BB62374E5EEF8F82B23315E@SHSMSX101.ccr.corp.intel.com>
	<20140122141821.GI9772@phenom.ffwll.local>
	<s5hd2jkj5nt.wl%tiwai@suse.de>
	<F46914AEC2663F4A9BB62374E5EEF8F82B2342D7@SHSMSX101.ccr.corp.intel.com>
	<s5h38kfuo4a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <s5h38kfuo4a.wl%tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces@lists.freedesktop.org
Errors-To: intel-gfx-bounces@lists.freedesktop.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zanoni,
	Paulo R" <paulo.r.zanoni@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, "Barnes,
	Jesse" <jesse.barnes@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 23, 2014 at 8:57 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> Thanks for clarification!
>> Maybe we can add output info (eg. display port number) to the eld entries under /proc/asound/cardx. Is it okay?
>
> It's possible, but the proc file is just a help.  It can't be the
> API.  For accessing the information, we'll need some new API, or let
> inform via sysfs of the new device.

Links in sysfs sound like the best approach. drm already has nodes for
each connector, so on the gfx side there's a natural endpoint already.
sysfs links also avoids any naming issues from the start, e.g. the
above DP connector id might lead to clashes with multiple cards.

>> And I have a question: how to assure the audio/gfx client find its right peer?
>> On a x86 platform, there can be an integrated GPU and an discrete GPU. So there can be two audio controllers and two GPUs.
>> We need to assure audio controller find the proper GPU, and vice versa. Maybe we need the peer audio/gfx to register with a same identifier (something like vendor ID) for peering.
>
> Yes, it's an open issue.  So far, the binding with vga_switcheroo is
> done by a rough guess with PCI ID.

Yeah, I guess we need platform/bus specific hints. E.g. on x86 we
could use the pci id of the gfx card + enumeration of all the audio
input pins (and just hope that there's no one insane enough to route
different codecs to the same gfx card or something like that). On ARM
we could just fish device refernences out of dt. So probably we need
some platform specific code to fish out the right avsink from the
audio side.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
