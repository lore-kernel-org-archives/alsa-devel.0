From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Default device with fallback
Date: Fri, 16 Feb 2007 14:25:16 -0500
Message-ID: <75b66ecd0702161125v62aa252ap6ded3a9774f3b692@mail.gmail.com>
References: <75b66ecd0702151749r7df799f1pe4cd832af58ae443@mail.gmail.com>
	<1171620116.9130.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1171620116.9130.6.camel@localhost>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: =?ISO-8859-1?Q?Jean-Michel_Pour=E9?= <jmpoure@free.fr>
Cc: Alsa Dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 2/16/07, Jean-Michel Pour=E9 <jmpoure@free.fr> wrote:
> Would it be possible to address devices using product IDs directly. I
> know this sounds incredible, but each device usually has a unique ID
> somewhere.
>
> So in place of writing plughw:x,y, we would write productid:xyzzer. This
> would allow plughw:x,y to continue to behave like today. The only
> difference is that users would really have a unique way of naming
> hotplugable devices.

Yes - cards are already addressable by name.  So if /proc/asound/cards cont=
ains:

 0 [Audigy2        ]: Audigy2 - Audigy 2 ZS [SB0350]
                      Audigy 2 ZS [SB0350] (rev.4, serial:0x20021102)
at 0xe800, irq 10

You would use "plughw:Audigy2" rather than "plughw:x,y".

I believe USB devices have a hardware GUID that the other OS uses to
distinguish multiple devices of the same type.  If ALSA were to expose
this in the card name then persistent device naming should be
possible.

Lee

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
