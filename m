From: "Vishwas P S" <vishwas.ps@gmail.com>
Subject: Re: Alsamixer naming conventions
Date: Tue, 19 Sep 2006 17:51:23 +0530
Message-ID: <64cf23610609190521h1ef0251md7f04be932e0da6@mail.gmail.com>
References: <64cf23610609190458hea9a617w98e4f31f7f50d759@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0404311073=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <64cf23610609190458hea9a617w98e4f31f7f50d759@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============0404311073==
Content-Type: multipart/alternative;
	boundary="----=_Part_61801_30975863.1158668483174"

------=_Part_61801_30975863.1158668483174
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Adding to the below mail, even if I define a component as "Master Playback
Balance", in the alsamixer window, I could see two components as "Master
Playback Balance" and "Master Playback Balance capture" ..

I would like to know If I need to modify any other kcontrol fields to make
it only for playback or only for capture..

Rgds
Vishwas


On 9/19/06, Vishwas P S <vishwas.ps@gmail.com> wrote:
>
>  Group,
>
> I'be been having problems with naming kcontrol structs and the way they
> are displayed in Alsamixer GUI window.
> I created a balance control to vary the balance b/n L and R of only
> playback stream and named it "Balance"
> But when I do alsamixer -V all, it shows two components one being Balance
> playback and the other Balance capture.
>
> How do I make a component only for playback or only for capture? Any
> naming conventions to be followed?
>
> Any help would be great
>
> Regards
>  Vishwas
>

------=_Part_61801_30975863.1158668483174
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Adding to the below mail, even if I define a component as &quot;Master Playback Balance&quot;, in the alsamixer window, I could see two components as &quot;Master Playback Balance&quot; and &quot;Master Playback Balance capture&quot; ..
</div>
<div>&nbsp;</div>
<div>I would like to know If I need to modify any other kcontrol fields to make it only for playback or only for capture..</div>
<div>&nbsp;</div>
<div>Rgds</div>
<div>Vishwas<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 9/19/06, <b class="gmail_sendername">Vishwas P S</b> &lt;<a href="mailto:vishwas.ps@gmail.com">vishwas.ps@gmail.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div>Group,</div>
<div>&nbsp;</div>
<div>I'be been having problems with naming kcontrol structs and the way they are displayed in Alsamixer GUI window.</div>
<div>I created a balance control to vary the balance b/n L and R of only playback stream and named it &quot;Balance&quot;</div>
<div>But when I do alsamixer -V all, it shows two components one being Balance playback and the other Balance capture.</div>
<div>&nbsp;</div>
<div>How do I make a component only for playback or only for capture? Any naming conventions to be followed?</div>
<div>&nbsp;</div>
<div>Any help would be great</div>
<div>&nbsp;</div>
<div>Regards</div></div>
<div><span class="sg">
<div>Vishwas</div></span></div></blockquote></div><br>

------=_Part_61801_30975863.1158668483174--


--===============0404311073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0404311073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0404311073==--
