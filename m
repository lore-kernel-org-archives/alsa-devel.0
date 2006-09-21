From: "Vishwanath T. K." <vishytk@gmail.com>
Subject: Re: ALSA 1.0.13rc2 release
Date: Fri, 22 Sep 2006 01:00:21 +0530
Message-ID: <55f590609211230h3e29e6a5w31040746d101a92c@mail.gmail.com>
References: <Pine.LNX.4.61.0609151756270.7856@tm8103.perex-int.cz>
	<s5h7izzj4bt.wl%tiwai@suse.de>
	<55f590609190904p4ab4181bq6855a9f710d89b56@mail.gmail.com>
	<s5hvenjhm7c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1030684045=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hvenjhm7c.wl%tiwai@suse.de>
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

--===============1030684045==
Content-Type: multipart/alternative;
	boundary="----=_Part_13286_20905692.1158867021375"

------=_Part_13286_20905692.1158867021375
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

update the kernel to 2.6.18, alsa-driver 1.0.13rc2. Still having problem
with snd-hda-intel and 5.1 sound.

I get sound only in three speakers while remaing two produses noise.

driver options used:
options snd-hda-intel index=0 model=6stack position_fix=1 disable_msi=1

On 9/19/06, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Tue, 19 Sep 2006 21:34:33 +0530,
> Vishwanath T. K. wrote:
> >
> > I updated the driver to version 1.0.13rc2 to solve my problem of sound
> not coming in
> > all speakers and encountered the problem.
> >
> > When the driver is loaded the system hangs. Adding the mentioned option
> solves this
> > problem.
>
> OK, and which kernel version are you using?
>
>
> Takashi
>

------=_Part_13286_20905692.1158867021375
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

update the kernel to 2.6.18, alsa-driver 1.0.13rc2. Still having problem with snd-hda-intel and 5.1 sound.<br><br>I get sound only in three speakers while remaing two produses noise.<br><br>driver options used:<br>options snd-hda-intel index=0 model=6stack position_fix=1 disable_msi=1
<br><br><div><span class="gmail_quote">On 9/19/06, <b class="gmail_sendername">Takashi Iwai</b> &lt;<a href="mailto:tiwai@suse.de">tiwai@suse.de</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
At Tue, 19 Sep 2006 21:34:33 +0530,<br>Vishwanath T. K. wrote:<br>&gt;<br>&gt; I updated the driver to version 1.0.13rc2 to solve my problem of sound not coming in<br>&gt; all speakers and encountered the problem.<br>&gt;
<br>&gt; When the driver is loaded the system hangs. Adding the mentioned option solves this<br>&gt; problem.<br><br>OK, and which kernel version are you using?<br><br><br>Takashi<br></blockquote></div><br>

------=_Part_13286_20905692.1158867021375--


--===============1030684045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1030684045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1030684045==--
