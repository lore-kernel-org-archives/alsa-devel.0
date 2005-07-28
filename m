From: "Maarten Vanraes" <maarten.vanraes@telenet.be>
Subject: Re: [Openvortex-dev] Re: Re: Volume per voices
     [Feature Request]
Date: Thu, 28 Jul 2005 12:59:03 +0200 (CEST)
Message-ID: <47103.62.59.249.250.1122548343.squirrel@62.59.249.250>
References: <42E889DD.2070808@netvigator.com>
    <Pine.HPX.4.33n.0507280943050.9785-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0507280943050.9785-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Raymond <rayau@netvigator.com>, openvortex-dev@nongnu.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Raymond wrote:
>> There is no need for alsactl to store/restore the values of these kind
>> of volume controls.
>
> Indeed.  Most applications just get the first free substream.
> Allowing the user to change 16 (or 32) different volume controls just
> doesn't make sense in this context.

maybe an application should only change it's own volume control (not the
master volume control); if there is no such thing, it can make it in
software.

but! shouldn't it also be possible to make an application that can change
all these volume controls? like a switchboard or something?


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO Septem=
ber
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
