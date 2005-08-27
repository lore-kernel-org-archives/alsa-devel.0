From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: ALSA / emu10k1 / SPDIF / surround?
Date: Sat, 27 Aug 2005 17:39:26 -0400
Message-ID: <1125178767.25011.86.camel@mindpipe>
References: <1124755115.5763.3.camel@hostmaster.org>
	 <1125166820.22285.68.camel@hostmaster.org>
	 <1125168446.25011.68.camel@mindpipe>
	 <1125173150.22285.103.camel@hostmaster.org>
	 <1125174445.25011.76.camel@mindpipe>
	 <1125177706.22285.144.camel@hostmaster.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <1125177706.22285.144.camel@hostmaster.org>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, ALSA user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

[restored alsa-user and alsa-devel to cc: as this is a driver bug]

On Sat, 2005-08-27 at 23:21 +0200, Thomas Zehetbauer wrote:
> 02:08.0 Class 0401: 1102:0002 (rev 0a)
>         Subsystem: 1102:8065
>         Flags: bus master, medium devsel, latency 64, IRQ 27
>         I/O ports at b800 [size=32]
>         Capabilities: [dc] Power Management version 1 

Yup, just as I suspected, this card isn't in the driver's device table.

What's the exact name of your card?  IOW, what does it say on the box
(SBLive! Value, Player, 5.1 ... ?)

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
