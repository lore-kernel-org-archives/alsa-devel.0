From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] Use rawmidi device name for sequencer client
 name
Date: Thu, 28 Nov 2002 17:00:35 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211281650360.20371-100000@studcom.urz.uni-halle.de>
References: <s5h1y5522zq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5h1y5522zq.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > The snd_seq_midisynth_register_port() function already knows the name of
> > the rawmidi device, so there is no reason to invent another name for the
> > sequencer client.
>
> the reason was that many rawmidi devices give the same name even if
> there are many.  for example, mpu401 sets only "MPU-401 (UART)" as its
> name.
> although the card can be distinguished by the client number, it would
> be better to be able to know only from its name string.

The maybe we could add the card number or id to the string.
"MPU-401 (card42)" would be better than "External MIDI 42-0".


Regards,
Clemens



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
