From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: [PATCH] hda empty modelname comparison
Date: Wed, 07 Mar 2007 14:58:57 -0800
Message-ID: <1173308337.4531.10.camel@razman.gruemaster.com>
References: <45ED81BE.4080606@amd.com>
	<1173297870.4531.4.camel@razman.gruemaster.com>
	<s5hodn4agyz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0945952408=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hodn4agyz.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Joachim Deguara <joachim.deguara@amd.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0945952408==
Content-Type: multipart/alternative; boundary="=-8OAFbtpk2asX6sph7Lzs"


--=-8OAFbtpk2asX6sph7Lzs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Oops, nevermind.  I've been reading too many pseudo-code documents.  I
expected strcmp to return true if matched.

This works.

Tobin

On Wed, 2007-03-07 at 22:20 +0100, Takashi Iwai wrote:

> +       if (codec->bus->modelname && !strcmp(codec->bus->modelname,
> "generic"))
> +               return NULL; /* use the generic parser */
> 


Should be:

+       if (codec->bus->modelname && strcmp(codec->bus->modelname,
"generic"))
+               return NULL; /* use the generic parser */


You've got the logic reversed.

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-8OAFbtpk2asX6sph7Lzs
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
Oops, nevermind.&nbsp; I've been reading too many pseudo-code documents.&nbsp; I expected strcmp to return true if matched.<BR>
<BR>
This works.<BR>
<BR>
Tobin<BR>
<BR>
On Wed, 2007-03-07 at 22:20 +0100, Takashi Iwai wrote:<BR>
<BLOCKQUOTE TYPE=CITE>
    <TT><FONT COLOR="#000000">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (codec-&gt;bus-&gt;modelname &amp;&amp; !strcmp(codec-&gt;bus-&gt;modelname, &quot;generic&quot;))</FONT></TT><BR>
    <TT><FONT COLOR="#000000">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return NULL; /* use the generic parser */</FONT></TT><BR>
    <BR>
</BLOCKQUOTE>
<BR>
Should be:<BR>
<BR>
<TT>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (codec-&gt;bus-&gt;modelname &amp;&amp; strcmp(codec-&gt;bus-&gt;modelname, &quot;generic&quot;))</TT><BR>
<TT>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return NULL; /* use the generic parser */</TT><BR>
<BR>
<BR>
You've got the logic reversed.<BR>
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

--=-8OAFbtpk2asX6sph7Lzs--



--===============0945952408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0945952408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0945952408==--
