From: "Ma Begaj" <derliebegott@gmail.com>
Subject: Re: Asus M2NPV-VM snd_hda_intel problem - also with
	Alsa 1.0.15rc3
Date: Sat, 29 Sep 2007 21:45:37 +0200
Message-ID: <a72d33330709291245n18dac599n74df164b4ac7a1fa@mail.gmail.com>
References: <a72d33330709281229v1144cf03r31db37581ccb9a49@mail.gmail.com>
	<a72d33330709290651g5cc9099fqe1d8b01d061ba474@mail.gmail.com>
	<46FE76BA.1050702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <46FE76BA.1050702@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Firstly, I don't have the same board. Similar, but different.
>
> I have an Asus A8N-VM CSM board, but it has the same AD1986A chip on it.
> I didn't have the same issue with sound muting, but I did have issues
> with surround (it just didn't work). I don't remember the details of how
>
>
> --- patch_analog.c.backup       2007-04-14 11:01:17.209146249 +0100
> +++ patch_analog.c      2007-04-14 13:37:47.005206476 +0100
> @@ -895,14 +895,14 @@
>          case AD1986A_3STACK:
>                  spec->num_mixers = 2;
>                  spec->mixers[1] = ad1986a_3st_mixers;
> -               spec->num_init_verbs = 3;
> +/*             spec->num_init_verbs = 3;
>                  spec->init_verbs[1] = ad1986a_3st_init_verbs;
> -               spec->init_verbs[2] = ad1986a_ch2_init;
> +               spec->init_verbs[2] = ad1986a_ch2_init; */
>                  spec->channel_mode = ad1986a_modes;
>                  spec->num_channel_mode = ARRAY_SIZE(ad1986a_modes);
>                  spec->need_dac_fix = 1;
> -               spec->multiout.max_channels = 2;
> -               spec->multiout.num_dacs = 1;
> +               spec->multiout.max_channels = 6;
> +               spec->multiout.num_dacs = 3;
>                  break;
>          case AD1986A_LAPTOP:
>                  spec->mixers[0] = ad1986a_laptop_mixers;
>


thanks for your try.
it helped partly ...  I tried 3 patches (incl. yours) and only yours
helped partly at least.
I patched Alsa 1.0.15rc3.

Sound mutes as soon as I change volume, and I can only rmmod/modprobe
snd-hda-intel to get it back.

But Surround is working with your patch as I can see:
"speaker-test -Dplug:surround51 -c6 -t waw" recognizes correctly all speakears.

"speaker-test -c6 -t waw" does not recognize the speakers correctly,
but it probably should not, or ?!

MythTv is playing stereo files only on the right speakers. I do not
now is this a MythTv or Alsa problem. probably MythTv and I should
create a .asoundrc which should correct this somehow.


I did not try hg, because I thought that Alsa 1.0.15rc3 is very new.


Thanks.

M.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
