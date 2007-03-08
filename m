From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: amixer bug
Date: Fri, 09 Mar 2007 10:24:38 +1300
Message-ID: <45F07F16.7080909@audioscience.com>
References: <mailman.174113.1173383910.20110.alsa-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <mailman.174113.1173383910.20110.alsa-devel@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: julian_cable@yahoo.com
List-Id: alsa-devel@alsa-project.org

> From: Julian Cable <julian_cable@yahoo.com> Subject: [Alsa-devel]
> amixer bug

> amixer correctly indicates that the default 0 value is equivalent to
> 50%. If I set the value using the % syntax all is well:
> 
> 0% -> -100 25% -> -50 50% -> 0 100% -> 100
> 
> But if I use the absolute notation then it rejects negative numbers.
> 
> If I use the incremental notation something even stranger happens. If
> the current value is positive, all is well. If the current value is
> +5 and I decrement by 10 then it correctly sets to -5, but if the
> current value is -5 and I decrement by 10 it sets the value to +100
> (ie the maximum).
> 
> So there are two problems:
> 
> 1) negative numbers are not allowed on the command line

Try adding -- between the options and the parameters

aplay cset numid=1 -- -5

> 2) decrementing doesn't work when the current value is negative.

Perusing amixer source, the increment syntax only works for controls
identified as volumes.  Other integer controls don't support it.

> 
> I tried to raise this as a bug but I've forgotten my password and
> bugzilla refuses to send a reminder to my registered account (this
> one). cheers
> 
> Julian
> 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
