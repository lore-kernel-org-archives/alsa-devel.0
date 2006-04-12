From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: seq_midi client names
Date: Wed, 12 Apr 2006 17:59:48 +0200
Message-ID: <20060412155948.GB21693@turing.informatik.uni-halle.de>
References: <200604121402.48859.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200604121402.48859.gineera@aspect135.co.uk>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Alan Horstmann wrote:
> AFAICT in seq_midi.c 'snd_seq_midisynth_register_port' occurs first for the 
> 2nd port, and has NULL client, so (L322) calls 
> 'snd_seq_create_kernel_client', passing info->name as the string augument, 
> which is actually the specific port name.

info->name is the device name, the port name would be info->subname
(which isn't set for most single-port devices).

When there is more than one RawMIDI port, it would make sense to use a
(common) client name that is card specific rather than port specific.
I hope this wouldn't be too confusing for cards that have only one MIDI
port.

> Attached diff shows changing it to card->id for example;
> card->shortname would be similar, both give a more reasonable client
> name.

The id is just an internal identifier, shortname would be better.

> Is it correct for client to be NULL in this way?

Yes, the client must be created at some time.


Regards,
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
