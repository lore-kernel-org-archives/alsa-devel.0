From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: [perex@suse.cz: Re: PCM questions]
Date: Sat, 6 Mar 2004 14:53:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040306135305.GL25734@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

----- Forwarded message from Jaroslav Kysela <perex@suse.cz> -----

From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Ove Kaaven <ovek@transgaming.com>
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] PCM questions
In-Reply-To: <1078430057.30309.921.camel@renegade>
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam Filtering performed by sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	Report problems to http://sf.net/tracker/?func=add&group_id=1&atid=200001
Errors-To: alsa-devel-admin@lists.sourceforge.net
X-BeenThere: alsa-devel@lists.sourceforge.net
X-Mailman-Version: 2.0.9-sf.net
Precedence: bulk
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: Advanced Linux Sound Architecture - Devel <alsa-devel.lists.sourceforge.net>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
X-Original-Date: Sat, 6 Mar 2004 11:10:23 +0100 (CET)
Date: Sat, 6 Mar 2004 11:10:23 +0100 (CET)


Hello,

just two cents - I know that app shouldn't mess with application or
hardware position variables. So we have snd_pcm_forward or snd_pcm_rewind
(the later not working in dmix case). But doing input and output ptr
calculations in app while it is already done in lib make no sense for me.
There should exist snd_pcm_get_ functions which return apropriate
values. Clean and simple. You can not directly change them but you can
get the values if you need them.

Regards

Adam Tla/lka


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
