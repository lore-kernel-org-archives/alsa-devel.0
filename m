From: Ove Kaaven <ovek@transgaming.com>
Subject: Re: PCM questions
Date: Thu, 04 Mar 2004 21:05:29 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078430729.1863.931.camel@renegade>
References: <1078416129.1865.868.camel@renegade>
	 <s5hk720laaf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk720laaf.wl@alsa2.suse.de>
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

tor, 04.03.2004 kl. 19.47 skrev Takashi Iwai:
> or, with PCM API, you can open several PCMs in a single application.
> if the number of voices are limited, it won't be too heavy.

Hmm. I suspect that doing that would not be that much better than
software mixing unless I can use arbitrary buffer sizes on those PCMs
(so that I can just play a sfx of any length in it, loop it, etc,
without having to "babysit" it and constantly stream new data to it).
But I suppose I could look into it...




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
