From: Ian Forde <ian@duckland.org>
Subject: Re: Broken nforce3 support in ALSA on amd64?
Date: Wed, 09 Mar 2005 20:40:06 -0800
Message-ID: <1110429607.15460.3.camel@colgate3.iforde.net>
References: <1109468746.11523.20.camel@colgate3.iforde.net>
	 <s5hr7irwpjf.wl@alsa2.suse.de> <1110225967.935.12.camel@mindpipe>
	 <s5hfyz7us6w.wl@alsa2.suse.de> <1110244309.1183.25.camel@mindpipe>
	 <1110260716.7958.1.camel@colgate3.iforde.net>
	 <s5h3bv6uzv3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5h3bv6uzv3.wl@alsa2.suse.de>
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
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-03-08 at 12:43 +0100, Takashi Iwai wrote:
> nForce seems to route the SPDIF not through AC97 but directly to the
> transmitter.  So, tuning AC97 registers will unlikely help.

Okay - so I disabled it in the BIOS and put in an older SBLive 5.1 card
that I had before.  I can get PCM audio just fine, but AC3 passthrough
is once again lighting up the receiver, but with no audio coming
through.  Please tell me this isn't an AMD64 thing...

	-I



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
