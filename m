From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: mixer device
Date: Wed, 12 May 2004 17:40:55 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0405121735410.26780-100000@studcom.urz.uni-halle.de>
References: <1084218706.31496.72.camel@shrek.bitfreak.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1084218706.31496.72.camel@shrek.bitfreak.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Ronald S. Bultje" <R.S.Bultje@students.uu.nl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ronald S. Bultje wrote:
> for a given alsa device ("default", "dmix", "plughw:N", "hw:N,M",
> "dspN", etc.), how do I automatically obtain the right device to use as
> a audio mixer with that device?

Depends on your definition of "right device".  In the general case
this isn't possible because many cards don't have any mixer controls,
or don't have the controls you want to use.  Or the pcm device uses
several cards, or none.

What do you want to do with the mixer?

> So far, it seems I can only attach to "hw:N" mixer devices.

You can use any control device that is defined in your .asoundrc with
something like:

  ctl.xxxxx {
    type hw
    card N
  }


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
