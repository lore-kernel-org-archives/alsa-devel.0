From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: addressing hardware directly?
Date: Mon, 07 Nov 2005 11:33:49 +0100
Message-ID: <1131359629.436f2d8d869ad@webmail.uni-halle.de>
References: <b15982770511061007k17711a3aq6c008b7fc4246619@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <b15982770511061007k17711a3aq6c008b7fc4246619@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Smoot <davidsmoot@gmail.com>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

David Smoot wrote:
> If I am not developing a generic sound application but I specifically
> want to talk to a single card, can I address a card directly in my
> software rather than using the "default" or the "hw:0,0" interface?
> My target platform is a very limited device, the less stuff I install,
> the better.

"hw" is the most direct ALSA interface.  If you want to be more direct, you have
to write your own driver.

> So what is the naming convention for the sound devices when I call
> "snd_pcm_open"?  So far all I found in the documentation is "default"
> or "hw:0,0".  I've tried poking around in /proc/asound/ but have not
> found it yet.

An ALSA PCM device name "xxx" is looked up as a "pcm.xxx" definition in one of
the
configuration files (~/.asoundrc, /etc/asound.conf, /usr/share/alsa/...).


HTH
Clemens


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
