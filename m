From: "Alexander Indenbaum" <alexander.indenbaum@gmail.com>
Subject: /usr/share/alsa/alsa.conf :and file extention
Date: Mon, 17 Mar 2008 04:57:43 +0200
Message-ID: <cab05a880803161957j7a82e04cma094afda62d5cdab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1448045522=="
Return-path: <alsa-user-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: alsa-user <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============1448045522==
Content-Type: multipart/alternative;
	boundary="----=_Part_6440_11188141.1205722663149"

------=_Part_6440_11188141.1205722663149
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I'm playing with embedded system without any hardware sound device. I'd like
to grab sound from ALSA application, for instance Firefox displaying YouTube
clip inside flash plugin and to store  output PCM stream into file on local
disk. I got an advice to use File extension. So I defined following
/usr/share/alsa/alsa.conf

pcm.default{
        type
file
        file
/tmp/pcm.out
}

But when alsa lib still complains about
"Unknown PCM plughw:0,0"
"Cannot open shared library /usr/lib/alsa-lib/libasound_module_pcm_file.so"

I have a nasty feeling that syntax of my /usr/share/alsa/alsa.conf  is
broken beyond recognition. I wonder what is the correct way to define my
situation:
* No real audio devices
* All sound is output goes to file as PCM stream

Do you have a clue?
Alexander Indenbaum

------=_Part_6440_11188141.1205722663149
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div class="gmail_quote">Hello,<br><br>I&#39;m playing with embedded system without any hardware sound device. I&#39;d like to grab sound from ALSA application, for instance Firefox
displaying YouTube clip inside flash plugin and to store&nbsp; output PCM
stream into file on local disk. I got an advice to use File extension. So I defined following /usr/share/alsa/alsa.conf <br><br>pcm.default {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; type file&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; file /tmp/pcm.out&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
 ;&nbsp; <br>}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br><br>But when alsa lib still complains about <br>
&quot;Unknown PCM plughw:0,0&quot;<br>&quot;Cannot open shared library /usr/lib/alsa-lib/libasound_module_pcm_file.so&quot;<br><br>I have a nasty feeling that syntax of my  /usr/share/alsa/alsa.conf&nbsp; is broken beyond recognition. I wonder what is the correct way to define my situation:<br>
* No real audio devices<br>* All sound is output goes to file as PCM stream<br>
<br>Do you have a clue?<br></div>Alexander Indenbaum

------=_Part_6440_11188141.1205722663149--


--===============1448045522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1448045522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============1448045522==--
