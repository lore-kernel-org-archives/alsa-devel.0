From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [alsa-devel] Need your advice: Add a new
 communication inteface between HD-Audio and Gfx drivers for hotplug
 notification/ELD update
Date: Fri, 24 Jan 2014 12:38:20 -0500
Message-ID: <CADnq5_ORNKQoXzUXGpMv-Uhe3JfnnB2T=3U3XJWZkzt4o2H7mw@mail.gmail.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B231778@SHSMSX101.ccr.corp.intel.com>
	<CAKMK7uFYNfVhXsEmikDZCaFGM8k7g7VMcGqGM4U+1bA_9MX1zQ@mail.gmail.com>
	<F46914AEC2663F4A9BB62374E5EEF8F82B23315E@SHSMSX101.ccr.corp.intel.com>
	<20140122141821.GI9772@phenom.ffwll.local>
	<s5hd2jkj5nt.wl%tiwai@suse.de>
	<F46914AEC2663F4A9BB62374E5EEF8F82B2342D7@SHSMSX101.ccr.corp.intel.com>
	<s5h38kfuo4a.wl%tiwai@suse.de>
	<CAKMK7uGT1My5hrVCZgnO5UGP5QQkXw=UBxxnaAdqTFTOxptCyw@mail.gmail.com>
	<CAN8cciYYMY-ojH3quSSZw9hqPig01RT=HcvhqEheNt+fX4nPuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <CAN8cciYYMY-ojH3quSSZw9hqPig01RT=HcvhqEheNt+fX4nPuA@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces@lists.freedesktop.org
Errors-To: intel-gfx-bounces@lists.freedesktop.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zanoni,
	Paulo R" <paulo.r.zanoni@intel.com>, Takashi Iwai <tiwai@suse.de>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, "Barnes,
	Jesse" <jesse.barnes@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 24, 2014 at 3:23 AM, Raymond Yau
<superquad.vortex2@gmail.com> wrote:
>
>>
>> >> And I have a question: how to assure the audio/gfx client find its
>> >> right peer?
>> >> On a x86 platform, there can be an integrated GPU and an discrete GPU.
>> >> So there can be two audio controllers and two GPUs.
>> >> We need to assure audio controller find the proper GPU, and vice versa.
>> >> Maybe we need the peer audio/gfx to register with a same identifier
>> >> (something like vendor ID) for peering.
>> >
>> > Yes, it's an open issue.  So far, the binding with vga_switcheroo is
>> > done by a rough guess with PCI ID.
>>
>> Yeah, I guess we need platform/bus specific hints.
>
>
> http://www.displayport.org/cables/driving-multiple-displays-from-a-single-displayport-output/
>
> How do the audio driver know which displays when a single displayport output
> can drive multiple displays ?

Generally, there is a back channel between the display hardware and
the audio hardware.

Alex
