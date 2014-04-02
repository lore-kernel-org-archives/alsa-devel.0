From: Jano Svitok <jan.svitok@gmail.com>
Subject: Re: [FFADO-devel] [alsa-devel] [PATCH 05/44] firewire-lib: Add
	support for MIDI capture/playback
Date: Wed, 2 Apr 2014 22:37:31 +0200
Message-ID: <CAN2u-c6UiT5r3Ba=VtHX2OPqx5w+oDHMedyiyceUtBu04Dajag@mail.gmail.com>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
	<1395400229-22957-6-git-send-email-o-takashi@sakamocchi.jp>
	<533C6510.7000605@ladisch.de> <20140402194255.GZ12365@ltw.loris.tv>
	<533C6BE1.2050807@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8402721121996345000=="
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <533C6BE1.2050807@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

--===============8402721121996345000==
Content-Type: multipart/alternative; boundary=001a11c3a452f91d3f04f61540b2

--001a11c3a452f91d3f04f61540b2
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Apr 2, 2014 at 9:58 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
>
> Adrian Knoth wrote:
> > On Wed, Apr 02, 2014 at 09:29:20PM +0200, Clemens Ladisch wrote:
> >
> >>> +           len = b[0] - 0x80;
> >>> +           if ((len > 1) &&  (3 < len) && (s->midi[port]))
> >>
> >> This condition is true only for len==2.
> >
> > I don't know if len can be larger than 3. If so, the condition requires
> > len to be at least 4.
> Oops, you're right.  (The goal is do detect 1..3.)

The condition looks like it's equal to

if ((len > 1) && (len > 3) && (s->midi[port]))

or simply

if ((len > 3) && (s->midi[port]))

Perhaps in these cases it's better to have either same order of operands or
same/similar operators...

Jano

--001a11c3a452f91d3f04f61540b2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Wed, Apr 2, 2014 at 9:58 PM, Clemens Ladisch &lt;<a hre=
f=3D"mailto:clemens@ladisch.de">clemens@ladisch.de</a>&gt; wrote:<br>&gt;<b=
r>&gt; Adrian Knoth wrote:<br>&gt; &gt; On Wed, Apr 02, 2014 at 09:29:20PM =
+0200, Clemens Ladisch wrote:<br>
&gt; &gt;<br>&gt; &gt;&gt;&gt; + =A0 =A0 =A0 =A0 =A0 len =3D b[0] - 0x80;<b=
r>&gt; &gt;&gt;&gt; + =A0 =A0 =A0 =A0 =A0 if ((len &gt; 1) &amp;&amp; =A0(3=
 &lt; len) &amp;&amp; (s-&gt;midi[port]))<br>&gt; &gt;&gt;<br>&gt; &gt;&gt;=
 This condition is true only for len=3D=3D2.<br>
&gt; &gt;<br>&gt; &gt; I don&#39;t know if len can be larger than 3. If so,=
 the condition requires<br>&gt; &gt; len to be at least 4.<br>&gt; Oops, yo=
u&#39;re right. =A0(The goal is do detect 1..3.)<br><br>The condition looks=
 like it&#39;s equal to<br>
<br>if ((len &gt; 1) &amp;&amp; (len &gt; 3) &amp;&amp; (s-&gt;midi[port]))=
<br><br>or simply<br><br>if ((len &gt; 3) &amp;&amp; (s-&gt;midi[port]))<br=
><br>Perhaps in these cases it&#39;s better to have either same order of op=
erands or same/similar operators...<br>
<br>Jano</div>

--001a11c3a452f91d3f04f61540b2--


--===============8402721121996345000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============8402721121996345000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8402721121996345000==--
