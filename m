From: "Vishwas P S" <vishwas.ps@gmail.com>
Subject: Re: Alsamixer naming conventions
Date: Wed, 20 Sep 2006 18:35:38 +0530
Message-ID: <64cf23610609200605j4cb27060y8b9bb1c47e93d5ea@mail.gmail.com>
References: <64cf23610609190458hea9a617w98e4f31f7f50d759@mail.gmail.com>
	<64cf23610609190521h1ef0251md7f04be932e0da6@mail.gmail.com>
	<s5h8xkfj4i8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1872266660=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h8xkfj4i8.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============1872266660==
Content-Type: multipart/alternative;
	boundary="----=_Part_109_5220220.1158757538846"

------=_Part_109_5220220.1158757538846
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Thanks a Ton. This solved my problem.
I'm now able to see proper controls under Playback, Capture and All modes ..

Thanks again
Vishwas


On 9/19/06, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Tue, 19 Sep 2006 17:51:23 +0530,
> Vishwas P S wrote:
> >
> > Adding to the below mail, even if I define a component as "Master
> Playback Balance",
> > in the alsamixer window, I could see two components as "Master Playback
> Balance" and
> > "Master Playback Balance capture" ..
> >
> > I would like to know If I need to modify any other kcontrol fields to
> make it only for
> > playback or only for capture..
>
> The playback- and capture-specific control names have a style
> "XXX (Payback|Catpure) (Switch|Volume)", such as "Master Playback
> Switch" or "Mic Capture Volume".  The other suffices are not parsed as
> the valid playback/capture modifies, so "Master Playback Balance" is
> handled as a global control element without directional information.
>
> It's a recent feature (or bug) of alsa-lib that global mixer elements
> are handled as both playback and capture elements in the mixer
> abstraction layer.  (In the earlier version, it appeared only in
> playback.)  I don't like this new feature, too, honestly.
>
> Anyway, in your case, rename it like "Master Balance Playback Switch"
> or so.  Then it should be handled as "Master Balance" for playback.
>
>
> Takashi
>

------=_Part_109_5220220.1158757538846
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>Thanks a Ton. This solved my problem.</div>
<div>I'm now able to see proper controls under Playback, Capture and All modes ..</div>
<div>&nbsp;</div>
<div>Thanks again</div>
<div>Vishwas<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 9/19/06, <b class="gmail_sendername">Takashi Iwai</b> &lt;<a href="mailto:tiwai@suse.de">tiwai@suse.de</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">At Tue, 19 Sep 2006 17:51:23 +0530,<br>Vishwas P S wrote:<br>&gt;<br>&gt; Adding to the below mail, even if I define a component as &quot;Master Playback Balance&quot;,
<br>&gt; in the alsamixer window, I could see two components as &quot;Master Playback Balance&quot; and<br>&gt; &quot;Master Playback Balance capture&quot; ..<br>&gt;<br>&gt; I would like to know If I need to modify any other kcontrol fields to make it only for
<br>&gt; playback or only for capture..<br><br>The playback- and capture-specific control names have a style<br>&quot;XXX (Payback|Catpure) (Switch|Volume)&quot;, such as &quot;Master Playback<br>Switch&quot; or &quot;Mic Capture Volume&quot;.&nbsp;&nbsp;The other suffices are not parsed as
<br>the valid playback/capture modifies, so &quot;Master Playback Balance&quot; is<br>handled as a global control element without directional information.<br><br>It's a recent feature (or bug) of alsa-lib that global mixer elements
<br>are handled as both playback and capture elements in the mixer<br>abstraction layer.&nbsp;&nbsp;(In the earlier version, it appeared only in<br>playback.)&nbsp;&nbsp;I don't like this new feature, too, honestly.<br><br>Anyway, in your case, rename it like &quot;Master Balance Playback Switch&quot;
<br>or so.&nbsp;&nbsp;Then it should be handled as &quot;Master Balance&quot; for playback.<br><br><br>Takashi<br></blockquote></div><br>

------=_Part_109_5220220.1158757538846--


--===============1872266660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1872266660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1872266660==--
