From: joy <joy@pingfm.org>
Subject: Re: spdif-trough and snd_ctl_elem_*
Date: Thu, 18 Jul 2002 00:31:16 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020717223116.GA3310@pingfm.org>
References: <20020713151936.GA4711@pingfm.org> <s5hptxm8rs9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hptxm8rs9.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 17, 2002 at 02:25:58PM +0200, Takashi Iwai wrote:
> the implementation of controls for iec958 is fairly dependent on each
> card.  some card needs more initialization and some not.  it's true
> that this might be confusing if you want to access such switches
> _directly_.
> 
> on alsa, instead of tweaking these lowlevel stuffs, you can use an
> abstraction pcm layer.
> typically, the pcm "iec958" (or "spdif" equivalently) does all such a
> job.  the iec958 pcm accepts arguments which represent status bytes.
> 
> 	iec958:AES0=0xXXXX,AES1=0xXXXX,AES2=0xXXXX,AES3=0xXXXX
> 
thanx for your reply, i will give it a try, but this kind of init
needs some more rewrite i have expected and i have currently no
iec958-capable-device to do real tests, so users have to wait bit ;)

> well, it seems that ens1371 has still no configuration for iec958.
> so, the right way is to add this stuff...
?
should i add it? will you add it? on which device is the iec958
running on the ens1371? i guess its hw:0,0

-- 
regards

____-
joy

________/\---------%%%___________-----------
webcast every sunday 2000 cest at pingfm.org

pgp key at: x-hkp://wwwkeys.de.pgp.net


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
