From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: smart and automatic use of dmix and dsnoop - feature suggestion.
Date: Mon, 17 Nov 2003 14:36:31 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311171936.hAHJaW1B013634@oud.linuxaudiosystems.com>
References: <200311172008.28812.pwk.linuxfan@gmx.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 17 Nov 2003 20:08:26 +0100."
             <200311172008.28812.pwk.linuxfan@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Kirk <pwk.linuxfan@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>what you say seems to be valid to me, but not if you implement smart dmix the
>way I said =). The way I suggested *every* application would connect to smart
>dmix, and none directly to alsa lib (except those that use devices like hw: -
>and those should never be mixed). Since every stream is connected to smart
>dmix, there is no need to *reroute* anything in the case of needed mixing.
>The only thing that has to happen, is that the new stream, that has to be
>mixed into the existing one due to hardware limitations has to be resampled
>etc. to make mixing possible.

believe or not, i actually think that peter is right here. if dmix
works well enough to be used by any application, then i think it
should be used for all non-hw accesses unless the user configures it
otherwise. if it doesn't work this well, it should :)

--p


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
