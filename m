From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Willing to help!
Date: Sat, 03 Mar 2007 21:31:56 -0800
Message-ID: <1172986316.4838.26.camel@razman.gruemaster.com>
References: <aa73b9a0703031709p6cebaf84nc27c34a645548e9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0578547914=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <aa73b9a0703031709p6cebaf84nc27c34a645548e9d@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: John Pierce <john.j35@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0578547914==
Content-Type: multipart/alternative; boundary="=-7AsUNcoly90lOxbfD/9X"


--=-7AsUNcoly90lOxbfD/9X
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I'm the one working on the driver.  For now, email me directly, as I
don't want to flood the list with development patches.

I'll send you a separate email shortly.

Tobin

On Sat, 2007-03-03 at 19:09 -0600, John Pierce wrote:

> Hello list, I am not sure where to post this so here goes.
> 
> I just purchased an HP DV9208NR laptop, I installed opensuse 10.2 and
> all worked well except the headphones.  All of the buttons on the
> machine worked, including the mute button.   However, when I plugged
> in my headphones the speakers would not mute and no sound came from
> the headphones.
> 
> In an attempt to fix this, I searched the lists and found another
> users experiences and noticed the following snippet.
> 
> Also some know issues : When headphones are plugged , laptop speakers dont mute.
> ============New Patch Released 01/30/2007 T.Davis Alsa-Users List ==========
> !!Backup your current drivers with following command !!
> tar -zcvf original-drivers.tgz /lib/modules/`uname -r`/kernel/sound
> 
> Now, get the latest release, apply the patch, and build.
> 
> wget ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.14rc2.tar.bz2
> tar -jxf alsa-driver-1.0.14rc2.tar.bz2
> cd alsa-driver-1.0.14rc2/alsa-kernel
> patch -p1
> cd ..
> ./configure --with-debug=detect --with-cards=hda-intel
> make ; make install
> 
> I downloaded the current 1.0.14rc2 and went through the motions of
> configuring, making and make installing.  I removed the modules from
> my original install and then modprobed the snd_hda_intel and now when
> I plug in the headphones they work correctly, that is the speakers
> stop and the headphones start.
> 
> Now the problem, the mute button above the keyboard that used to stay
> blue, and would mute the sound to the speakers, now has changed to
> orange and will not mute any sound.
> 
> I am willing to help the developers debug this if any wish to contact
> me and tell me what they need me to do.
> 
> It wouldn't be the first time I trashed a system and then put it back together.
> 
> Thanks for all of your work.
> 
> 
> 

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-7AsUNcoly90lOxbfD/9X
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
I'm the one working on the driver.&nbsp; For now, email me directly, as I don't want to flood the list with development patches.<BR>
<BR>
I'll send you a separate email shortly.<BR>
<BR>
Tobin<BR>
<BR>
On Sat, 2007-03-03 at 19:09 -0600, John Pierce wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Hello list, I am not sure where to post this so here goes.</FONT>

<FONT COLOR="#000000">I just purchased an HP DV9208NR laptop, I installed opensuse 10.2 and</FONT>
<FONT COLOR="#000000">all worked well except the headphones.  All of the buttons on the</FONT>
<FONT COLOR="#000000">machine worked, including the mute button.   However, when I plugged</FONT>
<FONT COLOR="#000000">in my headphones the speakers would not mute and no sound came from</FONT>
<FONT COLOR="#000000">the headphones.</FONT>

<FONT COLOR="#000000">In an attempt to fix this, I searched the lists and found another</FONT>
<FONT COLOR="#000000">users experiences and noticed the following snippet.</FONT>

<FONT COLOR="#000000">Also some know issues : When headphones are plugged , laptop speakers dont mute.</FONT>
<FONT COLOR="#000000">============New Patch Released 01/30/2007 T.Davis Alsa-Users List ==========</FONT>
<FONT COLOR="#000000">!!Backup your current drivers with following command !!</FONT>
<FONT COLOR="#000000">tar -zcvf original-drivers.tgz /lib/modules/`uname -r`/kernel/sound</FONT>

<FONT COLOR="#000000">Now, get the latest release, apply the patch, and build.</FONT>

<FONT COLOR="#000000">wget <A HREF="ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.14rc2.tar.bz2">ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.14rc2.tar.bz2</A></FONT>
<FONT COLOR="#000000">tar -jxf alsa-driver-1.0.14rc2.tar.bz2</FONT>
<FONT COLOR="#000000">cd alsa-driver-1.0.14rc2/alsa-kernel</FONT>
<FONT COLOR="#000000">patch -p1</FONT>
<FONT COLOR="#000000">cd ..</FONT>
<FONT COLOR="#000000">./configure --with-debug=detect --with-cards=hda-intel</FONT>
<FONT COLOR="#000000">make ; make install</FONT>

<FONT COLOR="#000000">I downloaded the current 1.0.14rc2 and went through the motions of</FONT>
<FONT COLOR="#000000">configuring, making and make installing.  I removed the modules from</FONT>
<FONT COLOR="#000000">my original install and then modprobed the snd_hda_intel and now when</FONT>
<FONT COLOR="#000000">I plug in the headphones they work correctly, that is the speakers</FONT>
<FONT COLOR="#000000">stop and the headphones start.</FONT>

<FONT COLOR="#000000">Now the problem, the mute button above the keyboard that used to stay</FONT>
<FONT COLOR="#000000">blue, and would mute the sound to the speakers, now has changed to</FONT>
<FONT COLOR="#000000">orange and will not mute any sound.</FONT>

<FONT COLOR="#000000">I am willing to help the developers debug this if any wish to contact</FONT>
<FONT COLOR="#000000">me and tell me what they need me to do.</FONT>

<FONT COLOR="#000000">It wouldn't be the first time I trashed a system and then put it back together.</FONT>

<FONT COLOR="#000000">Thanks for all of your work.</FONT>



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

--=-7AsUNcoly90lOxbfD/9X--



--===============0578547914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0578547914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0578547914==--
