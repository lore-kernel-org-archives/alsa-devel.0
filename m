From: chris hermansen <clhermansen@gmail.com>
Subject: Re: [alsa-devel] Audio-gd NFB-17.32 (VIA VT1731)
Date: Mon, 25 Mar 2013 09:28:41 -0300
Message-ID: <CACc2_6-KBbv9KsuaF=cDPceAXvV2FAJT1Abx5iTUs2-EXV+XEg@mail.gmail.com>
References: <20130322215650.GF7539@pvv.ntnu.no>
	<514DD773.8060408@guest.arnes.si> <514E3778.1050801@guest.arnes.si>
	<20130324205326.GB776@pvv.ntnu.no>
	<514FFEE8.4070300@googlemail.com>
	<20130325094841.GB18838@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <20130325094841.GB18838@pvv.ntnu.no>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Torstein Hegge <hegge@resisty.net>
Cc: "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Torstein, Clemens, list:

On Mon, Mar 25, 2013 at 6:48 AM, Torstein Hegge <hegge@resisty.net> wrote:
> On Mon, Mar 25, 2013 at 08:38:16 +0100, Clemens Ladisch wrote:
>> Torstein Hegge wrote:
>> > I think we can conclude that the VIA VT1731 has the same issue as the
>> > C-Media CM6631.
>> >
>> > I'll add the VT1731 as one of the devices that needs a reset after
>> > sample rate change in the next iteration of the sample rate workaround
>> > patch.
>>
>> Why not just do it for all UAC 2 devices?
>
> If new devices that needs this just keeps popping up, that might indeed
> be the better solution.

For what my opinion is worth, this seems like the ideal solution to
me.  It doesn't seem to introduce much additional overhead and it
improves the behaviour of two interfaces / three physical devices of
which we are aware.

Is it worth testing such a "universal" application against devices
known to work without it?  Do any of us have such a device?


--
Chris Hermansen =B7 clhermansen "at" gmail "dot" com

C'est ma fa=E7on de parler.

---------------------------------------------------------------------------=
---
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
