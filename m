From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Why do I get broken pipe on write to a pcm in state PREPARED?
Date: Thu, 12 Sep 2002 18:14:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209121614.g8CGEr004547@d1o87.telia.com>
References: <200209111926.g8BJQr013561@d1o87.telia.com> <200209121148.g8CBmv020843@d1o87.telia.com> <s5h1y7zp5fp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1y7zp5fp.wl@alsa2.suse.de>
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

On Thursday 12 September 2002 17.56, you wrote:
> we can see this problem from a different angle:  on the current
> scheme, you cannot block writing if the stream is not running.
> writing more in the prepare state will always return an error
> immediately.

Did I mention that I use non-blocking I/O? Well, I do, so what I block 
on is select(). I don't think that changes much though.

Thanks for the patch by the way... I shall look into it later (now I 
need to fix some bugs, the runtime problems I have is due to bugs in my 
program I have detected now). If someone else on this list want to try 
it out, I'd be glad, since I'm currently quite busy to just get my 
things working.

/Anders Torger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
