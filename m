From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Opening a device 2 times, loopback interface....
Date: Tue, 13 May 2003 12:11:17 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305131207020.1179-100000@pnote.perex-int.cz>
References: <CBEIKLKHDDAOGEKMPCGEEEACCAAA.stephane.boulanger@fh-bonn-rhein-sieg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <CBEIKLKHDDAOGEKMPCGEEEACCAAA.stephane.boulanger@fh-bonn-rhein-sieg.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?Q?St=E9phane_Boulanger?= <stephane.boulanger@fh-bonn-rhein-sieg.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 13 May 2003, [iso-8859-1] St=E9phane Boulanger wrote:

> Dear List,
>=20
> we=B4re currently developing an end-to-end delay measurement tool, that s=
hould
> not only measure the network delay, but also the time the application
> (audiostreaming (rat, for example)) needs to calculate the used algorithm=
s
> (GSM, PCM, whatever). To realize the choosen program design, we need to
> access the soundcard device form two different applications (streaming
> application and the measurement tool) at the same time. More exactly:
>=20
> - When audiodata is inputted, not only the streaming application should b=
e
> able to access it, but also our measurement tool (at the same time
> obviously).
>=20
> - When audiodata is send to the sounddriver (repectively the soundcard), =
the
> measurement tool should be able to read it (maybe in the form of a copied
> datastream send to the measurement tool).
>=20
>=20
> While browing the ALSA documentation, I found some interesting parts abou=
t
> the loopback interface, that might help us. But is it still contained in =
the
> 0.9 version of ALSA? Moreover, would the loopback interface satisfy our
> needs?

The loopback interface is dead. We have alsa-lib which can do all
requested things. See the dsnoop plugin and file plugin. You may also
modify them to satisfy your requirements.

The only "negative" item is that it will work with ALSA native=20
applications only or with the alsa-oss library.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
