From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: help needed-- providing control interface
Date: Fri, 26 Mar 2004 18:22:38 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403261816230.2160-100000@studcom.urz.uni-halle.de>
References: <015001c41320$878d92a0$f8b6a8c0@ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <015001c41320$878d92a0$f8b6a8c0@ent.ti.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pavana Sharma <pavans@india.ti.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pavana Sharma wrote:
> I am providing control interface for my driver to access from user space
> with functions get & put .
>
>  * while creating new controls should I be allowed to create my hardware
> specific controls like gain, power, rate & other codec specific parameters.

All controls are hardware-specific.  There are no requirements what
controls you must, or must not, provide.

> or  should I take care of mapping OSS mixer controls to ALSA mixer.

ALSA does this automatically, based on the control names.

>  * How user comes to know what controls are available & the valid range of
> values for sliders & switches.

The driver defines type and range of a control in the info callback.

The user can determine these things with the snd_ctl_* functions in
the ALSA library.  See the source code of amixer and alsactl for
details.


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
