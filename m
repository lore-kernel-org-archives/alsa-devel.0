From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/pci/ca0106 ca_midi.c,...
Date: Fri, 21 Oct 2005 11:00:03 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0510211055090.4731-100000@studcom.urz.uni-halle.de>
References: <E1ESiQD-0008Jo-Eq@sc8-pr-cvs1.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1ESiQD-0008Jo-Eq@sc8-pr-cvs1.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tilman Kranz <tilde@tk-sls.de>, James Courtier-Dutton <jcdutton@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> Log Message:
> Summary: snd-ca0106: Add midi support.

Some nitpicks:

> void ca_midi_interrupt(ca_midi_t *midi, unsigned int status) {
> 	...
> 	if ((status & midi->ipr_tx) && ca_midi_output_ready(midi)) {
> 		if (midi->substream_output &&
> 		    snd_rawmidi_transmit(midi->substream_output, &byte, 1) == 1) {
> 			ca_midi_write_data(midi, byte);
> 		} else {
> 			midi->interrupt_disable(midi,midi->tx_enable);
> 		}
> 	}

Shouldn't this be a while loop so that more than one byte can be
output in one interrupt?

> +#ifdef CONFIG_SND_DEBUG_DETECT
> +	printk("ca0106: probe for MIDI channel A ...");
> +#endif

Please use snd_printdd() here.


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
