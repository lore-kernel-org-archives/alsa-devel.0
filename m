From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Support for the Bluetooth subband codec (SBC)
Date: Mon, 08 Nov 2004 14:31:52 +0100
Message-ID: <1099920713.6896.143.camel@pegasus>
References: <1099878354.6896.80.camel@pegasus>
	 <Pine.LNX.4.58.0411081155020.2162@pnote.perex-int.cz>
	 <1099915747.6896.113.camel@pegasus>
	 <Pine.LNX.4.58.0411081326500.2162@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411081326500.2162@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

> > I don't think that this is linear PCM, but actually I am no expert when
> > it comes to codec specific stuff. I would be great if you can take a
> > look at it and tell me what you think how we should support it.
> 
> I see - SBC is an audio compression. It should be implemented in alsa-lib 
> as you suggested.

my idea is to add a snd_pcm_t for every stream endpoint and then set the
type of the snd_pcm_hardware_t to SBC at runtime. The ALSA library then
must do the audio compression, rate conversion etc.

However my current problem is that SBC type has some codec specific
information elements (A2DP, page 20) and I don't know for some of them
how we should support them. For all that don't have the specification
these information are:

	- Sampling Frequency
		- 16000, 32000, 441000 and 48000 Hz
	- Channel Mode
		- Mono, Dual channel, Stereo, Joint stereo
	- Block Length
		- 4, 8, 12 and 16
	- Subbands
		- 4 and 8
	- Allocation Method
		- SNR and Loudness
	- Minimum Bitpool Value
	- Maximum Bitpool Value
		- Both are ranging from 2 to 250

Some of these settings are mandatory to support and some of them are
optional.

The only clear value for me is the sampling frequency. Mapping the
channel mode to the channels_{min|max} is not clear and for the rest I
have no idea.

Any ideas on how we should support this?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
