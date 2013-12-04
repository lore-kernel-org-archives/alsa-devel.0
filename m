From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: What-did-you-plugin-dialog
Date: Wed, 4 Dec 2013 14:04:17 +0800
Message-ID: <CAN8ccia1n5Lj7TTZJ-Mde7aoKAqGZPwLXwuc7w5GS5xqgpoj-w@mail.gmail.com>
References: <52947A6E.6010302@canonical.com>
	<1385470453.2226.26.camel@tkkaskin-mobl2.ger.corp.intel.com>
	<52949CCA.2060601@canonical.com>
	<1385473638.2226.48.camel@tkkaskin-mobl2.ger.corp.intel.com>
	<52951347.9000200@canonical.com> <5295A121.2010202@gmail.com>
	<5295A7C2.2090100@canonical.com>
	<CAN_LGv1F4cTB2cK+rL30N3nbbwyxi23cLYHR6emMC5CbNLP4jQ@mail.gmail.com>
	<CAN_LGv0y2WcYMn8M5rjT1d-2jahh_u-W2D_LnRkMsXXD=ENzdA@mail.gmail.com>
	<CAN8cciZ-y397dLGV_xC3xibo3PY9aE-RYQEB4_dkwRtzN+JnqQ@mail.gmail.com>
	<CAN_LGv02cPydDkvP-AZ+EzkF9TVvm1ij0-6vjzp0YWbieg7_fQ@mail.gmail.com>
	<CAN8cciYnQZQzyRmz_=gLLF6w7p3CZbZPKwYZtJpTHEaN3UOt_Q@mail.gmail.com>
	<CAN_LGv0F6g6L41Se72zdaq4u0DAPJzRc4ZwCMqPPJ06TCFS=qA@mail.gmail.com>
	<CAN8ccibLpVXqcHHdJwfv=_FF8z2hE6frsY8Gg6NRNQibsu2Okw@mail.gmail.com>
	<CAN_LGv3MwSUGHvE5=6U=huAdkzD=mGP89ta7d_ofJ54Y56mRAg@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0204399160=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAN_LGv3MwSUGHvE5=6U=huAdkzD=mGP89ta7d_ofJ54Y56mRAg@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============0204399160==
Content-Type: multipart/alternative; boundary=001a11c1e3d4f203cd04ecaf2ec7

--001a11c1e3d4f203cd04ecaf2ec7
Content-Type: text/plain; charset=UTF-8

> All tests below were done with the original patch, as the suggested
> modification breaks 8ch mode here.
>
> > In 8ch mode, do the "Line jack" return true when you plugged "Side
> Speaker"
> > ?
>
> Yes, the state reflects whether something is plugged into the blue jack.
>
> > pactl list
> >
> > should "line in" list as not available when channel mode changed to "8
> ch" ?
>
> Unfortunately, it is "available" if there is something plugged in and
> "mot available" if there is nothing plugged in.
>
>

https://www.kernel.org/doc/Documentation/sound/alsa/HD-Audio-Controls.txt

Mic Jack Mode, Line Jack Mode, etc
These enum controls the direction and the bias of the input jack pins.
Depending on the jack type, it can set as "Mic In" and "Line In", for
determining the input bias, or it can be set to "Line Out" when the pin is
a multi-I/O jack for surround channels.

the switching from 6ch to 8ch can also be implemented using Line Jack Mode
too

Simple mixer control 'Line Jack Mode',0
Items: 'Mic In' 'Line In' 'Side Line Out'
Item0: 'Side Line Out'

--001a11c1e3d4f203cd04ecaf2ec7
Content-Type: text/html; charset=UTF-8

<div dir="ltr"><br><div class="gmail_extra"><br><div class="gmail_quote"><blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
All tests below were done with the original patch, as the suggested<br>
modification breaks 8ch mode here.<br>
<div class="im"><br>
&gt; In 8ch mode, do the &quot;Line jack&quot; return true when you plugged &quot;Side Speaker&quot;<br>
&gt; ?<br>
<br>
</div>Yes, the state reflects whether something is plugged into the blue jack.<br>
<div class="im"><br>
&gt; pactl list<br>
&gt;<br>
&gt; should &quot;line in&quot; list as not available when channel mode changed to &quot;8 ch&quot; ?<br>
<br>
</div>Unfortunately, it is &quot;available&quot; if there is something plugged in and<br>
&quot;mot available&quot; if there is nothing plugged in.<br>
<div class="im"><br></div></blockquote><div><br></div><div><br><a href="https://www.kernel.org/doc/Documentation/sound/alsa/HD-Audio-Controls.txt">https://www.kernel.org/doc/Documentation/sound/alsa/HD-Audio-Controls.txt</a><br>
<br>Mic Jack Mode, Line Jack Mode, etc
  <br>These enum controls the direction and the bias of the input jack
  pins.  Depending on the jack type, it can set as &quot;Mic In&quot; and &quot;Line 
  In&quot;, for determining the input bias, or it can be set to &quot;Line Out&quot;
  when the pin is a multi-I/O jack for surround channels.<br><br>the switching from 6ch to 8ch can also be implemented using Line Jack Mode too<b><br><br></b>Simple mixer control &#39;Line Jack Mode&#39;,0
  <br>Items: &#39;Mic In&#39; &#39;Line In&#39; &#39;Side Line Out&#39;
  <br><font color="#FF0000"><span style="color:rgb(0,0,0)">Item0: &#39;Side Line Out&#39;</span><br><br><br><br></font></div><div><font color="#FF0000"><b><br></b></font></div></div></div></div>

--001a11c1e3d4f203cd04ecaf2ec7--

--===============0204399160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss

--===============0204399160==--
