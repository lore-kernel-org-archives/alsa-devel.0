From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: [PATCH] USB MIDI driver
Date: Wed, 03 Jul 2002 16:42:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D230D63.8ED93F9D@ladisch.de>
References: <3D208C5C.36649172@ladisch.de> <s5hhejibem0.wl@alsa2.suse.de>
 <s5hznxarxmz.wl@alsa2.suse.de> <3D22F37D.14EE3DAB@ladisch.de>
 <s5hk7odrlu1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > and virmidi with SNDRV_VIRMIDI_SEQ_ATTACH doesn't support input anyway,
> 
> hmm, this mode wasn't tested, too.  usb-midi is the first case.
> doesn't rawmidi read work at all?

The driver calls snd_seq_kernel_client_dispatch() to get rid of an event.
To receive a sequencer event, virmidi would need its own sequencer client
(or port), like it does with SNDRV_VIRMIDI_SEQ_DISPATCH, but then we would
have two sequencer clients.

Alternatively, usb-midi could call snd_virmidi_receive() directly, but that
smells somewhat like a hack. (I've noticed that snd_virmidi_receive() isn't
declared static, although it isn't exported either. :-)


Clemens


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
No, I will not fix your computer.
http://thinkgeek.com/sf
