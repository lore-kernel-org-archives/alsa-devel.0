From: chris hermansen <clhermansen@gmail.com>
Subject: Re: Status of CM6631 USB
Date: Mon, 4 Mar 2013 11:30:03 -0800
Message-ID: <CACc2_6-7qbWbd=mJSCPM6bt-+NgFTd5GogC1VRk1O4HCcZKtEg@mail.gmail.com>
References: <50C84912.2060101@gmail.com>
	<zarafa.50c8f526.38ee.0f2e389740303d7c@sd-30434.simplynux.net>
	<50C8F75B.5050209@gmail.com>
	<loom.20130302T120058-624@post.gmane.org>
	<5131EEDA.2080408@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2261337080831338770=="
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <5131EEDA.2080408@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Daniel Mack <zonque@gmail.com>
Cc: "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, Torstein Hegge <hegge@resisty.net>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============2261337080831338770==
Content-Type: multipart/alternative; boundary=f46d043c821c3f83bd04d71e62e1

--f46d043c821c3f83bd04d71e62e1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gentlemen;


On Sat, Mar 2, 2013 at 4:21 AM, Daniel Mack <zonque@gmail.com> wrote:

> Hi Torstein,
>
> (+ alsa-devel)
>
> On 02.03.2013 12:09, Torstein Hegge wrote:
> > Daniel Mack <zonque <at> gmail.com> writes:
> >>>> This is a known bug, also most probably flaw in the CMEDIA chip,
> >>>> and not yet properly worked around in the snd-usb driver. If you
> >>>> want to investigate, have a look at the feedback format
> >>>> autodetection code in sound/usb/endpoint.c.
> >>>
> >>> Thanks, I'll have a look.
> >>
> >> I believe what's going on here is that the device is confused after
> >> sample rate changes and keeps sending back feedback data for the old
> >> rate on its feedback endpoint. That causes the autodetection algorithm=
,
> >> which kicks in on every first packet of a stream, to go nuts, which
> >> causes the part of the driver that sends the data assume a very wrong
> >> rate. Some printk() there should give you a hint.
> >
> > I had a look at this using another C-Media CM6631 based device, the Cor=
da
> > Daccord (usbid 0x0d8c, 0x0309). As far as I can see, what happens in th=
e
> > feedback format auto-detection is:
> >
> > When starting playback of a file with a different sampling frequency
> than the
> > previous file, the reported feedback frequency is in the same range as
> the
> > previously played file, varying within +-1%.
> >
> > The feedback format detection gives a shift of -1 and reports the
> feedback
> > frequency as ~48kHz when playing a 44.1kHz file after a 96kHz file. Sam=
e
> thing
> > happens when playing a 96kHz file after a 44.1kHz file, the device
> reports
> > feedback frequency in the 44.1kHz range, the feedback format detection
> gives a
> > shift of +1 and reports the feedback frequency as ~88kHz.
>
> That's what I suspected.
>
> > Bypassing the feedback format detection by hard-coding the frequency
> shift to
> > zero and setting the feedback frequency ep->freqm equal to the nominal
> > frequency ep->freqn if the feedback frequency is far off from the
> expected
> > value (like 48kHz when expecting 44.1kHz) does not change the distortio=
n.
> >
> > Similarly, forcing the feedback detection to run multiple times until i=
t
> > reaches an acceptable value just keeps the feedback detection to
> repeatedly
> > until playback is stopped. This probably means any amount of skipping
> packages
> > early in the stream won't work.
>
> Ok.
>
> > It seems like the device stays in the previous frequency until the
> interface
> > is reset. One possible workaround is to call usb_set_interface() again
> after
> > snd_usb_init_sample_rate(), like this:
>
> I see - that also explains why explicitly stopping and restarting the
> stream fixes the problem in most cases, right?
>
> >
> > diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> > index d82e378..01978a6 100644
> > --- a/sound/usb/pcm.c
> > +++ b/sound/usb/pcm.c
> > @@ -710,6 +710,16 @@ static int snd_usb_pcm_prepare(struct
> snd_pcm_substream
> > *substream)
> >                 subs->need_setup_ep =3D false;
> >         }
> >
> > +       /* Some devices doesn't respond to sample rate changes while th=
e
> > +        * interface is active. */
> > +       switch (subs->stream->chip->usb_id) {
> > +       case USB_ID(0x0d8c, 0x0304): /* C-Media - Schiit USB Interface =
*/
> > +       case USB_ID(0x0d8c, 0x0309): /* C-Media CM6631 */
> > +               usb_set_interface(subs->dev, subs->cur_audiofmt->iface,
> > +                                       subs->cur_audiofmt->altset_idx)=
;
> > +               break;
> > +       }
> > +
> >         /* some unit conversions in runtime */
> >         subs->data_endpoint->maxframesize =3D
> >                 bytes_to_frames(runtime,
> subs->data_endpoint->maxpacksize);
> >
> > This fixes all problems related to sample rate changes for me. I have
> only
> > tested with the Daccord, but it should work for the Schiit and other
> CM6631
> > based devices as well.
>
> Many thanks for looking into this! Much appreciated.
>
> Could you cook a real patch please and send it to alsa-devel? Have a
> look at Documentation/SubmittingPatches if that's your first submission.
>

I would be happy to test this on my Schiit Bifrost as well.  I'm currently
using the TOSLINK connection but it would be easy peasy to hook up a laptop
via the USB.

--=20
Chris Hermansen =B7 clhermansen "at" gmail "dot" com

C'est ma fa=E7on de parler.

--f46d043c821c3f83bd04d71e62e1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Gentlemen;<br><div class=3D"gmail_extra"><br><br><div clas=
s=3D"gmail_quote">On Sat, Mar 2, 2013 at 4:21 AM, Daniel Mack <span dir=3D"=
ltr">&lt;<a href=3D"mailto:zonque@gmail.com" target=3D"_blank">zonque@gmail=
.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Torstein,<br>
<br>
(+ alsa-devel)<br>
<div class=3D"im"><br>
On 02.03.2013 12:09, Torstein Hegge wrote:<br>
&gt; Daniel Mack &lt;zonque &lt;at&gt; <a href=3D"http://gmail.com" target=
=3D"_blank">gmail.com</a>&gt; writes:<br>
&gt;&gt;&gt;&gt; This is a known bug, also most probably flaw in the CMEDIA=
 chip,<br>
&gt;&gt;&gt;&gt; and not yet properly worked around in the snd-usb driver. =
If you<br>
&gt;&gt;&gt;&gt; want to investigate, have a look at the feedback format<br=
>
&gt;&gt;&gt;&gt; autodetection code in sound/usb/endpoint.c.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks, I&#39;ll have a look.<br>
&gt;&gt;<br>
&gt;&gt; I believe what&#39;s going on here is that the device is confused =
after<br>
&gt;&gt; sample rate changes and keeps sending back feedback data for the o=
ld<br>
&gt;&gt; rate on its feedback endpoint. That causes the autodetection algor=
ithm,<br>
&gt;&gt; which kicks in on every first packet of a stream, to go nuts, whic=
h<br>
&gt;&gt; causes the part of the driver that sends the data assume a very wr=
ong<br>
&gt;&gt; rate. Some printk() there should give you a hint.<br>
&gt;<br>
&gt; I had a look at this using another C-Media CM6631 based device, the Co=
rda<br>
&gt; Daccord (usbid 0x0d8c, 0x0309). As far as I can see, what happens in t=
he<br>
&gt; feedback format auto-detection is:<br>
&gt;<br>
&gt; When starting playback of a file with a different sampling frequency t=
han the<br>
&gt; previous file, the reported feedback frequency is in the same range as=
 the<br>
&gt; previously played file, varying within +-1%.<br>
&gt;<br>
&gt; The feedback format detection gives a shift of -1 and reports the feed=
back<br>
&gt; frequency as ~48kHz when playing a 44.1kHz file after a 96kHz file. Sa=
me thing<br>
&gt; happens when playing a 96kHz file after a 44.1kHz file, the device rep=
orts<br>
&gt; feedback frequency in the 44.1kHz range, the feedback format detection=
 gives a<br>
&gt; shift of +1 and reports the feedback frequency as ~88kHz.<br>
<br>
</div>That&#39;s what I suspected.<br>
<div class=3D"im"><br>
&gt; Bypassing the feedback format detection by hard-coding the frequency s=
hift to<br>
&gt; zero and setting the feedback frequency ep-&gt;freqm equal to the nomi=
nal<br>
&gt; frequency ep-&gt;freqn if the feedback frequency is far off from the e=
xpected<br>
&gt; value (like 48kHz when expecting 44.1kHz) does not change the distorti=
on.<br>
&gt;<br>
&gt; Similarly, forcing the feedback detection to run multiple times until =
it<br>
&gt; reaches an acceptable value just keeps the feedback detection to repea=
tedly<br>
&gt; until playback is stopped. This probably means any amount of skipping =
packages<br>
&gt; early in the stream won&#39;t work.<br>
<br>
Ok.<br>
<br>
&gt; It seems like the device stays in the previous frequency until the int=
erface<br>
&gt; is reset. One possible workaround is to call usb_set_interface() again=
 after<br>
&gt; snd_usb_init_sample_rate(), like this:<br>
<br>
</div>I see - that also explains why explicitly stopping and restarting the=
<br>
stream fixes the problem in most cases, right?<br>
<div class=3D"im"><br>
&gt;<br>
&gt; diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c<br>
&gt; index d82e378..01978a6 100644<br>
&gt; --- a/sound/usb/pcm.c<br>
&gt; +++ b/sound/usb/pcm.c<br>
&gt; @@ -710,6 +710,16 @@ static int snd_usb_pcm_prepare(struct snd_pcm_sub=
stream<br>
&gt; *substream)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 subs-&gt;need_setup_ep =3D false;<br>
&gt; =A0 =A0 =A0 =A0 }<br>
&gt;<br>
&gt; + =A0 =A0 =A0 /* Some devices doesn&#39;t respond to sample rate chang=
es while the<br>
&gt; + =A0 =A0 =A0 =A0* interface is active. */<br>
&gt; + =A0 =A0 =A0 switch (subs-&gt;stream-&gt;chip-&gt;usb_id) {<br>
&gt; + =A0 =A0 =A0 case USB_ID(0x0d8c, 0x0304): /* C-Media - Schiit USB Int=
erface */<br>
&gt; + =A0 =A0 =A0 case USB_ID(0x0d8c, 0x0309): /* C-Media CM6631 */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb_set_interface(subs-&gt;dev, subs-&gt=
;cur_audiofmt-&gt;iface,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 subs-&gt;cur_audiofmt-&gt;altset_idx);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 =A0 }<br>
&gt; +<br>
&gt; =A0 =A0 =A0 =A0 /* some unit conversions in runtime */<br>
&gt; =A0 =A0 =A0 =A0 subs-&gt;data_endpoint-&gt;maxframesize =3D<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytes_to_frames(runtime, subs-&gt;data=
_endpoint-&gt;maxpacksize);<br>
&gt;<br>
&gt; This fixes all problems related to sample rate changes for me. I have =
only<br>
&gt; tested with the Daccord, but it should work for the Schiit and other C=
M6631<br>
&gt; based devices as well.<br>
<br>
</div>Many thanks for looking into this! Much appreciated.<br>
<br>
Could you cook a real patch please and send it to alsa-devel? Have a<br>
look at Documentation/SubmittingPatches if that&#39;s your first submission=
.<br></blockquote></div><br clear=3D"all"></div><div class=3D"gmail_extra">=
I would be happy to test this on my Schiit Bifrost as well.=A0 I&#39;m curr=
ently using the TOSLINK connection but it would be easy peasy to hook up a =
laptop via the USB.<br>
<br></div><div class=3D"gmail_extra">-- <br><div dir=3D"ltr">Chris Hermanse=
n =B7 clhermansen &quot;at&quot; gmail &quot;dot&quot; com<br><br>C&#39;est=
 ma fa=E7on de parler.</div>
</div></div>

--f46d043c821c3f83bd04d71e62e1--


--===============2261337080831338770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
--===============2261337080831338770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============2261337080831338770==--
