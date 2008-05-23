From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [alsa-devel] Asynchronous notification in
 ALSA - I/O Plugin - Pulseaudio
Date: Fri, 23 May 2008 10:07:39 +0100
Message-ID: <g161h9$t4i$1@ger.gmane.org>
References: <s5hfxsd9qt6.wl%tiwai@suse.de>	<18027403.3701211352364970.JavaMail.root@intra>	<s5hprrgvsre.wl%tiwai@suse.de>	<20080521222936.GB12214@tango.0pointer.de>	<g13rdf$6os$1@ger.gmane.org>
	<20080522135951.GA16685@tango.0pointer.de>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
In-Reply-To: <20080522135951.GA16685@tango.0pointer.de>
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
> On Thu, 22.05.08 14:11, Colin Guthrie (gmane@colin.guthr.ie) wrote:
>> I thought the whole point was that by adding async code to ioplug, the 
>> libflashsupport stuff wasn't needed and flash could just use it's native 
>> alsa support + alsa's pulse plugin.... or am I missing the point here?
> 
> The destruction dead lock issue is present both in libflashsupport and
> the native ALSA backend. It's just that it is almost never triggered
> if a hw device is used.

Ahhhhhhhhh :)

Col
