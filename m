From: Glenn Maynard <g_sf@zewt.org>
Subject: Re: EMU10K1 and the extra voice
Date: Sun, 6 Jun 2004 14:09:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040606180919.GB3025@zewt.org>
References: <20040605125936.GA3478@lost.org.uk> <20040606045431.GA3025@zewt.org> <Pine.LNX.4.58.0406061239340.1780@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406061239340.1780@pnote.perex-int.cz>
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

On Sun, Jun 06, 2004 at 12:40:31PM +0200, Jaroslav Kysela wrote:
> > Any relationship to the fact that I can only allocate 21 subdevices with
> > ALSA, but 31 with DirectSound?
> 
> Yes, 64 / 3 = 21 .

That stinks (but if it's necessary for decent latency, which it doesn't
get in Windows, oh well).  Shouldn't the driver report 21 substreams
instead of 32, though?

-- 
Glenn Maynard


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
