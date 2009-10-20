From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [Intel-gfx] Problems with HDMI audio on Intel
	DG45FC	motherboard
Date: Wed, 21 Oct 2009 00:37:58 +0200
Message-ID: <20091020223758.GA31022@hardeman.nu>
References: <20091011214513.GB12771@hardeman.nu>
	<20091014015455.GI13364@zhen-devel.sh.intel.com>
	<20091014020044.GA10032@localhost>
	<20091014174053.GA31149@hardeman.nu>
	<20091020012600.GA6548@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-user-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20091020012600.GA6548@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: alsa-user@lists.sourceforge.net, intel-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 20, 2009 at 09:26:00AM +0800, Wu Fengguang wrote:

>Sorry for the long delay!

No problem.

>On Thu, Oct 15, 2009 at 01:40:53AM +0800, David H=E4rdeman wrote:
>> ii) Is there any documentation somewhere on how this mapping is supposed =

>> to be performed in user space?
>
>I think Shane has provided a good example for you in another email :)
>Here are more descriptions for the route plugin:

So perhaps I should still file a bug with the ALSA bugtracker asking for =

the default ALSA userspace to include a channel mapping along Shane's =

recommendation?

>> >Complete silence for how much time?
>> =

>> For the entire duration of the particular movie/audio track/video =

>> clip/whatever.
>> =

>
>I actually have a DG45FC box and have not run into this problem for
>all the HDMI monitors I have. What's your monitor model?

A Samsung LE-55A956 LCD TV. But I think the problem is not with the =

monitor (TV) but rather with the receiver that is between the DG45FC and =

the TV. The receiver is a Marantz SR8002 with HDMI support.

>Did the kernel emit some error messages?

Nope

>What if you change display
>modes with xrandr?

Haven't tried that yet...currently running on 1920x1080@60 which should =

(I guess) be one of the most common modes with modern LCD TV's.

>HDMI codec/sink seem to take some time to response to the output
>enable and new infoframe, so there are some delay. I've moved the HDMI
>output enable command to module load time, this helps. The infoframe
>is in theory created in run time based on the format of _each_ new
>audio stream, so infoframe transmission has to be started/stopped
>for each track..

So my current theory is along the line of HDMI audio infoframe or video =

infoframe problems. Do you have any pointers where in the driver(s) =

the infoframes (both audio and video) are generated so that I can add =

some debugging statements to dump the frames and compare the working =

and non-working scenarios?

Regards,
David


---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
