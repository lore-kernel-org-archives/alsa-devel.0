From: Tobin Davis <tdavis@dsl-only.net>
Subject: Missing symbols since 1.0.14rc1
Date: Wed, 07 Mar 2007 15:09:34 -0800
Message-ID: <1173308974.4531.19.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0465287781=="
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============0465287781==
Content-Type: multipart/alternative; boundary="=-Ffx/h7ztjoEFq1Fdsyyw"


--=-Ffx/h7ztjoEFq1Fdsyyw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I had a couple of users report that alsa-driver-1.0.14rc2 and
alsa-driver-1.0.14rc3 would no longer load due to missing symbols.  I am
able to reproduce this on a RedHat Enterprise Linux 4 update 4 kernel
(2.6.9-42.0.0.0.1.EL) after modifying ./alsa-driver/include/adriver.h to
not typedef gfp_t (Redhat pulled that typedef in starting with 4U3).

The error when loading snd.ko is:

        snd:  Unknown symbol sound_class1
        FATAL:  Error inserting snd (<path to module>): Unknown symbol
        in module, or unknown parameter (see dmesg).


dmesg reports the same thing.

This worked fine in 1.0.14rc1.  I'm looking through the change logs to
see what may have broken it.

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-Ffx/h7ztjoEFq1Fdsyyw
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
I had a couple of users report that alsa-driver-1.0.14rc2 and alsa-driver-1.0.14rc3 would no longer load due to missing symbols.&nbsp; I am able to reproduce this on a RedHat Enterprise Linux 4 update 4 kernel (2.6.9-42.0.0.0.1.EL) after modifying ./alsa-driver/include/adriver.h to not typedef gfp_t (Redhat pulled that typedef in starting with 4U3).<BR>
<BR>
The error when loading snd.ko is:<BR>
<BLOCKQUOTE>
    snd:&nbsp; Unknown symbol sound_class1<BR>
    FATAL:&nbsp; Error inserting snd (&lt;path to module&gt;): Unknown symbol in module, or unknown parameter (see dmesg).<BR>
</BLOCKQUOTE>
<BR>
dmesg reports the same thing.<BR>
<BR>
This worked fine in 1.0.14rc1.&nbsp; I'm looking through the change logs to see what may have broken it.<BR>
<BR>
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

--=-Ffx/h7ztjoEFq1Fdsyyw--



--===============0465287781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0465287781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0465287781==--
