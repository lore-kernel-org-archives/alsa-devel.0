From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Regression in 2.6.19 and 2.6.20 for snd_hda_intel
Date: Tue, 02 Jan 2007 09:51:50 -0800
Message-ID: <1167760310.31371.99.camel@localhost>
References: <45971053.7040609@lwfinger.net> <45971F39.4060301@gentoo.org>
	<45972EFD.3010103@lwfinger.net> <45973283.7060801@gentoo.org>
	<1167538094.9563.230.camel@localhost> <459741A1.9020909@lwfinger.net>
	<20070101093212.6859f053@freekitty>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1049614883=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B312519D
	for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2007 18:51:39 +0100 (MET)
In-Reply-To: <20070101093212.6859f053@freekitty>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Daniel Drake <dsd@gentoo.org>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Larry Finger <larry.finger@lwfinger.net>
List-Id: alsa-devel@alsa-project.org


--===============1049614883==
Content-Type: multipart/alternative; boundary="=-kPdhQ+RBgIa7IHFk3BL9"


--=-kPdhQ+RBgIa7IHFk3BL9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is part of the generic code.  It's main purpose is to provide basic
support until full featured support is created for a system.  If there
are systems that need this patch to work, we should look into adding
them to the main patch_* codec drivers.

For example, the Conexant codecs are now getting supported directly, as
are via and atihdmi.

If you have some information on these Panasonic models, please forward
it to me, thanks.

Tobin

On Mon, 2007-01-01 at 09:32 -0800, Stephen Hemminger wrote:

> On Sat, 30 Dec 2006 22:50:41 -0600
> Larry Finger <larry.finger@lwfinger.net> wrote:
> 
> > Tobin Davis wrote:
> > > Which alsa patch was this?  I'm not seeing anything in the hg logs for
> > > this.  Or is this something from the kernel side?
> > 
> > It seems to have come from suse. The full commit message is:
> > 
> > commit a7da6ce564a80952d9c0b210deca5a8cd3474a31
> > Author: Takashi Iwai <tiwai@suse.de>
> > Date:   Wed Sep 6 14:03:14 2006 +0200
> > 
> >     [ALSA] hda-codec - Add independent headphone volume control
> > 
> >     This patch addes the support of the independent 'Headphone' volume
> >     control to the generic codec parser.  Some codecs (e.g. Conexant)
> >     have separate connections to the headphone and the independent amp
> >     adjustment is needed.
> > 
> >     Signed-off-by: Takashi Iwai <tiwai@suse.de>
> >     Signed-off-by: Jaroslav Kysela <perex@suse.cz>
> > 
> > :100644 100644 dedfc5b... 97e9af1... M  sound/pci/hda/hda_generic.c
> > 
> > Larry
> > 
> > 
> 
> Just make sure you don't break the headphone jack on some systems.
> The headphone jack on the Panasonic T5 didn't work until recent kernels
> (probably this was the thing that made it work).
> 

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-kPdhQ+RBgIa7IHFk3BL9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
This is part of the generic code.&nbsp; It's main purpose is to provide basic support until full featured support is created for a system.&nbsp; If there are systems that need this patch to work, we should look into adding them to the main patch_* codec drivers.<BR>
<BR>
For example, the Conexant codecs are now getting supported directly, as are via and atihdmi.<BR>
<BR>
If you have some information on these Panasonic models, please forward it to me, thanks.<BR>
<BR>
Tobin<BR>
<BR>
On Mon, 2007-01-01 at 09:32 -0800, Stephen Hemminger wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">On Sat, 30 Dec 2006 22:50:41 -0600</FONT>
<FONT COLOR="#000000">Larry Finger &lt;<A HREF="mailto:larry.finger@lwfinger.net">larry.finger@lwfinger.net</A>&gt; wrote:</FONT>

<FONT COLOR="#000000">&gt; Tobin Davis wrote:</FONT>
<FONT COLOR="#000000">&gt; &gt; Which alsa patch was this?  I'm not seeing anything in the hg logs for</FONT>
<FONT COLOR="#000000">&gt; &gt; this.  Or is this something from the kernel side?</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; It seems to have come from suse. The full commit message is:</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; commit a7da6ce564a80952d9c0b210deca5a8cd3474a31</FONT>
<FONT COLOR="#000000">&gt; Author: Takashi Iwai &lt;<A HREF="mailto:tiwai@suse.de">tiwai@suse.de</A>&gt;</FONT>
<FONT COLOR="#000000">&gt; Date:   Wed Sep 6 14:03:14 2006 +0200</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt;     [ALSA] hda-codec - Add independent headphone volume control</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt;     This patch addes the support of the independent 'Headphone' volume</FONT>
<FONT COLOR="#000000">&gt;     control to the generic codec parser.  Some codecs (e.g. Conexant)</FONT>
<FONT COLOR="#000000">&gt;     have separate connections to the headphone and the independent amp</FONT>
<FONT COLOR="#000000">&gt;     adjustment is needed.</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt;     Signed-off-by: Takashi Iwai &lt;<A HREF="mailto:tiwai@suse.de">tiwai@suse.de</A>&gt;</FONT>
<FONT COLOR="#000000">&gt;     Signed-off-by: Jaroslav Kysela &lt;<A HREF="mailto:perex@suse.cz">perex@suse.cz</A>&gt;</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; :100644 100644 dedfc5b... 97e9af1... M  sound/pci/hda/hda_generic.c</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; Larry</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; </FONT>

<FONT COLOR="#000000">Just make sure you don't break the headphone jack on some systems.</FONT>
<FONT COLOR="#000000">The headphone jack on the Panasonic T5 didn't work until recent kernels</FONT>
<FONT COLOR="#000000">(probably this was the thing that made it work).</FONT>

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

--=-kPdhQ+RBgIa7IHFk3BL9--



--===============1049614883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1049614883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1049614883==--
