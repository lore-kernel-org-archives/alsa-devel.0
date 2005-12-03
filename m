From: Sergei Steshenko <steshenko_sergei@list.ru>
Subject: Re: [Alsa-user] Revo 7.1 setup ?
Date: Sat, 3 Dec 2005 22:01:38 +0200
Message-ID: <20051203220138.6cc87ddc@athlon.home.net>
References: <1133636889.4274.7.camel@rousalka.dyndns.org>
	<20051203212122.13f4e6b5@athlon.home.net>
	<1133637981.4274.9.camel@rousalka.dyndns.org>
	<20051203213203.1da386cf@athlon.home.net>
	<1133639073.5025.13.camel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1133639073.5025.13.camel@rousalka.dyndns.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

If I understand correctly what 'alsamixer' is doing, it, among other things,
redirects certain streams (e.g. PCM Out) to certain outputs.

So, probably, if you choose IEC958 on an output, you'll get the stream
on that output.

I'd first try to get CD playback in analog form - this definitely works.

The three leftmost controls are called "IEC958",  "IEC958 0",  "IEC958 1"
and one of the values is "PCM Out" - maybe one of them is the one that
needs to be set ?

I believe Takashi Iwai knows the definite answer - he is the driver develop=
er if
I understand correctly.

On Sat, 03 Dec 2005 20:44:31 +0100
Nicolas Mailhot <nicolas.mailhot@laposte.net> wrote:

> Le samedi 03 d=E9cembre 2005 =E0 21:32 +0200, Sergei Steshenko a =E9crit :
> > A lot of channels have IEC958 setting, so I thought it was the thing to=
 look for.
>=20
> Right. The hardware seems nice and able to do many complex things, but I
> didn't find how to make it do simple things yet.
>=20
> --=20
> Nicolas Mailhot


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
