From: Niklas Werner <bergtroll@gmx.li>
Subject: Re: status of powermac sound?
Date: Thu, 13 May 2004 09:15:34 +1200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405130915.34452.bergtroll@gmx.li>
References: <200405121138.09878.bergtroll@gmx.li> <1084357911.3034.11.camel@thor.asgaard.local> <20040512145302.GA11235@spring.luon.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040512145302.GA11235@spring.luon.net>
Content-Disposition: inline
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

On Thu, 13 May 2004 02:53, Sjoerd Simons wrote:

> Using this on my albook. I get strange distorsions and a too low pitch
> when playing a dvd or divx with 48Khz audio.
>
> For the record, the hardware is:
> 0 [Snapper        ]: PMac Snapper - PowerMac Snapper
>                      PowerMac Snapper (Dev 35) Sub-frame 0

yep, exactly. And normally using alsa directly does not work, and if it 
does it shows the same effects...

mplayer with -ao alsa1x yields:

alsa-play: unknown status, trying to reset soundcard

works fine with -ao oss
xmms doesn't work with alsa-plugin at all (well, OK, who cares... xmms 
seems to have died anyways...)

astonishingly jackd normally works. Is there an option to force the driver 
to always use a buffer size of a power of 2?

Have fun*

Niklas


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
