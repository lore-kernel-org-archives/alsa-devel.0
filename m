From: sameer.kittur@flextronicssoftware.com
Subject: Re: Dmix and non SND_PCM_TYPE_HW slaves
Date: Thu, 17 Nov 2005 14:46:13 +0530
Message-ID: <OF7CF9A882.529D1307-ON652570BC.0032EC6C-652570BC.0032EC74@flextronicssoftware.com>
Mime-Version: 1.0
Content-Type: text/html;
	charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: sameer.kittur@flextronicssoftware.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

<div>Hi,<br>
<br>
&nbsp;&nbsp;&nbsp; Thank you very much for your replies. We were
evaluating different approaches for a telecom solution to do mixing of
2 mono 16bit 8KHz PCM streams. This stream will also contribute as a
reference signal to a software acoustic echo cancellation module. We
were toying with an idea to setup the audio stream path via the mixer
plugin and an AEC plugin towards a hardware slave.<br>
<br>
Thanks,<br>
Sameer.<br>
<br></div><font color=3D"#990099">-----James Courtier-Dutton &lt;James@supe=
rbug.co.uk&gt; wrote: -----<br><br></font><blockquote style=3D"border-left:=
 2px solid rgb(0, 0, 0); padding-right: 0px; padding-left: 5px; margin-left=
: 5px; margin-right: 0px;">To: sameer.kittur@flextronicssoftware.com<br>Fro=
m: James Courtier-Dutton &lt;James@superbug.co.uk&gt;<br>Date: 11/16/2005 1=
1:04PM<br>cc: alsa-devel@lists.sourceforge.net<br>Subject: Re: [Alsa-devel]=
 Dmix and non SND=5FPCM=5FTYPE=5FHW slaves<br><br><font face=3D"monospace" =
size=3D"3">sameer.kittur@flextronicssoftware.com wrote:<br>&gt; Hi all,<br>=
&gt; <br>&gt; &nbsp; &nbsp; Is there a reason why Dmix cannot use a non SND=
=5FPCM=5FTYPE=5FHW slave? Is there <br>&gt; no way to re-direct the Dmix ou=
tput to another plugin or an external I/O or a <br>&gt; filter plugin?<br>&=
gt; <br>&gt; Thanks,<br>&gt; Sameer.<br>&gt; <br><br>Why would you want to =
do this?<br>The purpose of dmix is to simply work around the limitation of =
the hardware.<br>If you want some other purpose, I would suggest using a so=
und server <br>like arts or a different approach altogether like using jack=
d<br><br>James<br><br></font></blockquote><br><br>*****FSS-Private *****" D=
ISCLAIMER: This message is proprietary to Flextronics Software Systems Limi=
ted (FSS) and is intended solely for the use of the individual to whom it i=
s addressed. It may contain  privileged or confidential information and sho=
uld not be circulated or used for any purpose other than for what it is int=
ended. If you have received this message in error&#44; please notify the or=
iginator immediately. If you are not the intended recipient&#44; you are no=
tified that you are strictly prohibited from using&#44; copying&#44; alteri=
ng&#44; or disclosing the contents of this message. FSS accepts no responsi=
bility for loss or damage arising from the use of the information transmitt=
ed by this email including damage from virus."=


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
