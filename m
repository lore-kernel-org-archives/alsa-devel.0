From: Samuel S Chessman <chessman@tux.org>
Subject: Re: Re: [Alsa-devel] Re: [PATCH] snd_pcm_hw_params_set_rate_near
 val pointer
Date: Wed, 3 Mar 2004 11:31:41 -0500 (EST)
Sender: jackit-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.30.0403031130210.15804-100000@gwyn.tux.org>
References: <Pine.HPX.4.33n.0403031324170.12080-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0403031324170.12080-100000@studcom.urz.uni-halle.de>
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Jack O'Quin <joq@io.com>, "[jackit-devel]" <jackit-devel@lists.sourceforge.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 3 Mar 2004, Clemens Ladisch wrote:

> To elaborate on this:  both ALSA 0.9 and 1.0 support both versions of
> these functions, and allow selecting between them by defining
> ALSA_PCM_OLD_HW_PARAMS_API or ALSA_PCM_NEW_HW_PARAMS_API.  Without one
> of these symbols defined, the default would be the old API when
> compiling with 0.9 headers and the new one with 1.0 headers.  All
> versions of the library are binary compatible with both old and new
> applications.
>
> > So, maybe this is an ALSA bug in emulating the older interface?
>
> In theory, this should not happen.
>
> Sam, which version of ALSA are your ALSA headers/libraries from?
>

> > > This occurs against current CVS of alsa. (2004-03-02)

I will investigate if an old ALSA header is on the machine.

Sam


-- 
   Sam Chessman                                         chessman (a) tux.org
    First do what's necessary, then what's possible, finally the impossible.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
