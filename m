From: "Vishwas P S" <vishwas.ps@gmail.com>
Subject: Query rgd Alsa recording and asoundrc
Date: Fri, 8 Sep 2006 19:16:04 +0530
Message-ID: <64cf23610609080646t54e4e141n243293f9c47df1ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0612993064=="
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

--===============0612993064==
Content-Type: multipart/alternative;
	boundary="----=_Part_12727_8518752.1157723164110"

------=_Part_12727_8518752.1157723164110
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

I'm working on porting ALSA to an ARM based custom platform with a custom
made audio chip.
I've worked prev on OSS but am new to ALSA.

1) I'm facing some issues while recording sound with arecord. The sound I
record is pretty noisy due to signal clipping. I've ensured that the audio
chip's Mic gain is kept at a minimum but this continues to happen.
(For the same hardware config and Mic settings OSS produces very feeble
sound whereas ALSA produces very loud noise with clipping noise)

2) Where can I find the configuration files .asoundrc and what is it's
significance?. I did not find any such file in my RootFS
I mean is it required only in OSS emulation mode or is it significant even
for native alsa arecord testapp?

3) I've added some kcontrols to my sound card. These controls are perfectly
accesible thru amixer testapp (and they work fine) but Alsamixer is not able
to display many of these controls. Even if it does for some, the mappings
don't seem to be correct. Any thoughts on this?

Pl let me know if any of you have any ideas on this/ faced similar issues.
It would be great if you guys can point me to an address where I can find
good documentation on ALSA control and data flow.

Thanks in advance
Regards
Vishwas

------=_Part_12727_8518752.1157723164110
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi All,</div>
<div>&nbsp;</div>
<div>I'm working on porting ALSA to an ARM based custom platform with a custom made audio chip.</div>
<div>I've worked prev on OSS but am new to ALSA.</div>
<div>&nbsp;</div>
<div>1) I'm facing some issues while recording sound with arecord. The sound I record is pretty noisy due to signal clipping. I've ensured that the audio chip's Mic gain is kept at a minimum but this continues to happen.
</div>
<div>(For the same hardware config and Mic settings OSS produces very feeble sound whereas ALSA produces very loud noise with clipping noise)</div>
<div>&nbsp;</div>
<div>2) Where can I find the configuration files .asoundrc and what is it's significance?. I did not find any such file in my RootFS</div>
<div>I mean is it required only in&nbsp;OSS emulation mode or is it significant even for native alsa arecord testapp?</div>
<div>&nbsp;</div>
<div>3) I've added some kcontrols to my sound card. These controls are perfectly accesible thru amixer testapp (and they work fine)&nbsp;but Alsamixer is not able to display many of these controls. Even if it does for some, the mappings don't seem to be correct. Any thoughts on this?
</div>
<div>&nbsp;</div>
<div>Pl let me know if any of you have any ideas on this/ faced similar issues.</div>
<div>It would be great if you guys can point me to an address where I can find good documentation on ALSA control and data flow.</div>
<div>&nbsp;</div>
<div>Thanks in advance</div>
<div>Regards</div>
<div>Vishwas</div>

------=_Part_12727_8518752.1157723164110--


--===============0612993064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0612993064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0612993064==--
