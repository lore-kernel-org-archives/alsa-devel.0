From: Justin Cormack <justin@street-vision.com>
Subject: Re: Multiple Sound Streams out of a single card
Date: 14 Sep 2003 17:56:20 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1063558581.1510.87.camel@lotte.street-vision.com>
References: <200309140606.h8E66UCi032132@oud>
	<1063554637.21173.11.camel@localhost>  <1063555915.21172.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1063555915.21172.17.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: AthlonRob <athlonrob@data.4t3.com>
Cc: alsa list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2003-09-14 at 17:11, AthlonRob wrote:
> I'd still like to hear, though, if it is possible to get OSS emulation
> to use the dmix plugin...

unfortunately because oss is a kernel only thing, it all goes through
the kernel and so only uses hw (because plughw and all the other stuff
is userspace).

The way to do it would be to write an oss driver (or alsa driver and use
oss emulation) that simply passes playback to user space where you feed
it into dmix or whatever. But hopefully all tools will support alsa
soon.

Justin




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
