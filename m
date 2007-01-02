From: "=?ISO-8859-1?Q?Cl=E9ment_Guedez?=" <klem.dev@gmail.com>
Subject: Re: ESI waveterminal192M source code rewrite
Date: Tue, 2 Jan 2007 12:02:27 +0100
Message-ID: <965c08610701020302q1742b9b0s7661862c68847f5b@mail.gmail.com>
References: <965c08610612200949q66a9822am78b4a52f2ca466e3@mail.gmail.com>
	<s5hfyba4dxt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1994040902=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hfyba4dxt.wl%tiwai@suse.de>
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

--===============1994040902==
Content-Type: multipart/alternative;
	boundary="----=_Part_89096_12580197.1167735747533"

------=_Part_89096_12580197.1167735747533
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is my changelog, I hope it's what you want. Sorry for the late,
christmas take me time ...
Tell me if you need it in a file.
For the TLV support, I will work on it. The goal is to show/set values in dB
for the level in the mixer, instead of the default 100 scale. So it's just a
scale value adaptation, no special fonctionnality need ? And I will see in
other driver for example

===============================================
Summary: Add support of the ESI Waveterminal 192M to the ice1724 ALSA driver

This patch adds the support of the ESI Waveterminal 192M soundcard to the
ice1724 familly ALSA driver.
It's a semi-professionnal soundcard for home studio : many I/O and a quality
of sound is good, better than consumer cards, but less musical than
professional cards.
It use a Via Envy24ht chipset as ice1724 soundcard, Sigmatel stac9640
ADC/DAC for the analog I/O as Prodigy192, and Atmel ak4114 for S/PDIF as ESI
Julia.
Is working : the 8 analog outputs, the analog inputs 1&2, the mic input 1,
the coaxial & optical digital outputs.

Signed-off-by: Clement Guedez <klem.dev@gmail.com>
========================================================


Thanks for all.
And I wish you a happy new year ! and to everyone too.

2006/12/20, Takashi Iwai <tiwai@suse.de>:
>
> At Wed, 20 Dec 2006 18:49:20 +0100,
> =?ISO-8859-1?Q?Cl=E9ment_Guedez?= wrote:
> >
> > Sorry the mess, I'm a young and unexperienced developer
> > Thanks for the answer and the advice, it will improve my work
> > I hope you will find this version better
>
> Thanks for the new patch.  It looks much better and ready to be
> merged.
>
> Could you provide a changelog and a sign-off line for committing?
> Typically, it's like below:
>
> ================================================================
> Summary: Add support of XYZ to ABC
>
> This patch adds the support of XYZ to ABC.
> Blah blah .....
>
> Signed-off-by: Joh Doh <joh@doh.com>
> ================================================================
>
> Also, if you have time, try to implement TLV support.
> It represents the dB scale information so that the mixer can show/set
> values in dB level.
>
>
> Takashi
>

------=_Part_89096_12580197.1167735747533
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is my changelog, I hope it&#39;s what you want. Sorry for the late, christmas take me time ...<br>Tell me if you need it in a file.<br>For the TLV support, I will work on it. The goal is to show/set values in dB for the level in the mixer, instead of the default 100 scale. So it&#39;s just a scale value adaptation, no special fonctionnality need ? And I will see in other driver for example
<br><br>===============================================<br>Summary: Add support of the ESI Waveterminal 192M to the ice1724 ALSA driver<br><br>This patch adds the support of the ESI Waveterminal 192M soundcard to the ice1724 familly ALSA driver.
<br>It&#39;s a semi-professionnal soundcard for home studio : many I/O and a quality of sound is good, better than consumer cards, but less musical than professional cards.<br>It use a Via Envy24ht chipset as ice1724 soundcard, Sigmatel stac9640 ADC/DAC for the analog I/O as Prodigy192, and Atmel ak4114 for S/PDIF as ESI Julia.
<br>Is working : the 8 analog outputs, the analog inputs 1&amp;2, the mic input 1, the coaxial &amp; optical digital outputs.<br><br>Signed-off-by: Clement Guedez &lt;<a href="mailto:klem.dev@gmail.com">klem.dev@gmail.com
</a>&gt;<br>========================================================<br><br><br>Thanks for all.<br>And I wish you a happy new year ! and to everyone too.<br><br><div><span class="gmail_quote">2006/12/20, Takashi Iwai &lt;
<a href="mailto:tiwai@suse.de">tiwai@suse.de</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">At Wed, 20 Dec 2006 18:49:20 +0100,
<br>=?ISO-8859-1?Q?Cl=E9ment_Guedez?= wrote:<br>&gt;<br>&gt; Sorry the mess, I&#39;m a young and unexperienced developer<br>&gt; Thanks for the answer and the advice, it will improve my work<br>&gt; I hope you will find this version better
<br><br>Thanks for the new patch.&nbsp;&nbsp;It looks much better and ready to be<br>merged.<br><br>Could you provide a changelog and a sign-off line for committing?<br>Typically, it&#39;s like below:<br><br>================================================================
<br>Summary: Add support of XYZ to ABC<br><br>This patch adds the support of XYZ to ABC.<br>Blah blah .....<br><br>Signed-off-by: Joh Doh &lt;<a href="mailto:joh@doh.com">joh@doh.com</a>&gt;<br>================================================================
<br><br>Also, if you have time, try to implement TLV support.<br>It represents the dB scale information so that the mixer can show/set<br>values in dB level.<br><br><br>Takashi<br></blockquote></div><br>

------=_Part_89096_12580197.1167735747533--


--===============1994040902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1994040902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1994040902==--
