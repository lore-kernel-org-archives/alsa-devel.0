From: "Aditya Shankar" <mc.aditya@gmail.com>
Subject: Query regarding ALSA control interface
Date: Fri, 2 Feb 2007 12:22:40 +0530
Message-ID: <24a2bfdf0702012252l30ddbb4cs3eebfbab8e11a5ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0705928905=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

--===============0705928905==
Content-Type: multipart/alternative;
	boundary="----=_Part_15176_14550049.1170399160479"

------=_Part_15176_14550049.1170399160479
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

I have a small query regarding mixer controls. I work on a custom ARM
platform and am trying to get the control interface working.

I have defined a kcontrols structure and have initialized the name field to
"Master Capture Route". This does not show up as a control
when i run alsamixer but works well in OSS Emulation mode.

I did a alsactl store and found this in asound.state file..

control.6 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 7 (step 1)'
                iface MIXER
                name 'Master Capture Route'
                value 0
        }

The value field is initialized to an integer value in the case off all other
controls but here I find it to be 0. Is this the reason why i'm not finding
the control in the alsamixer window.? Can anybody let me know? Or Is there a
way to  get  the control component  working in both modes using a common
name??

Thanks in Advance,
Aditya

------=_Part_15176_14550049.1170399160479
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi All,</div>
<div>&nbsp;</div>
<div>I have a small query regarding mixer controls. I work on a custom ARM platform and am trying to get the control interface working.</div>
<div>&nbsp;</div>
<div>I have defined a kcontrols structure and have initialized the name field to &quot;Master Capture Route&quot;. This does not show up as a control </div>
<div>when i run alsamixer but works well in OSS Emulation mode. </div>
<div>&nbsp;</div>
<div>I did a alsactl store and found this in asound.state file..</div>
<div>&nbsp;</div>
<div>control.6 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; comment.access &#39;read write&#39;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; comment.type INTEGER<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; comment.count 1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; comment.range &#39;0 - 7 (step 1)&#39;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iface MIXER
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name &#39;Master Capture Route&#39;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</div>
<div>&nbsp;</div>
<div>The value field is initialized to an integer value in the case off all other controls but here I find it to be 0. Is this the reason why i&#39;m not finding the control in the alsamixer window.? Can anybody let me know? Or&nbsp;Is there a way to &nbsp;get&nbsp; the control component &nbsp;working in both modes using a common name?? 
</div>
<div>&nbsp;</div>
<div>Thanks in Advance,</div>
<div>Aditya</div>

------=_Part_15176_14550049.1170399160479--


--===============0705928905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0705928905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0705928905==--
