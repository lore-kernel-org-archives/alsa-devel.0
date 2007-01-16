From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Add support for Sigmatel STAC9202/9250/9251	codecs.
Date: Tue, 16 Jan 2007 14:24:18 -0800
Message-ID: <1168986258.27941.40.camel@localhost>
References: <1167766299.31371.131.camel@localhost> <eoiu8f$kac$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0786016356=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <eoiu8f$kac$1@sea.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Nicholas Taylor <taylor.catharsis@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0786016356==
Content-Type: multipart/alternative; boundary="=-1Q4MAzzRMtvKI6sCPsuN"


--=-1Q4MAzzRMtvKI6sCPsuN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

What I found from other testers is that you need to add "probe_mask=1"
to the driver when loading.  This can be done a couple of ways.  The
easiest way to test it is with modprobe as follows:


        modprobe snd-hda-intel probe_mask=1

The other method that makes this more permanent is to add probe_mask=1
to your modprobe.conf file.  Since each distribution is different, the
best I can tell you is to look in /etc for either a modprobe.conf or
modules.conf file.  There might also be variations of those files (i.e.
modprobe.preload, modprobe.d/sound.conf, etc).  Ther should be something
like this:

alias sound-slot-0 snd-hda-intel

Add the following line to the same file, below the alias line:

options snd-hda-intel probe_mask=1

That should fix your dep range issues and give you working sound.

As a final note, the latest patch is available in alsa-driver-1.0.14rc2
available from alsa-project.org.  The only issues I know of are crashes
with the Gateway NX560XL, which are as of yet unresolved.  I do have
good reports of your model working though.

Tobin

On Tue, 2007-01-16 at 11:24 -0500, Nicholas Taylor wrote:

> Hi.  I'm a first time user of this newsgroup and a relatively new Linux 
> user.  I use the mx6453 model (which I believe leaves me with 9250) and 
> have been dealing with no sound in Linux for a few weeks now.  When I 
> saw the previous threads concerning test patches for the Sigmatel codecs 
> in this newsgroup, I was hoping it might fix the problem.
> 
> I tried installing the patch using the instructions you gave on 
> http://article.gmane.org/gmane.linux.alsa.devel/42922 for test patch 6. 
>   However, once I added the module I was still getting invalid dep range 
> errors in the output from dmesg (I'd post it here, but I'm in Windows at 
> the moment)  I know you said more work needs to be done on this patch, 
> but I thought there might also be the chance I did something wrong. 
> Does applying the patch involve a different set of steps than test patch 6?
> 
> Also, konsole initially gave me this when I removed the snd_hda_codec 
> and put it back in with modprobe
> 
> WARNING: Error inserting snd_hda_codec 
> (/lib/modules/2.6.15-26-amd64-generic/kernel/sound/pci/hda/snd-hda-codec.ko): 
> Unknown symbol in module, or unknown parameter (see dmesg)
> FATAL: Error inserting snd_hda_intel 
> (/lib/modules/2.6.15-26-amd64-generic/kernel/sound/pci/hda/snd-hda-intel.ko): 
> Unknown symbol in module, or unknown parameter (see dmesg)
> 
> A restart made reinserting the module run smoothly, but I can't kick the 
> feeling I'm doing something wrong here.  Again, I'm new to this 
> newsgroup and Linux in general, so if I'm not supplying enough 
> information about the issue, I'm sorry and I'll give you whatever else 
> you need.
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

--=-1Q4MAzzRMtvKI6sCPsuN
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
What I found from other testers is that you need to add &quot;probe_mask=1&quot; to the driver when loading.&nbsp; This can be done a couple of ways.&nbsp; The easiest way to test it is with modprobe as follows:<BR>
<BR>
<BLOCKQUOTE>
    modprobe snd-hda-intel probe_mask=1<BR>
</BLOCKQUOTE>
The other method that makes this more permanent is to add probe_mask=1 to your modprobe.conf file.&nbsp; Since each distribution is different, the best I can tell you is to look in /etc for either a modprobe.conf or modules.conf file.&nbsp; There might also be variations of those files (i.e. modprobe.preload, modprobe.d/sound.conf, etc).&nbsp; Ther should be something like this:<BR>
<BR>
alias sound-slot-0 snd-hda-intel<BR>
<BR>
Add the following line to the same file, below the alias line:<BR>
<BR>
options snd-hda-intel probe_mask=1<BR>
<BR>
That should fix your dep range issues and give you working sound.<BR>
<BR>
As a final note, the latest patch is available in alsa-driver-1.0.14rc2 available from alsa-project.org.&nbsp; The only issues I know of are crashes with the Gateway NX560XL, which are as of yet unresolved.&nbsp; I do have good reports of your model working though.<BR>
<BR>
Tobin<BR>
<BR>
On Tue, 2007-01-16 at 11:24 -0500, Nicholas Taylor wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Hi.  I'm a first time user of this newsgroup and a relatively new Linux </FONT>
<FONT COLOR="#000000">user.  I use the mx6453 model (which I believe leaves me with 9250) and </FONT>
<FONT COLOR="#000000">have been dealing with no sound in Linux for a few weeks now.  When I </FONT>
<FONT COLOR="#000000">saw the previous threads concerning test patches for the Sigmatel codecs </FONT>
<FONT COLOR="#000000">in this newsgroup, I was hoping it might fix the problem.</FONT>

<FONT COLOR="#000000">I tried installing the patch using the instructions you gave on </FONT>
<FONT COLOR="#000000"><A HREF="http://article.gmane.org/gmane.linux.alsa.devel/42922">http://article.gmane.org/gmane.linux.alsa.devel/42922</A> for test patch 6. </FONT>
<FONT COLOR="#000000">  However, once I added the module I was still getting invalid dep range </FONT>
<FONT COLOR="#000000">errors in the output from dmesg (I'd post it here, but I'm in Windows at </FONT>
<FONT COLOR="#000000">the moment)  I know you said more work needs to be done on this patch, </FONT>
<FONT COLOR="#000000">but I thought there might also be the chance I did something wrong. </FONT>
<FONT COLOR="#000000">Does applying the patch involve a different set of steps than test patch 6?</FONT>

<FONT COLOR="#000000">Also, konsole initially gave me this when I removed the snd_hda_codec </FONT>
<FONT COLOR="#000000">and put it back in with modprobe</FONT>

<FONT COLOR="#000000">WARNING: Error inserting snd_hda_codec </FONT>
<FONT COLOR="#000000">(/lib/modules/2.6.15-26-amd64-generic/kernel/sound/pci/hda/snd-hda-codec.ko): </FONT>
<FONT COLOR="#000000">Unknown symbol in module, or unknown parameter (see dmesg)</FONT>
<FONT COLOR="#000000">FATAL: Error inserting snd_hda_intel </FONT>
<FONT COLOR="#000000">(/lib/modules/2.6.15-26-amd64-generic/kernel/sound/pci/hda/snd-hda-intel.ko): </FONT>
<FONT COLOR="#000000">Unknown symbol in module, or unknown parameter (see dmesg)</FONT>

<FONT COLOR="#000000">A restart made reinserting the module run smoothly, but I can't kick the </FONT>
<FONT COLOR="#000000">feeling I'm doing something wrong here.  Again, I'm new to this </FONT>
<FONT COLOR="#000000">newsgroup and Linux in general, so if I'm not supplying enough </FONT>
<FONT COLOR="#000000">information about the issue, I'm sorry and I'll give you whatever else </FONT>
<FONT COLOR="#000000">you need.</FONT>


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

--=-1Q4MAzzRMtvKI6sCPsuN--



--===============0786016356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0786016356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0786016356==--
