From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Audigy2 P16V testing
Date: Fri, 07 Jan 2005 21:11:29 +0000
Message-ID: <41DEFB01.4080004@superbug.co.uk>
References: <20050107121731.GA3982@school.ioffe.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050107121731.GA3982@school.ioffe.ru>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dmitry Baryshkov <mitya@school.ioffe.ru>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dmitry Baryshkov wrote:
> Hello,
> 
> Please correct me if this is wrong place for this post.
> 
> I tried testing p16v patch from www.alsa-project.org/~james/p16v
> (the last one, where p16v is merged with emu10k1).
> I applied patch & copied p16v.c to alsa 1.0.8rc2. emu10k1 driver
> compiled & inserted successfully. But when I tried to play self-generated
> SE32_LE@96Khz wav file (aplay -D hw:0,3 test.wav) I got no sound & a
> lot of messages in kernel log (attached).
> 
> I'm using kernel 2.6.9.
> 
> Just in case here is related part of lspci -v:
> 

That driver is not supposed to work yet.
See the readme.txt file.

I previously called it README.txt, but for some reason the web server 
decided to hide the README.txt file, and only displays it if I rename it 
to readme.txt

Summary:
That file is only there for the purposes of backup, while I work in it.

Cheers
James


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
