From: Weijia Yang <gte733z@prism.gatech.edu>
Subject: Re: [PATCH] cs46xx: SPDIF channel status more volume fixes
Date: Thu, 14 Nov 2002 23:00:08 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211142300.08087.gte733z@prism.gatech.edu>
References: <3DD40142.8080209@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DD40142.8080209@cucumelo.org>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sorry to report, but still having same problems w/ the bass.

Weijia Yang

On Thursday 14 November 2002 03:02 pm, Benny Sjostrand wrote:
> Hi!
>
> Here's my final aproach for related to volume fixes. I hope that this
> possibly can solve the bass-problem. I've discovered that the volume was
> a little bit unbalanced in left vs. right channel,  however a human ear
> may not hear the difference maybe some audio equipment can react very
> weird on this, I've tested to change between Stereo 3Stereo or Dolbly
> Pro Logic modes on my receiver the sound is distributed very different.
> Well, this problem should be fixed with this patch, the level should be
> equal in left and right channel (depending on what you playing and your
> mixer settings).
>
> About AC3, I've implemented the channel status as it's based on how it's
> done in ens1370.c. From what I can understand from the spec. it's only
> possible to set channel status byte 0, 1 and 3, the worst thing is that
> all bits are wrapped: byte0,bit0 -> csuv register, bit(32) byte 1 bit
> (8) -> csuv register bit(16)  I hope all weird byte and bits swappings
> are correct.
> I've done some quick test with xine, AC3 still dont work forme, dont
> know exactly what's wrong. I would to have some stuff that could display
> the stream raw data the comes out from SPDIF interface .... :(
>
> Summary:
> - SPDIF channel status implementation (based on how it's done in ens1370.c)
> - Removed the "AC3 Mode" control in mixer
> - Final aproach for rewrite on the DAC and SPDIF input volume mechanism
> - Change mixer control name on some mixer items "IEC 958" -> "IEC958",
> to  heave it in the
>    same way like it's done in the rest of the ALSA code.
>
> /Benny



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
