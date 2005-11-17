From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Re: xxx_t replacement (was:ALSA SoC layer)
Date: Thu, 17 Nov 2005 10:03:00 +0100 (CET)
Message-ID: <XFMail.20051117100300.pochini@shiny.it>
References: <s5hoe4kqvmk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoe4kqvmk.wl%tiwai@suse.de>
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


On 16-Nov-2005 Takashi Iwai wrote:

> I'll merge my big patches tomorrow.  Please inform in time if you
> don't want it...

Yes, please leave echoaudio as is. I have a patch pending already which
I would like not to redo again. I'll send the xxx_t patch shortly after.


I'm only waiting for someone which can test these on a Layla 3G:

http://www.webalice.it/g_pochini/ead/alsa-driver-1.0.10.tar.bz2 [2.4MB]
http://www.webalice.it/g_pochini/ead/alsa-driver-1.0.10.tar.bz2.sig
 * or *
http://www.webalice.it/g_pochini/ead/echo_new_fw.patch [10KB]
http://www.webalice.it/g_pochini/ead/echo_new_fw.patch.sig

and the new firmware:

http://www.webalice.it/g_pochini/ead/alsa-firmware.tar.bz2 [1.6MB]
http://www.webalice.it/g_pochini/ead/alsa-firmware.tar.bz2.sig

- New firmware fixes pops and clicks with simultaneous MIDI and
audio I/O. There is now only one DSP firmware image for both
Gina3G and Layla3G.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick
