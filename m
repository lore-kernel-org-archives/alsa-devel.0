From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] Use rawmidi device name for sequencer client
 name
Date: Thu, 28 Nov 2002 18:12:04 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211281805100.24653-100000@studcom.urz.uni-halle.de>
References: <s5hptspzmrc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hptspzmrc.wl@alsa2.suse.de>
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
> > The maybe we could add the card number or id to the string.
> > "MPU-401 (card42)" would be better than "External MIDI 42-0".
>
> ok, now, the question is whether this "(cardx)" is included in each
> rawmidi name or put in seq_midi.c.
> if we use the rawmidi name with the card id, each rawmidi creator
> should be responsible.

You already mentioned that the rawmidi name for USB devices is more unique
(although it's easy to plug in several identical devices), so I think it
should be handled by the rawmidi driver.

And having different names for rawmidi and sequencer would be
inconsistent.


Regards,
Clemens



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
