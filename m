From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [alsa-devel] Asynchronous notification in
 ALSA - I/O Plugin - Pulseaudio
Date: Thu, 22 May 2008 14:11:11 +0100
Message-ID: <g13rdf$6os$1@ger.gmane.org>
References: <s5hfxsd9qt6.wl%tiwai@suse.de>	<18027403.3701211352364970.JavaMail.root@intra>	<s5hprrgvsre.wl%tiwai@suse.de>
	<20080521222936.GB12214@tango.0pointer.de>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
In-Reply-To: <20080521222936.GB12214@tango.0pointer.de>
List-Unsubscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=unsubscribe>
List-Archive: <https://tango.0pointer.de/pipermail/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@mail.0pointer.de>
List-Help: <mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=help>
List-Subscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=subscribe>
Sender: pulseaudio-discuss-bounces@mail.0pointer.de
Errors-To: pulseaudio-discuss-bounces@mail.0pointer.de
To: pulseaudio-discuss@mail.0pointer.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lennart Poettering wrote:
> On Wed, 21.05.08 12:47, Takashi Iwai (tiwai@suse.de) wrote:
> 
>>>> I have experimental patches to add async support to ioplug.  With a
>>>> quick test using jack plugin, it seems working somehow.  Will post
>>>> them alsa-devel now.
>>> Thank you!  I tested these with Firefox + Flash 9 + Pulseaudio, and while
>>> sound output works, quitting any Flash application will freeze firefox.
>> It's a showstopper, then.  Could you figure out in which code does it
>> freeze?  My change is just to add async call, so it sounds like that
>> another hidden bug is hit by my change...
> 
> That freeze is an unfixable race condition that Flash has when
> shutting down audio.
> 
> See the explanation down on http://pulseaudio.org/ticket/267

I thought the whole point was that by adding async code to ioplug, the 
libflashsupport stuff wasn't needed and flash could just use it's native 
alsa support + alsa's pulse plugin.... or am I missing the point here?

Col
