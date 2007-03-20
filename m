From: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Subject: Re: Quality resampling code for libasound
Date: Wed, 21 Mar 2007 00:22:28 +1100
Message-ID: <45FFE014.1080100@usherbrooke.ca>
References: <45D92131.50601@usherbrooke.ca>	<s5hirdy72ue.wl%tiwai@suse.de>	<45D99DF7.90204@usherbrooke.ca>	<s5hhcti70pa.wl%tiwai@suse.de>	<45D9A848.9040803@usherbrooke.ca>	<s5h7iue6yyi.wl%tiwai@suse.de>	<45DA8CD2.1040606@usherbrooke.ca>	<s5hps85rtsr.wl%tiwai@suse.de>	<45DAE188.6010405@usherbrooke.ca>	<s5hfy91rprn.wl%tiwai@suse.de>	<45DAEBB8.70808@usherbrooke.ca>	<45DB713F.9090804@superbug.co.uk>	<45DC0E52.1060805@usherbrooke.ca>	<s5hodnm7774.wl%tiwai@suse.de>	<45DD8329.6080809@usherbrooke.ca>	<s5hlkiq75up.wl%tiwai@suse.de>	<45E4E4A5.6020405@usherbrooke.ca>	<s5hhcswbsj4.wl%tiwai@suse.de>	<45EF5FE1.5080407@usherbrooke.ca>
	<s5hy7m6h01e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060400020009080103080109"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hy7m6h01e.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060400020009080103080109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I'm attaching an updated version of my resampler plugin. It fixes a few
minor issues and it adds support for fixed-point processing (just add
-DFIXED_POINT to the build). Let me know if there's any problem.

	Jean-Marc

Takashi Iwai a =E9crit :
> At Thu, 08 Mar 2007 11:59:13 +1100,
> Jean-Marc Valin wrote:
>>> Don't hurry up.  We are still in a long rc phase :)
>>> Let's check with the latest 1.0.14rc3 and see the performance.
>>> Making it as default is so easy to add one line to /etc/alsa.conf (or
>>> ~/.asoundrc) as found in the documentation.
>> OK, hopefully that can happen for 1.1.14... Did you actually test my
>> plugin yet to see whether it works as expected?
>=20
> Yes, it has been working well as far as I've tested.
>=20
>>>> OK, did a bit of search/replace on samplerate.txt and attached the
>>>> result. As you can see, it's fairly similar. So far, I'm also includ=
ing
>>>> 3 levels of quality that match the libsamplerate levels, but I can
>>>> change that depending on what people want.
>>> Thanks.  I guess the title should be changed (I already took the fixe=
d
>>> version on my local tree).
>> Oops :-)
>>
>>>> The Speex resampler offers
>>>> quality settings that range from 0 to 10, so I can expose them all (=
is
>>>> there a way to pass a quality parameter to the resampler instead of
>>>> having to create lots of symbolic links?).
>>> We can extend the rate plugin API so that the plugin code can refers
>>> the config parameters.  But this would require an ABI extension /
>>> incompatibility.  So I'd like to avoid this as much as possible.
>>>
>>> I don't think we need to expose all 11 ranges.  Three should be
>>> enough, normally...
>> I think we can live with 3 settings, at least for now. The libsamplera=
te
>> plugin had 5 settings, of which only 3 were useful (I used equivalent
>> quality to those) -- the other 2 were zero-order hold and linear
>> interpolation, which nobody in their right mind would want to use!
>>
>> One last thing, what happened to the other patch I sent for doing
>> rounding-to-nearest (instead of rounding down) when doing sample forma=
t
>> conversion?
>=20
> Sorry, forgotten until now.  Applied with slight modification
> (introducing a macro) to HG tree now.  Thanks for ping!
>=20
>=20
> Takashi
>=20

--------------060400020009080103080109
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------060400020009080103080109
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------060400020009080103080109--
