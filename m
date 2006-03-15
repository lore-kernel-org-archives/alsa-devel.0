From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: I/O multiplexing using select()
Date: Tue, 14 Mar 2006 20:38:05 -0500
Message-ID: <1142386686.24603.56.camel@mindpipe>
References: <c0ac6f5f0603141730o4853d13eiaf1506b003339eac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <c0ac6f5f0603141730o4853d13eiaf1506b003339eac@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Persson <xarragon@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-03-15 at 02:30 +0100, Martin Persson wrote:
> The problem is that select() is awakended when only 92 bytes (46
> frames) are available

Use snd_pcm_dump() to get all the hw and sw parameters immediately
before you call select() and post the output, a pointer to your code
would help also.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
