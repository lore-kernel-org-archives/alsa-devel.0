From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Maintaining sound card at a specific frequency
Date: Mon, 17 Jan 2005 06:14:06 +0100
Message-ID: <1105938846.41eb499ec3527@www3.webhosting.cx>
References: <5bdc1c8b050116130511757cbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <5bdc1c8b050116130511757cbf@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Quoting Mark Knecht <markknecht@gmail.com>:

>
> I guess I'm wondering if there isn't some .asoundrc magic that could
> be done in my Linux account on this machine that would tell all
> applications (other than Jack for now) to use some virtual device that
> handles all frequencies. If that virtual device was the default and
> the resampling (for Mozilla/games/whatever) was done in software and
> the sound cards frequency was never changed then I think things would
> work much better.
>

I think you can use default as the device name in .asoundrc and it will b=
e used
as the default device for all apps.

Then just give it a plughw instead of hw

ex.


pcm.default {
        type plughw
        card card1
        device 0
}

ctl.default {
        type hw
        card 0
}



 --
 Patrick Shirkey - Boost Hardware Ltd.
 Http://www.boosthardware.com
 Http://www.djcj.org/ - The Linux Audio Users guide
 Http://www.djcj.org/gigs - Gigs Guide Korea
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 Being on stage with the band in front of crowds shouting, "Get off! No!
 We want normal music!", I think that was more like acting than anything
 I've ever done.

 Goldie, 8 Nov, 2002
 The Scotsman


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
