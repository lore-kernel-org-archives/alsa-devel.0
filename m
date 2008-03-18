From: "Alexander Indenbaum" <alexander.indenbaum@gmail.com>
Subject: Re: [alsa-devel] /usr/share/alsa/alsa.conf :and file
	extention
Date: Tue, 18 Mar 2008 02:27:46 +0200
Message-ID: <cab05a880803171727u6df4897an677d197eec4c28e6@mail.gmail.com>
References: <cab05a880803161957j7a82e04cma094afda62d5cdab@mail.gmail.com>
	<47DDE2F7.7000904@keyaccess.nl> <s5hmyoxu66g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0962938447=="
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <s5hmyoxu66g.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@keyaccess.nl>
Cc: alsa-user <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============0962938447==
Content-Type: multipart/alternative;
	boundary="----=_Part_10941_30542036.1205800066552"

------=_Part_10941_30542036.1205800066552
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> > pcm.!default {
> >          type    file
> >          slave   {
> >                  pcm     null
> >          }
> >          file    "/tmp/pcm.out"
> > }
>

OK  - this goes to /etc/alsa.conf


>
> >
> > Exactly why you need that slave definition I'm not sure either, but it
> seems
> > you do.
>
> The file plugin requires the slave for its configuration and as the
> timing source.  Using "null" is just to accept any config and feed the
> data as fast as possible.  If you need to save the data as if it's
> being played, use the kernel dummy driver as the slave.


OK, I compiled alsa-drivers with Dummy as one and only card and loaded it
into the kernel:
# cat /proc/asound/card0/id
Dummy

Still no PCM in /tmp/pcm.out. I get following error messages though:
"(snd_determine_driver) could not open control for card 0"
"(_snd_config_evaluate) function snd_func_concat returned error: No such
file or directory"
"(snd_func_concat) error evaluating strings"
"(_snd_config_evaluate) function snd_func_concat returned error: No such
file or directory"
"(snd_func_refer) error evaluating name"
"(_snd_config_evaluate) function snd_func_refer returned error: No such file
or directory"
"(snd_config_expand) Evaluate error: No such file or directory"
"(snd_pcm_open_noupdate) Unknown PCM default"
"(_snd_pcm_plug_open) Unknown field hint"

Any clues?

Alexander Indenbaum

------=_Part_10941_30542036.1205800066552
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">&gt; pcm.!default {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;type &nbsp; &nbsp;file<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;slave &nbsp; {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pcm &nbsp; &nbsp; null<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;file &nbsp; &nbsp;&quot;/tmp/pcm.out&quot;<br>
&gt; }</div></blockquote><div><br>OK&nbsp; - this goes to /etc/alsa.conf<br>&nbsp;<br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">
<br>
&gt;<br>
&gt; Exactly why you need that slave definition I&#39;m not sure either, but it seems<br>
&gt; you do.<br>
<br>
</div>The file plugin requires the slave for its configuration and as the<br>
timing source. &nbsp;Using &quot;null&quot; is just to accept any config and feed the<br>
data as fast as possible. &nbsp;If you need to save the data as if it&#39;s<br>
being played, use the kernel dummy driver as the slave.</blockquote><div><br>OK, I compiled alsa-drivers with Dummy as one and only card and loaded it into the kernel:<br># cat /proc/asound/card0/id <br>Dummy<br><br>Still no PCM in /tmp/pcm.out. I get following error messages though:<br>
&quot;(snd_determine_driver) could not open control for card 0&quot;<br>&quot;(_snd_config_evaluate) function snd_func_concat returned error: No such file or directory&quot;<br>&quot;(snd_func_concat) error evaluating strings&quot;<br>
&quot;(_snd_config_evaluate) function  snd_func_concat returned error: No such file or directory&quot;<br>&quot;(snd_func_refer) error evaluating name&quot;<br>
&quot;(_snd_config_evaluate) function  snd_func_refer returned error: No such file or directory&quot;<br>
&quot;(snd_config_expand) Evaluate error: No such file or directory&quot;<br>&quot;(snd_pcm_open_noupdate) Unknown PCM default&quot;<br>
&quot;(_snd_pcm_plug_open) Unknown field hint&quot;<br><br>Any clues?&nbsp;</div></div><br>Alexander Indenbaum

------=_Part_10941_30542036.1205800066552--


--===============0962938447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0962938447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============0962938447==--
