From: "Aditya Shankar" <mc.aditya@gmail.com>
Subject: Re: Query regarding ALSA control interface
Date: Tue, 6 Feb 2007 17:08:33 +0530
Message-ID: <24a2bfdf0702060338l72fc651dsedd0ed57e2e71270@mail.gmail.com>
References: <24a2bfdf0702012252l30ddbb4cs3eebfbab8e11a5ba@mail.gmail.com>
	<1170404256.27352.1172535505@webmail.messagingengine.com>
	<24a2bfdf0702020054g68ccd946v180eae48c2d55f0b@mail.gmail.com>
	<1170698187.1391.1173011395@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0353531855=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1170698187.1391.1173011395@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

--===============0353531855==
Content-Type: multipart/alternative;
	boundary="----=_Part_4743_32286353.1170761913217"

------=_Part_4743_32286353.1170761913217
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 2/5/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
>
> (please don't top-post)
> Aditya Shankar wrote:
> > Thanks for your reply. But my problem is not that I dont see any capture
> > controls. I am not able to get that particular control which I had
> mentioned
> > in my earlier mail.
>
> Please show the output of "amixer controls" and "amixer scontrols".
>
>
> Regards,
> Clemens
>

Hi Clemens,

The output of amixer controls is as below..

numid=4,iface=MIXER,name='Master Balance Playback Volume'
numid=3,iface=MIXER,name='Master Monoconfig Playback Volume'
numid=1,iface=MIXER,name='Master Output Playback Volume'
numid=2,iface=MIXER,name='Master Playback Volume'
numid=6,iface=MIXER,name='Master Capture Route'
numid=5,iface=MIXER,name='Master Capture Volume'

The output of amixer scontrols is

Simple mixer control 'Master',0
Simple mixer control 'Master Balance',0
Simple mixer control 'Master Monoconfig',0
Simple mixer control 'Master Output',0

Please let me know what you think..

Regards,
Aditya

------=_Part_4743_32286353.1170761913217
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br>
<div><span class="gmail_quote">On 2/5/07, <b class="gmail_sendername">Clemens Ladisch</b> &lt;<a href="mailto:cladisch@fastmail.net">cladisch@fastmail.net</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">(please don&#39;t top-post)<br>Aditya Shankar wrote:<br>&gt; Thanks for your reply. But my problem is not that I dont see any capture
<br>&gt; controls. I am not able to get that particular control which I had mentioned<br>&gt; in my earlier mail.<br><br>Please show the output of &quot;amixer controls&quot; and &quot;amixer scontrols&quot;.<br><br><br>Regards,
<br>Clemens<br></blockquote></div>
<div>&nbsp;</div>
<div>Hi Clemens,</div>
<div><br>The output of amixer controls is as below..</div>
<div>&nbsp;</div>
<div>numid=4,iface=MIXER,name=&#39;Master Balance Playback Volume&#39;<br>numid=3,iface=MIXER,name=&#39;Master Monoconfig Playback Volume&#39;<br>numid=1,iface=MIXER,name=&#39;Master Output Playback Volume&#39;<br>numid=2,iface=MIXER,name=&#39;Master Playback Volume&#39;
<br>numid=6,iface=MIXER,name=&#39;Master Capture Route&#39;<br>numid=5,iface=MIXER,name=&#39;Master Capture Volume&#39;</div>
<div>&nbsp;</div>
<div>The output of amixer scontrols is </div>
<div>&nbsp;</div>
<div>Simple mixer control &#39;Master&#39;,0<br>Simple mixer control &#39;Master Balance&#39;,0<br>Simple mixer control &#39;Master Monoconfig&#39;,0<br>Simple mixer control &#39;Master Output&#39;,0</div>
<div>&nbsp;</div>
<div>Please let me know what you think..</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Aditya</div>
<div>&nbsp;</div>

------=_Part_4743_32286353.1170761913217--


--===============0353531855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0353531855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0353531855==--
