From: Richard Bown <bownie@bownie.com>
Subject: Re: ALSA sequencer input buffer
Date: Thu, 25 Apr 2002 13:45:25 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204251248.AFT94300@msgdirector2.onetel.net.uk>
References: <Pine.LNX.4.44.0204241639410.10208-100000@volamar.theswamp.priv> <200204251211.AFT92055@msgdirector2.onetel.net.uk> <s5hbsc8are7.wl@alsa2.suse.de>
Reply-To: bownie@bownie.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbsc8are7.wl@alsa2.suse.de>
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

> no, you shouldn't drop input events.  otherwise the input events will
> be really lost.

Oh ok, from your code examples I see that I was implementing a blocking
model for a non-blocking port.  Following the second example seems to have
fixed it without the need to drop any events.

Thanks Takashi.

R
