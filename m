From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: AC3 passthrough on Audigy
Date: Fri, 29 Aug 2003 02:44:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F4EB003.4090406@superbug.demon.co.uk>
References: <3F4EB8B3.9020506@ca.istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F4EB8B3.9020506@ca.istop.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Boris Shingarov <shingarov@ca.istop.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Boris Shingarov wrote:
> Peter,
> 
> This is very interesting.  You mean this patch will enable passthrough
> without the need for ld10k1, right?  I will give it a try and let you
> know what my results are.
> 
> Boris
> 
> 
It does passthrough using a standard PCM channel. No special TRAM tricks 
needed.
Only works if you send it 2 channel, 16 bit, 48khz PCM stream.
and then outputs AC3 at 48khz over SPDIF.

Cheers
James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
