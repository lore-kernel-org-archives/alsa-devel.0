From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: [Realtek ALC260] Can't enable SPDIF out
Date: Sat, 02 Sep 2006 12:09:40 -0700
Message-ID: <1157224180.19695.10.camel@razman>
References: <200609010118.k811I1KU028677@auster.physics.adelaide.edu.au>
	<44F8767E.4050203@p54A1ACFB.dip0.t-ipconnect.de>
	<44F9605E.3000404@p54A184AE.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1861437256=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44F9605E.3000404@p54A184AE.dip0.t-ipconnect.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1861437256==
Content-Type: multipart/alternative; boundary="=-gs/VAoAAPraIFssBtsxE"


--=-gs/VAoAAPraIFssBtsxE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Just for grins, could you test the alsa package from RealTek located
here:
ftp://202.65.194.18/pc/hda/alc880d/realtek-linux-audiopack-4.05b.tar.bz2

I was looking it over, and although it's based on alsa 1.0.9b, there are
some new differences with the alc250 code (among other things) when
compared with the alsa-project tip.

If it works, I'll work on porting their changes into the mainstream.

Tobin

On Sat, 2006-09-02 at 12:43 +0200, Andreas Hartmann wrote:

> Hello,
> 
> one more information:
> 
> if model=auto is used and aplay -D spdif is used, the following devices
> are opened:
> 
> notebook1:/home/andreas # lsof | grep aplay | grep snd
> aplay      7701    andreas  mem       CHR     116,17                56211
> /dev/snd/pcmC0D1p
> aplay      7701    andreas    3u      CHR      116,0                57283
> /dev/snd/controlC0
> aplay      7701    andreas    5u      CHR     116,17                56211
> /dev/snd/pcmC0D1p
> 
> 
> 
> If aplay without any D-option is used, these devices are used (and analog
> sound is playing):
> 
> notebook1:/home/andreas # lsof | grep aplay | grep snd
> aplay      7691    andreas  mem       CHR     116,16                57223
> /dev/snd/pcmC0D0p
> aplay      7691    andreas    3r      CHR     116,33                57157
> /dev/snd/timer
> aplay      7691    andreas    5u      CHR     116,16                57223
> /dev/snd/pcmC0D0p
> aplay      7691    andreas    6u      CHR      116,0                57283
> /dev/snd/controlC0
> 
> 
> Obviously, another sounddevice is used for S/PDIF. Unfortunately there is
> no output at the headphone jack, which is used fot the S/PDIF-out, too.
> 
> aplay -l says:
> 
> **** List of PLAYBACK Hardware Devices ****
> card 0: Intel [HDA Intel], device 0: ALC260 Analog [ALC260 Analog]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: Intel [HDA Intel], device 1: ALC260 Digital [ALC260 Digital]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> 
> 
> Kind regards,
> Andreas Hartmann
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-gs/VAoAAPraIFssBtsxE
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
Just for grins, could you test the alsa package from RealTek located here:&nbsp; <A HREF="ftp://202.65.194.18/pc/hda/alc880d/realtek-linux-audiopack-4.05b.tar.bz2">ftp://202.65.194.18/pc/hda/alc880d/realtek-linux-audiopack-4.05b.tar.bz2</A><BR>
<BR>
I was looking it over, and although it's based on alsa 1.0.9b, there are some new differences with the alc250 code (among other things) when compared with the alsa-project tip.<BR>
<BR>
If it works, I'll work on porting their changes into the mainstream.<BR>
<BR>
Tobin<BR>
<BR>
On Sat, 2006-09-02 at 12:43 +0200, Andreas Hartmann wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Hello,</FONT>

<FONT COLOR="#000000">one more information:</FONT>

<FONT COLOR="#000000">if model=auto is used and aplay -D spdif is used, the following devices</FONT>
<FONT COLOR="#000000">are opened:</FONT>

<FONT COLOR="#000000">notebook1:/home/andreas # lsof | grep aplay | grep snd</FONT>
<FONT COLOR="#000000">aplay      7701    andreas  mem       CHR     116,17                56211</FONT>
<FONT COLOR="#000000">/dev/snd/pcmC0D1p</FONT>
<FONT COLOR="#000000">aplay      7701    andreas    3u      CHR      116,0                57283</FONT>
<FONT COLOR="#000000">/dev/snd/controlC0</FONT>
<FONT COLOR="#000000">aplay      7701    andreas    5u      CHR     116,17                56211</FONT>
<FONT COLOR="#000000">/dev/snd/pcmC0D1p</FONT>



<FONT COLOR="#000000">If aplay without any D-option is used, these devices are used (and analog</FONT>
<FONT COLOR="#000000">sound is playing):</FONT>

<FONT COLOR="#000000">notebook1:/home/andreas # lsof | grep aplay | grep snd</FONT>
<FONT COLOR="#000000">aplay      7691    andreas  mem       CHR     116,16                57223</FONT>
<FONT COLOR="#000000">/dev/snd/pcmC0D0p</FONT>
<FONT COLOR="#000000">aplay      7691    andreas    3r      CHR     116,33                57157</FONT>
<FONT COLOR="#000000">/dev/snd/timer</FONT>
<FONT COLOR="#000000">aplay      7691    andreas    5u      CHR     116,16                57223</FONT>
<FONT COLOR="#000000">/dev/snd/pcmC0D0p</FONT>
<FONT COLOR="#000000">aplay      7691    andreas    6u      CHR      116,0                57283</FONT>
<FONT COLOR="#000000">/dev/snd/controlC0</FONT>


<FONT COLOR="#000000">Obviously, another sounddevice is used for S/PDIF. Unfortunately there is</FONT>
<FONT COLOR="#000000">no output at the headphone jack, which is used fot the S/PDIF-out, too.</FONT>

<FONT COLOR="#000000">aplay -l says:</FONT>

<FONT COLOR="#000000">**** List of PLAYBACK Hardware Devices ****</FONT>
<FONT COLOR="#000000">card 0: Intel [HDA Intel], device 0: ALC260 Analog [ALC260 Analog]</FONT>
<FONT COLOR="#000000">  Subdevices: 1/1</FONT>
<FONT COLOR="#000000">  Subdevice #0: subdevice #0</FONT>
<FONT COLOR="#000000">card 0: Intel [HDA Intel], device 1: ALC260 Digital [ALC260 Digital]</FONT>
<FONT COLOR="#000000">  Subdevices: 1/1</FONT>
<FONT COLOR="#000000">  Subdevice #0: subdevice #0</FONT>


<FONT COLOR="#000000">Kind regards,</FONT>
<FONT COLOR="#000000">Andreas Hartmann</FONT>

<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">Using Tomcat but need to do more? Need to support web services, security?</FONT>
<FONT COLOR="#000000">Get stuff done quickly with pre-integrated technology to make your job easier</FONT>
<FONT COLOR="#000000">Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo</FONT>
<FONT COLOR="#000000"><A HREF="http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642</A></FONT>
<FONT COLOR="#000000">_______________________________________________</FONT>
<FONT COLOR="#000000">Alsa-devel mailing list</FONT>
<FONT COLOR="#000000"><A HREF="mailto:Alsa-devel@lists.sourceforge.net">Alsa-devel@lists.sourceforge.net</A></FONT>
<FONT COLOR="#000000"><A HREF="https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/alsa-devel</A></FONT>
</PRE>
</BLOCKQUOTE>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
-- <BR>
Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-gs/VAoAAPraIFssBtsxE--



--===============1861437256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1861437256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1861437256==--
