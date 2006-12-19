From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Problems with hda-intel driver
Date: Tue, 19 Dec 2006 14:29:02 -0800
Message-ID: <1166567342.25873.140.camel@razman>
References: <1166566334.2082.15.camel@knc-se-lap0001.knorca.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1812532694=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1166566334.2082.15.camel@knc-se-lap0001.knorca.se>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Mathias Friman <mathias.friman@knorca.se>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============1812532694==
Content-Type: multipart/alternative; boundary="=-ORLVZpom3FTR4vjoQM43"


--=-ORLVZpom3FTR4vjoQM43
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Need a little more information on this to proceed.  Could you send the
output from the following commands:
lspci -s 0:14.2 -vn
cat /proc/asound/version
cat /proc/asound/card0/codec*

These will give us more information to go on. 

It's also possible that a newer version of alsa will fix your problems.
Try downloading alsa-driver-1.0.14rc1.tar.bz2 from the alsa-progject.org
web site.

Tobin


On Tue, 2006-12-19 at 23:12 +0100, Mathias Friman wrote:

> Hi list.
> 
> A friend of mine has an Acer 5100 Laptop which
> has a hda-intel driver sound card. He cannot start
> alsamixer, it errors out with:
> 
> alsamixer: function snd_mixer_load failed: Invalid argument
> 
> When the alsa-packages are reinstalled in Kubuntu, the
> alsamixer works, but after a reboot it does not anymore.
> The mic input is muted, or volume set to zero. The output
> works though, but no levels can be adjusted due to the
> alsamixer error.
> 
> We've tried with:
> 
> options snd_hda_intel model=acer position_fix=1
> 
> in /etc/modprobe.d/alsa-base but that does not fix the
> problem. 
> 
> I haven't got enough knowledge about ALSA to take
> this further, so I put my hope to you guys. Below are
> some outputs that might be useful:
> 
> 
> 
> # cat /proc/asound/cards
>  0 [SB             ]: HDA-Intel - HDA ATI SB
>                       HDA ATI SB at 0xd0000000 irq 209
> 
> # lspci
> 00:14.2 Audio device: ATI Technologies Inc Unknown device 437b (rev 01)
> 
> # amixer contents
> numid=11,iface=MIXER,name='Headphone Playback Switch'
>   ; type=BOOLEAN,access=rw---,values=2
>   : values=on,on
> numid=29,iface=MIXER,name='PCM Playback Volume'
>   ; type=INTEGER,access=rw---,values=2,min=0,max=255,step=0
>   : values=160,160
> numid=4,iface=MIXER,name='Surround Playback Switch'
>   ; type=BOOLEAN,access=rw---,values=2
>   : values=off,off
> amixer: Control default snd_hctl_elem_info error: Invalid argument
> 
> # alsactl store
> alsactl: get_control:149: Cannot read control info '2,0,0,Capture Volume,1': Invalid argument
> 
> 
> 
> Hope this pins down the matter in some respect. :)
> 
> Regards,
> Mathias
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-ORLVZpom3FTR4vjoQM43
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
Need a little more information on this to proceed.&nbsp; Could you send the output from the following commands:<BR>
lspci -s <FONT COLOR="#000000">0:14.2</FONT> -vn<BR>
cat /proc/asound/version<BR>
cat /proc/asound/card0/codec*<BR>
<BR>
These will give us more information to go on. <BR>
<BR>
It's also possible that a newer version of alsa will fix your problems.&nbsp; Try downloading alsa-driver-1.0.14rc1.tar.bz2 from the alsa-progject.org web site.<BR>
<BR>
Tobin<BR>
<BR>
<BR>
On Tue, 2006-12-19 at 23:12 +0100, Mathias Friman wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Hi list.</FONT>

<FONT COLOR="#000000">A friend of mine has an Acer 5100 Laptop which</FONT>
<FONT COLOR="#000000">has a hda-intel driver sound card. He cannot start</FONT>
<FONT COLOR="#000000">alsamixer, it errors out with:</FONT>

<FONT COLOR="#000000">alsamixer: function snd_mixer_load failed: Invalid argument</FONT>

<FONT COLOR="#000000">When the alsa-packages are reinstalled in Kubuntu, the</FONT>
<FONT COLOR="#000000">alsamixer works, but after a reboot it does not anymore.</FONT>
<FONT COLOR="#000000">The mic input is muted, or volume set to zero. The output</FONT>
<FONT COLOR="#000000">works though, but no levels can be adjusted due to the</FONT>
<FONT COLOR="#000000">alsamixer error.</FONT>

<FONT COLOR="#000000">We've tried with:</FONT>

<FONT COLOR="#000000">options snd_hda_intel model=acer position_fix=1</FONT>

<FONT COLOR="#000000">in /etc/modprobe.d/alsa-base but that does not fix the</FONT>
<FONT COLOR="#000000">problem. </FONT>

<FONT COLOR="#000000">I haven't got enough knowledge about ALSA to take</FONT>
<FONT COLOR="#000000">this further, so I put my hope to you guys. Below are</FONT>
<FONT COLOR="#000000">some outputs that might be useful:</FONT>



<FONT COLOR="#000000"># cat /proc/asound/cards</FONT>
<FONT COLOR="#000000"> 0 [SB             ]: HDA-Intel - HDA ATI SB</FONT>
<FONT COLOR="#000000">                      HDA ATI SB at 0xd0000000 irq 209</FONT>

<FONT COLOR="#000000"># lspci</FONT>
<FONT COLOR="#000000">00:14.2 Audio device: ATI Technologies Inc Unknown device 437b (rev 01)</FONT>

<FONT COLOR="#000000"># amixer contents</FONT>
<FONT COLOR="#000000">numid=11,iface=MIXER,name='Headphone Playback Switch'</FONT>
<FONT COLOR="#000000">  ; type=BOOLEAN,access=rw---,values=2</FONT>
<FONT COLOR="#000000">  : values=on,on</FONT>
<FONT COLOR="#000000">numid=29,iface=MIXER,name='PCM Playback Volume'</FONT>
<FONT COLOR="#000000">  ; type=INTEGER,access=rw---,values=2,min=0,max=255,step=0</FONT>
<FONT COLOR="#000000">  : values=160,160</FONT>
<FONT COLOR="#000000">numid=4,iface=MIXER,name='Surround Playback Switch'</FONT>
<FONT COLOR="#000000">  ; type=BOOLEAN,access=rw---,values=2</FONT>
<FONT COLOR="#000000">  : values=off,off</FONT>
<FONT COLOR="#000000">amixer: Control default snd_hctl_elem_info error: Invalid argument</FONT>

<FONT COLOR="#000000"># alsactl store</FONT>
<FONT COLOR="#000000">alsactl: get_control:149: Cannot read control info '2,0,0,Capture Volume,1': Invalid argument</FONT>



<FONT COLOR="#000000">Hope this pins down the matter in some respect. :)</FONT>

<FONT COLOR="#000000">Regards,</FONT>
<FONT COLOR="#000000">Mathias</FONT>


<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">Take Surveys. Earn Cash. Influence the Future of IT</FONT>
<FONT COLOR="#000000">Join SourceForge.net's Techsay panel and you'll get the chance to share your</FONT>
<FONT COLOR="#000000">opinions on IT &amp; business topics through brief surveys - and earn cash</FONT>
<FONT COLOR="#000000"><A HREF="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</A></FONT>
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

--=-ORLVZpom3FTR4vjoQM43--



--===============1812532694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1812532694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1812532694==--
