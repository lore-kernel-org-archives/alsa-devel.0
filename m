From: Tanu Kaskinen <tanu.kaskinen@jollamobile.com>
Subject: Re: [alsa-devel] Channel map API patches: to
 be 3.7 or not to be?
Date: Wed, 12 Sep 2012 20:20:10 +0300
Message-ID: <1347470410.14342.3.camel@laptop>
References: <s5hk3w1g4e2.wl%tiwai@suse.de>
	<CAN8cciYtoH91sFjwes+aTAjO+4z8CCMdOYgM4kdWbGNr3iuheQ@mail.gmail.com>
	<s5hbohdezpc.wl%tiwai@suse.de> <s5hehm8rc2s.wl%tiwai@suse.de>
	<504F2C65.1090204@ladisch.de> <s5hbohcrbme.wl%tiwai@suse.de>
	<s5hbohb1b5e.wl%tiwai@suse.de> <5050B91A.7020303@ladisch.de>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <5050B91A.7020303@ladisch.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-09-12 at 18:32 +0200, Clemens Ladisch wrote:
> Takashi Iwai wrote:
> >> Clemens Ladisch wrote:
> >>> Takashi Iwai wrote:
> >>>>   is it useful to add SND_CHMAP_MONO, or is it just redundant?
> >>>
> >>> What would it be used for?
> >
> > Looking at PulseAudio and gstreamer codes, they seem to have explicit
> > MONO channel definition.
> > [...]
> > So, defining MONO seems rather standard.  Now I'm inclined to define
> > SND_CHMAP_MONO...
> 
> Okay; if they want it, they can get it ...

Speaking as a PulseAudio developer, "wanting" is a bit strong word. I
initially wanted it, but I don't anymore think that it's necessary. I
don't think it will do any harm either, though...

-- 
Tanu
