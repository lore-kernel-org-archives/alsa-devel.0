From: Eduard Hasenleithner <ehasenle@spamcop.net>
Subject: Re: ice1712 pro mode and general playback performance
	(was alsaplayer)
Date: 22 Jul 2003 21:51:21 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1058903481.26606.24.camel@boundary.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello, =E3=81=84=E3=82=8F=E3=81=84 =E3=81=95=E3=82=93!

Thank you for your answer. The problem is that it does not
solve my basic problem with my "HiFi" soundcard :(

On Tue, Jul 08, 2003 at 01:06:11PM +0200, Takashi Iwai wrote:
> > 2. With the ice1712, 256k of buffer memory and assuming 44.1kSps
only
> > 0.13 seconds of playback can be stored in the driver buffer. I
noticed a
> > lot of xrun when doing background tasks while listening to music or
when
> > only watching a video. What can be done about this?
> >     - Implement a pre-buffer in kernel with the source bitrate
> >           and number of channels?
>=20
> we unlikely do this.  basically such a buffer-handling shouldn't be
> the job of kernel.
=20
> unfortuantely, there is no concrete "good" solution for this problem.
> an easy solution is to raise the scheduling priority of the
> alsaplayer.  then no xrun shouldn't happen.
>=20
> the real solution might be to increase the size of internal buffer in
> alsaplayer like xmms has...

After your post I have made a lot of thoughts about this
performance issue. The problem is that xmms (with oss emulation layer)
has the same problems as alsaplayer, but I didn't mention it as I
thought
alsaplayer would benefit (and not suffer) from the alsa infrastructure.=20

Aside from that, even mplayer suffers from the small kernel buffer!
When I playback a usual mpeg2 video I have a lot of xruns, more
than in alsaplayer or xmms.  And in this case I can not do anything
by means of increasing the priority since most of the processor power
is used by mplayer alone.  Furthermore mplayer has no means of giving
priority to audio.

I have a certain idea about what service an (alsa) audio
driver should present to a (non-root) audio application. Cheap
on-board audio codecs have no problem of providing 0.5s playback
buffer since 2*2*44.1 uses much less memory than 10*4*44.1 per
second of the ice1712. So the xrun problem resulting from
the 256k limit (and the linux scheduling properties)=20
has to be circumvented somehow.

The only user-space solution to this problem is a deamon
which runs with real-time priority and client programs can
connect to it. "jack" is one example for this kind of software
as it also provides this real-time capability. But you have
to either run all your audio applications as root or apply
a kernel patch which both enables a considerable security risk.

I do not request a "kernel pre-buffer" solution to be
included into the alsa package. But I want to hear if
my conclusions are right that with the current linux
(2.4.x) infrastructure I cannot use my ice1712 soundcard
for the same tasks as I used with my onboard sound chip.

greetings,
Eduard



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
