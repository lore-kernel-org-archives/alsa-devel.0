From: "Arve Knudsen" <aknuds-1@broadpark.no>
Subject: Re: Problem writing to PCM plugin
Date: Wed, 11 Aug 2004 17:06:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opsckpkuvbfmr65f@mail.broadpark.no>
References: <Pine.HPX.4.33n.0408111544140.15385-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0408111544140.15385-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Based on your suggestion I rewrote the plugin, so it wraps a route plugin=
. =20
And now things work as I would expect. I must say I'm still confused on =20
the issue, as I haven't found any explanation why my original approach =20
wouldn't work. What's the difference between defining a translation table=
 =20
directly inside a "plug" plugin, and aggregating a slave "route" plugin =20
within a "plug"?

Sort of weird that the plugin caused an assertion only when used in =20
combination with the nForce2 chip, and not the Hammerfall (just silent =20
operation).

Thanks

Arve Knudsen

On Wed, 11 Aug 2004 15:45:29 +0200 (METDST), Clemens Ladisch =20
<clemens@ladisch.de> wrote:

> Arve Knudsen wrote:
>> pcm_plug.c:363: snd_pcm_plug_change_channels: Assertion
>> `snd_pcm_format_linear(slv->format)' failed'
>>
>> The obvious difference to aplay I can think of is that we use floating
>> point format in the PortAudio tests, so there is an intermediate
>> conversion before the audio gets to the routing plugin.
>
> The route plugin doesn't support floating point formats.  Try wrapping
> it into a lfloat (or plug) plugin.
>
>
> HTH
> Clemens
>
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
> 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
> Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
