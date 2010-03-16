From: Dan Armbrust <daniel.armbrust.list@gmail.com>
Subject: Re: Configuration help please?
Date: Tue, 16 Mar 2010 09:32:22 -0500
Message-ID: <82f04dc41003160732i61a35d11r96f38025ee7f0097@mail.gmail.com>
References: <82f04dc41003150711m53b675f6g59c54d142cca77b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id D743F24427
	for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2010 15:32:24 +0100 (CET)
Received: by bwz7 with SMTP id 7so4121856bwz.4
	for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2010 07:32:24 -0700 (PDT)
In-Reply-To: <82f04dc41003150711m53b675f6g59c54d142cca77b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 15, 2010 at 9:11 AM, Dan Armbrust
<daniel.armbrust.list@gmail.com> wrote:
> Hi,
>
> I'm trying to configure a mythtv box to send sound to my spdif port
> AND my analog stereo speakers.
>
> In order to make the spdif port work, I found I needed this in /etc/asoun=
d.conf:
>
>
> #----
> pcm.!default {
> =A0 =A0type plug
> =A0 =A0slave.pcm "spdif"
> =A0}
>
> #----
>
> I thought maybe this would work to send the sound to both....
>
> #----
> pcm.!default {
> =A0 =A0type plug
> =A0 =A0slave.pcm "front"
> =A0 =A0slave.pcm "spdif"
> =A0}
> #----
>
> But that was a little naive... apparently. =A0The sound just goes to
> whichever item I put last.
>
> I know right next to nothing about writing alsa config files... and
> every example I find is very large, very complicated looking, and
> doesn't do what I want.
>
> Can someone tell me how to configure alsa for this?
>
> What I want - exactly - Sound to always go to both the "front" (my 2
> channel stereo speakers), and my spdif output, with anywhere between 1
> and 5.1 channels... depending on what my source audio has. =A0I also
> want mythtv to pass the full 5.1 channels from HD to the spdif port,
> while sending the stereo sound to the analog.
>
> Some info:
>
> # aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: Intel [HDA Intel], device 0: ALC888 Analog [ALC888 Analog]
> =A0Subdevices: 1/1
> =A0Subdevice #0: subdevice #0
> card 0: Intel [HDA Intel], device 1: ALC888 Digital [ALC888 Digital]
> =A0Subdevices: 0/1
> =A0Subdevice #0: subdevice #0
>
>
> #aplay -L
> front:CARD=3DIntel,DEV=3D0
> =A0 HDA Intel, ALC888 Analog
> =A0 Front speakers
> surround40:CARD=3DIntel,DEV=3D0
> =A0 HDA Intel, ALC888 Analog
> =A0 4.0 Surround output to Front and Rear speakers
> surround41:CARD=3DIntel,DEV=3D0
> =A0 HDA Intel, ALC888 Analog
> =A0 4.1 Surround output to Front, Rear and Subwoofer speakers
> surround50:CARD=3DIntel,DEV=3D0
> =A0 HDA Intel, ALC888 Analog
> =A0 5.0 Surround output to Front, Center and Rear speakers
> surround51:CARD=3DIntel,DEV=3D0
> =A0 HDA Intel, ALC888 Analog
> =A0 5.1 Surround output to Front, Center, Rear and Subwoofer speakers
> surround71:CARD=3DIntel,DEV=3D0
> =A0 HDA Intel, ALC888 Analog
> =A0 7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
> iec958:CARD=3DIntel,DEV=3D0
> =A0 HDA Intel, ALC888 Digital
> =A0 IEC958 (S/PDIF) Digital Audio Output
> null
> =A0 Discard all samples (playback) or generate zero samples (capture)
>
>
> Thanks!
>
> Dan
>


Hello?

Is this really a hard thing that I'm asking to do?  No one can help me
configure alsa?

Thanks,

Dan
