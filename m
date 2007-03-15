From: "John Utz" <John.Utz@dmx.com>
Subject: Re: [PATCH] ac97_patch.c ac97_codec.{ch} - enable
 'Smart 5.1' UAJ on VIA vt1618 ac97 codec
Date: Thu, 15 Mar 2007 11:41:06 -0700
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8D1@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8CF@sea-exch-01.na.corp.dmxmusic.com>
	<s5hhcsm6713.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0388706057=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============0388706057==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C76731.7DE26437"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C76731.7DE26437
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Comments inline.

as always, tnx in advance for putting up with my outlook web access =
based crappy citing


-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: Thu 3/15/2007 5:11 AM
To: John Utz
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] [PATCH] ac97_patch.c ac97_codec.{ch} - enable =
'Smart 5.1' UAJ on VIA vt1618 ac97 codec
=20
Hi,

thanks for the patch.


ME =3D> you are more than welcome!


At Wed, 14 Mar 2007 18:12:58 -0700,
John Utz wrote:
>=20
> Greetings;
>=20
> Attached is support for configuring the ins and outs on a vt1618 =
codec. This is a
> substantially more complicated patch than the previous one for the =
vt1617a ( tis why i
> did that one first! :-) )
>=20
> Several controls are added, they may or may not be implemented on all =
hardware,
> some of them seem to have no effect on an MSI CN700T mainboard:
>=20
> "Center/LFE Exchange"
> "DC Offset Removal"
> "Headphone Amp Disable"
> "Back Channel Disable"
> "Soft Mute  Disable"

Switches to disabling features are rather confusing.
It's better to invert them and make them working as on =3D enable, off =
=3D
disable.

ME =3D> Fair 'nuf, will fix and resubmit - these are the register names =
from the via docs

> "Surround Back is Aux In"

ME =3D> I can probably rethink this into a 2 way enum

> "Universal Audio Jack 0 (Speaker)"
> "Universal Audio Jack 1 (Line In)"
> "Universal Audio Jack 2 (Mic In)"

They are pretty uncommon as mixer names.
Especially, parentheses in mixer names are not good.

ME =3D> UAJ is a non vendor-specific tech, it's on the VT1618 and the =
ALC880(?)
ME =3D> it might be abstractable and provide driver simplification for =
UAJ chips.
ME =3D> I put it in the label because the user might gain insight from =
it
ME =3D> I will change it thusly:
ME =3D>
ME =3D> Universal Audio Jack Speaker
ME =3D> Universal Audio Jack Line In
ME =3D> Universal Audio Jack Mic In
ME =3D>
ME =3D> Would this be acceptable?

> Setting these 3 new controls to the settings to:
>=20
>   "DAC Mixed (5.1 Out)", "Reserved (5.1 Out)", "Reserved (5.1 Out)"

Can we simply use "5.1 Out"?

ME =3D> This is the nub of the problem! The vt1618 docs are less than =
clear.
ME =3D> I wanted to communicate the uncertainty of this setting to the =
user.
ME =3D> By experimentation, i made 5.1 work on *ONE* board (MSI CN700T)
ME =3D> by setting the register to weird values:
ME =3D>
ME =3D>    DAC Mixed, Reserved, Reserved
ME =3D>
ME =3D> What if this breaks other implementations?
ME =3D>
ME =3D> The chip has both UAJ pins and dedicated output pins and some
ME =3D> boards will probably use the dedicated output pins instead of
ME =3D> the UAJ. If the mixer has something that says 5.1 Out, a user
ME =3D> seeking surround will set it! :-)

> allows 6 channel output to be played using the following command:
>=20
>   aplay -Dhw:0,1 chan-id.wav
>=20
> Note that 6 bits would require an impractical 64 way enum, thus the 3 =
controls.
>=20
> Changelog Entry
>=20
> =3D=3D=3D=3D
>=20
> [PATCH] ALSA: Smart 5.1 / Universal Audio Jack for VIA 1618 codec
>=20
> This patch provides Universal Audio Jack support by way of 3 4 way =
enums that allows
> the user to choose 1 of 64 possible settings for the vt1618's version =
of what via
> calls 'Smart 5.1'
>=20
> A new codec patch function is implemented:
>=20
>    patch_vt1618
>=20
> Several functions are added for reading/writing the Universal Audio =
Jack register:
>=20
>    snd_ac97_vt1618_UAJ{012}_{putget}
>=20
> A new pair of ac97_codec functions are added to allow for reading and =
writing paged
> out registers:
>=20
>    snd_ac97_read_page
>    snd_ac97_write_page

They are not necessarily exported at all as long as they are used in
ac97_* code.

ME =3D> so, i should not export them? ie: =
EXPORT_SYMBOL(snd_ac97_write_page)
ME =3D> why are the other ones exported? ie: =
EXPORT_SYMBOL(snd_ac97_write_cache)

In the latest version, even they could be static

ME =3D> so all of them should be static?

since ac97_patch.c is included from ac97_codec.c.

ME =3D> AHA! that explains something i noticed when merging yesterday.
ME =3D> all the patch_foo decls are gone in ac97_patch.h!

That is, you can use even snd_ac97_page_save() and
snd_ac97_page_restore() from ac97_patch.c.  (You need forward function
declarations, though.)

Or, even better to create more generic version of paged register
accessor, and rewrite snd_ac97_get/put_volsw(), too...

ME =3D> umm, did i not make generic page read and write? am i =
misunderstanding you?

unsigned short snd_ac97_read_page(struct snd_ac97 *ac97, unsigned short =
reg, unsigned short page)
{
	unsigned short page_save;
	unsigned short ret;

	mutex_lock(&ac97->page_mutex);
	page_save =3D snd_ac97_read(ac97, AC97_INT_PAGING) & AC97_PAGE_MASK;
	snd_ac97_update_bits(ac97, AC97_INT_PAGING, AC97_PAGE_MASK, page);
	ret =3D snd_ac97_read(ac97, reg);=20
	snd_ac97_update_bits(ac97, AC97_INT_PAGING, AC97_PAGE_MASK, page_save);
	mutex_unlock(&ac97->page_mutex); /* unlock paging */
	return ret;
}

void snd_ac97_write_page(struct snd_ac97 *ac97, unsigned short reg,  =
unsigned short value, unsigned short page)
{
	unsigned short page_save;

	mutex_lock(&ac97->page_mutex);
	page_save =3D snd_ac97_read(ac97, AC97_INT_PAGING) & AC97_PAGE_MASK;
	snd_ac97_update_bits(ac97, AC97_INT_PAGING, AC97_PAGE_MASK, page);
	snd_ac97_write(ac97, reg, value);=20
	snd_ac97_update_bits(ac97, AC97_INT_PAGING, AC97_PAGE_MASK, page_save);
	mutex_unlock(&ac97->page_mutex); /* unlock paging */
}


Takashi



------_=_NextPart_001_01C76731.7DE26437
Content-Type: text/html;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>RE: [Alsa-devel] [PATCH] ac97_patch.c ac97_codec.{ch} - enable =
'Smart 5.1' UAJ on VIA vt1618 ac97 codec</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Comments inline.<BR>
<BR>
as always, tnx in advance for putting up with my outlook web access =
based crappy citing<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Takashi Iwai [<A =
HREF=3D"mailto:tiwai@suse.de">mailto:tiwai@suse.de</A>]<BR>
Sent: Thu 3/15/2007 5:11 AM<BR>
To: John Utz<BR>
Cc: alsa-devel@lists.sourceforge.net<BR>
Subject: Re: [Alsa-devel] [PATCH] ac97_patch.c ac97_codec.{ch} - enable =
'Smart 5.1' UAJ on VIA vt1618 ac97 codec<BR>
<BR>
Hi,<BR>
<BR>
thanks for the patch.<BR>
<BR>
<BR>
ME =3D&gt; you are more than welcome!<BR>
<BR>
<BR>
At Wed, 14 Mar 2007 18:12:58 -0700,<BR>
John Utz wrote:<BR>
&gt;<BR>
&gt; Greetings;<BR>
&gt;<BR>
&gt; Attached is support for configuring the ins and outs on a vt1618 =
codec. This is a<BR>
&gt; substantially more complicated patch than the previous one for the =
vt1617a ( tis why i<BR>
&gt; did that one first! :-) )<BR>
&gt;<BR>
&gt; Several controls are added, they may or may not be implemented on =
all hardware,<BR>
&gt; some of them seem to have no effect on an MSI CN700T mainboard:<BR>
&gt;<BR>
&gt; &quot;Center/LFE Exchange&quot;<BR>
&gt; &quot;DC Offset Removal&quot;<BR>
&gt; &quot;Headphone Amp Disable&quot;<BR>
&gt; &quot;Back Channel Disable&quot;<BR>
&gt; &quot;Soft Mute&nbsp; Disable&quot;<BR>
<BR>
Switches to disabling features are rather confusing.<BR>
It's better to invert them and make them working as on =3D enable, off =
=3D<BR>
disable.<BR>
<BR>
ME =3D&gt; Fair 'nuf, will fix and resubmit - these are the register =
names from the via docs<BR>
<BR>
&gt; &quot;Surround Back is Aux In&quot;<BR>
<BR>
ME =3D&gt; I can probably rethink this into a 2 way enum<BR>
<BR>
&gt; &quot;Universal Audio Jack 0 (Speaker)&quot;<BR>
&gt; &quot;Universal Audio Jack 1 (Line In)&quot;<BR>
&gt; &quot;Universal Audio Jack 2 (Mic In)&quot;<BR>
<BR>
They are pretty uncommon as mixer names.<BR>
Especially, parentheses in mixer names are not good.<BR>
<BR>
ME =3D&gt; UAJ is a non vendor-specific tech, it's on the VT1618 and the =
ALC880(?)<BR>
ME =3D&gt; it might be abstractable and provide driver simplification =
for UAJ chips.<BR>
ME =3D&gt; I put it in the label because the user might gain insight =
from it<BR>
ME =3D&gt; I will change it thusly:<BR>
ME =3D&gt;<BR>
ME =3D&gt; Universal Audio Jack Speaker<BR>
ME =3D&gt; Universal Audio Jack Line In<BR>
ME =3D&gt; Universal Audio Jack Mic In<BR>
ME =3D&gt;<BR>
ME =3D&gt; Would this be acceptable?<BR>
<BR>
&gt; Setting these 3 new controls to the settings to:<BR>
&gt;<BR>
&gt;&nbsp;&nbsp; &quot;DAC Mixed (5.1 Out)&quot;, &quot;Reserved (5.1 =
Out)&quot;, &quot;Reserved (5.1 Out)&quot;<BR>
<BR>
Can we simply use &quot;5.1 Out&quot;?<BR>
<BR>
ME =3D&gt; This is the nub of the problem! The vt1618 docs are less than =
clear.<BR>
ME =3D&gt; I wanted to communicate the uncertainty of this setting to =
the user.<BR>
ME =3D&gt; By experimentation, i made 5.1 work on *ONE* board (MSI =
CN700T)<BR>
ME =3D&gt; by setting the register to weird values:<BR>
ME =3D&gt;<BR>
ME =3D&gt;&nbsp;&nbsp;&nbsp; DAC Mixed, Reserved, Reserved<BR>
ME =3D&gt;<BR>
ME =3D&gt; What if this breaks other implementations?<BR>
ME =3D&gt;<BR>
ME =3D&gt; The chip has both UAJ pins and dedicated output pins and =
some<BR>
ME =3D&gt; boards will probably use the dedicated output pins instead =
of<BR>
ME =3D&gt; the UAJ. If the mixer has something that says 5.1 Out, a =
user<BR>
ME =3D&gt; seeking surround will set it! :-)<BR>
<BR>
&gt; allows 6 channel output to be played using the following =
command:<BR>
&gt;<BR>
&gt;&nbsp;&nbsp; aplay -Dhw:0,1 chan-id.wav<BR>
&gt;<BR>
&gt; Note that 6 bits would require an impractical 64 way enum, thus the =
3 controls.<BR>
&gt;<BR>
&gt; Changelog Entry<BR>
&gt;<BR>
&gt; =3D=3D=3D=3D<BR>
&gt;<BR>
&gt; [PATCH] ALSA: Smart 5.1 / Universal Audio Jack for VIA 1618 =
codec<BR>
&gt;<BR>
&gt; This patch provides Universal Audio Jack support by way of 3 4 way =
enums that allows<BR>
&gt; the user to choose 1 of 64 possible settings for the vt1618's =
version of what via<BR>
&gt; calls 'Smart 5.1'<BR>
&gt;<BR>
&gt; A new codec patch function is implemented:<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp; patch_vt1618<BR>
&gt;<BR>
&gt; Several functions are added for reading/writing the Universal Audio =
Jack register:<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp; snd_ac97_vt1618_UAJ{012}_{putget}<BR>
&gt;<BR>
&gt; A new pair of ac97_codec functions are added to allow for reading =
and writing paged<BR>
&gt; out registers:<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp; snd_ac97_read_page<BR>
&gt;&nbsp;&nbsp;&nbsp; snd_ac97_write_page<BR>
<BR>
They are not necessarily exported at all as long as they are used in<BR>
ac97_* code.<BR>
<BR>
ME =3D&gt; so, i should not export them? ie: =
EXPORT_SYMBOL(snd_ac97_write_page)<BR>
ME =3D&gt; why are the other ones exported? ie: =
EXPORT_SYMBOL(snd_ac97_write_cache)<BR>
<BR>
In the latest version, even they could be static<BR>
<BR>
ME =3D&gt; so all of them should be static?<BR>
<BR>
since ac97_patch.c is included from ac97_codec.c.<BR>
<BR>
ME =3D&gt; AHA! that explains something i noticed when merging =
yesterday.<BR>
ME =3D&gt; all the patch_foo decls are gone in ac97_patch.h!<BR>
<BR>
That is, you can use even snd_ac97_page_save() and<BR>
snd_ac97_page_restore() from ac97_patch.c.&nbsp; (You need forward =
function<BR>
declarations, though.)<BR>
<BR>
Or, even better to create more generic version of paged register<BR>
accessor, and rewrite snd_ac97_get/put_volsw(), too...<BR>
<BR>
ME =3D&gt; umm, did i not make generic page read and write? am i =
misunderstanding you?<BR>
<BR>
unsigned short snd_ac97_read_page(struct snd_ac97 *ac97, unsigned short =
reg, unsigned short page)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned short page_save;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned short ret;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mutex_lock(&amp;ac97-&gt;page_mutex);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; page_save =3D =
snd_ac97_read(ac97, AC97_INT_PAGING) &amp; AC97_PAGE_MASK;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snd_ac97_update_bits(ac97, =
AC97_INT_PAGING, AC97_PAGE_MASK, page);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D snd_ac97_read(ac97, =
reg);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snd_ac97_update_bits(ac97, =
AC97_INT_PAGING, AC97_PAGE_MASK, page_save);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mutex_unlock(&amp;ac97-&gt;page_mutex); /* unlock paging */<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<BR>
}<BR>
<BR>
void snd_ac97_write_page(struct snd_ac97 *ac97, unsigned short =
reg,&nbsp; unsigned short value, unsigned short page)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned short page_save;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mutex_lock(&amp;ac97-&gt;page_mutex);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; page_save =3D =
snd_ac97_read(ac97, AC97_INT_PAGING) &amp; AC97_PAGE_MASK;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snd_ac97_update_bits(ac97, =
AC97_INT_PAGING, AC97_PAGE_MASK, page);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snd_ac97_write(ac97, reg, =
value);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snd_ac97_update_bits(ac97, =
AC97_INT_PAGING, AC97_PAGE_MASK, page_save);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mutex_unlock(&amp;ac97-&gt;page_mutex); /* unlock paging */<BR>
}<BR>
<BR>
<BR>
Takashi<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C76731.7DE26437--



--===============0388706057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0388706057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0388706057==--
