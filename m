From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: [alsa-devel] pulseaudio eats 19% CPU power
	in Fedora 12
Date: Sun, 18 Apr 2010 23:38:40 -0400
Message-ID: <k2q604760771004182038n72eec9bdy77a9e4faf2152ee4@mail.gmail.com>
References: <20100414075658.GA26283@localhost>
	<20100419032856.GA13629@tango.0pointer.de>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
In-Reply-To: <20100419032856.GA13629@tango.0pointer.de>
List-Unsubscribe: <https://tango.0pointer.de/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=unsubscribe>
List-Archive: <https://tango.0pointer.de/pipermail/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@mail.0pointer.de>
List-Help: <mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=help>
List-Subscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=subscribe>
Sender: pulseaudio-discuss-bounces@mail.0pointer.de
Errors-To: pulseaudio-discuss-bounces@mail.0pointer.de
To: Wu Fengguang <fengguang.wu@intel.com>, pulseaudio-discuss@mail.0pointer.de, "Fu, Michael" <michael.fu@intel.com>, alsa-devel@alsa-project.org, "He, Shuang" <shuang.he@intel.com>, Bu,
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 18, 2010 at 11:28 PM, Lennart Poettering <mznyfn@0pointer.de> wrote:
> On Wed, 14.04.10 15:56, Wu Fengguang (fengguang.wu@intel.com) wrote:
>> I can find many users
>> complaining about this, and it seems like some fix is available in
>> this link:
>> https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/207135
>
> Fix? Where?

Sigh, another drivel of a bug report with a mis-summary. It really
ought to be "For Ubuntu 9.04, the sampler was changed to X". (Note
that it's speex-float-1 in 9.10 and newer.) I have seen plenty of bugs
in hardware, some of which can be worked around in the driver -- for
these I've been pushing patches here and to stable@ -- but, like
Lennart suggests, these are by no means *caused* by PulseAudio.

Best,
-Dan
