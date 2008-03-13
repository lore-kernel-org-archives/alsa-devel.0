From: "Gadi Oron" <gadior@gmail.com>
Subject: Re: [alsa-devel] Metallic recording in cs46xx on
	Thinkpad T22
Date: Thu, 13 Mar 2008 14:11:30 +0200
Message-ID: <3948f0730803130511x62d1802dxdfe2f408ad2120db@mail.gmail.com>
References: <3948f0730803110024k1e7b90ecr31b745e333913c1d@mail.gmail.com>
	<47D70143.3010705@keyaccess.nl> <s5hk5k89f52.wl%tiwai@suse.de>
	<47D80754.1020400@keyaccess.nl> <s5h8x0nanew.wl%tiwai@suse.de>
	<47D81037.7030901@keyaccess.nl> <s5hwso699y3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0616414278=="
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <s5hwso699y3.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-user@lists.sourceforge.net, Rene Herman <rene.herman@keyaccess.nl>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============0616414278==
Content-Type: multipart/alternative;
	boundary="----=_Part_8138_30196855.1205410291000"

------=_Part_8138_30196855.1205410291000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hopefully it is full now.

http://pastebin.ca/940929

On Thu, Mar 13, 2008 at 12:48 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 12 Mar 2008 18:17:43 +0100,
> Rene Herman wrote:
> >
> > On 12-03-08 17:59, Takashi Iwai wrote:
> >
> > > At Wed, 12 Mar 2008 17:39:48 +0100,
> > > Rene Herman wrote:
> > >> On 12-03-08 15:43, Takashi Iwai wrote:
> > >>
> > >>> At Tue, 11 Mar 2008 23:01:39 +0100,
> > >>> Rene Herman wrote:
> > >>>> On 11-03-08 08:24, Gadi Oron wrote:
> > >>>>
> > >>>>> I am trying to record sound on an old Thinkpad T22 that uses the
> cs46xx
> > >>>>> sound driver.
> > >>>>>
> > >>>>> Each time you start to record you have a 10% chance of having the
> > >>>>> recording completely distorted and having a metallic sound. When
> you
> > >>>>> look at the waveform it looks as though there are small segments
> with
> > >>>>> sharp transitions between them, a little like if these segments
> were
> > >>>>> moved a little from their correct place.
> > >>>> No insights, but I confirm the bug with a TerraTec DMX XFire 1024
> (CS4624).
> > >>> Hm, cs46xx driver hasn't been much changes since long time ago
> (around
> > >>> year 2005).  The only big change was about some PM fixes, and I
> don't
> > >>> think it's relevant...  Could you run als-info.sh to get the status?
> > >> At:
> > >>
> > >> http://pastebin.ca/939784
> > >
> > > The output seems truncated.  Could you give the generated file via
> > > "alsactl -f somefile store", just to be sure ?
> >
> > Hmm, alsa-info.sh freshly downloaded from current hg.
>
> Is the original data also truncated at the middle or is it a paste.bin
> problem?
>
> >       control.26 {
> >               comment.access 'read write'
> >               comment.type INTEGER
> >               comment.count 2
> >               comment.range '0 - 32767'
> >               iface MIXER
> >               name 'ADC Volume'
> >               value.0 29492
> >               value.1 29492
> >       }
>
> Try to put this to full once.
>
>
> Takashi
>

------=_Part_8138_30196855.1205410291000
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hopefully it is full now.<br><br><a href="http://pastebin.ca/940929">http://pastebin.ca/940929</a><br><br><div class="gmail_quote">On Thu, Mar 13, 2008 at 12:48 PM, Takashi Iwai &lt;<a href="mailto:tiwai@suse.de">tiwai@suse.de</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">At Wed, 12 Mar 2008 18:17:43 +0100,<br>
<div><div></div><div class="Wj3C7c">Rene Herman wrote:<br>
&gt;<br>
&gt; On 12-03-08 17:59, Takashi Iwai wrote:<br>
&gt;<br>
&gt; &gt; At Wed, 12 Mar 2008 17:39:48 +0100,<br>
&gt; &gt; Rene Herman wrote:<br>
&gt; &gt;&gt; On 12-03-08 15:43, Takashi Iwai wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; At Tue, 11 Mar 2008 23:01:39 +0100,<br>
&gt; &gt;&gt;&gt; Rene Herman wrote:<br>
&gt; &gt;&gt;&gt;&gt; On 11-03-08 08:24, Gadi Oron wrote:<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; I am trying to record sound on an old Thinkpad T22 that uses the cs46xx<br>
&gt; &gt;&gt;&gt;&gt;&gt; sound driver.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Each time you start to record you have a 10% chance of having the<br>
&gt; &gt;&gt;&gt;&gt;&gt; recording completely distorted and having a metallic sound. When you<br>
&gt; &gt;&gt;&gt;&gt;&gt; look at the waveform it looks as though there are small segments with<br>
&gt; &gt;&gt;&gt;&gt;&gt; sharp transitions between them, a little like if these segments were<br>
&gt; &gt;&gt;&gt;&gt;&gt; moved a little from their correct place.<br>
&gt; &gt;&gt;&gt;&gt; No insights, but I confirm the bug with a TerraTec DMX XFire 1024 (CS4624).<br>
&gt; &gt;&gt;&gt; Hm, cs46xx driver hasn&#39;t been much changes since long time ago (around<br>
&gt; &gt;&gt;&gt; year 2005). &nbsp;The only big change was about some PM fixes, and I don&#39;t<br>
&gt; &gt;&gt;&gt; think it&#39;s relevant... &nbsp;Could you run als-info.sh to get the status?<br>
&gt; &gt;&gt; At:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; <a href="http://pastebin.ca/939784" target="_blank">http://pastebin.ca/939784</a><br>
&gt; &gt;<br>
&gt; &gt; The output seems truncated. &nbsp;Could you give the generated file via<br>
&gt; &gt; &quot;alsactl -f somefile store&quot;, just to be sure ?<br>
&gt;<br>
&gt; Hmm, alsa-info.sh freshly downloaded from current hg.<br>
<br>
</div></div>Is the original data also truncated at the middle or is it a paste.bin<br>
problem?<br>
<br>
&gt; &nbsp; &nbsp; &nbsp; control.26 {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; comment.access &#39;read write&#39;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; comment.type INTEGER<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; comment.count 2<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; comment.range &#39;0 - 32767&#39;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; iface MIXER<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; name &#39;ADC Volume&#39;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; value.0 29492<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; value.1 29492<br>
&gt; &nbsp; &nbsp; &nbsp; }<br>
<br>
Try to put this to full once.<br>
<font color="#888888"><br>
<br>
Takashi<br>
</font></blockquote></div><br>

------=_Part_8138_30196855.1205410291000--


--===============0616414278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0616414278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============0616414278==--
