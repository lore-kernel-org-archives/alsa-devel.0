From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Opening a device 2 times, loopback interface....
Date: Tue, 27 May 2003 08:54:17 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305270853180.3445-100000@pnote.perex-int.cz>
References: <00ea01c32398$fcffa780$490a140a@pc2m73>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <00ea01c32398$fcffa780$490a140a@pc2m73>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-2?Q?St=E9phane_Boulanger?= <stephane.boulanger@fh-bonn-rhein-sieg.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 26 May 2003, [iso-8859-2] St=E9phane Boulanger wrote:

> I think the most other applications will open "hw" or "plughw" (what abou=
t
> the OSS emulation? How does the kernel oss emulation module opens the als=
a
> devices?).

OSS emulation uses direct devices (hw). The only way to reroute OSS=20
applications to alsa-lib (thus dsnoop plugin) is alsa-oss library=20
(libaoss).

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
