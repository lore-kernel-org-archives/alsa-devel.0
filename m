From: "Stephen Warren" <SWarren@nvidia.com>
Subject: RE: New azx driver: Problems in snd_mixer_load
Date: Fri, 10 Dec 2004 14:16:45 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0033AE20A@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

OK. Now I really have the latest code, and it works well for me. Weird
there's no volume control in the HW!

I have a reproducable kernel oops though.

I run alsamixer, and it gives me "columns" for:

PCM Surround Center LFE Capture Capture "Input Source" "Input Source"

As expected, I can manipulate the mute on the first 4, but not adjust
the volume value.

If I select the first "Input Source", and change the selected source, it
starts out by default as "Front Mic", then changes to "Rear Mic", then
to "CD", then if I attempt to change it once more, I get a kernel oops.

Unfortunately, I can't get ksymoops to do anything really useful - it
refuses to load symbols from /proc/kallsyms... What version should I be
used of ksymoops? The latest I can find is 2.4.10, and I also tried
2.4.9, since the kernel.org directory it's in said that was the latest
even though there was a newer version...

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
