From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Audigy SPDIF Output Sample Rate
Date: Fri, 25 Feb 2005 18:11:56 -0500
Message-ID: <1109373116.14434.3.camel@krustophenia.net>
References: <1108880895.6773.50.camel@radium.gaugetheory.org>
	 <1109351825.9681.43.camel@krustophenia.net>
	 <1109367868.6245.9.camel@cthulhu.rlyeth.net>
	 <1109368727.13193.10.camel@krustophenia.net>
	 <1109371150.14056.2.camel@krustophenia.net>
	 <1109372144.6245.32.camel@cthulhu.rlyeth.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ixwwsUzSmGNCjrWswYRs"
In-Reply-To: <1109372144.6245.32.camel@cthulhu.rlyeth.net>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: The Orqwith Vagrant <theorqwithvagrant@bredband.net>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-ixwwsUzSmGNCjrWswYRs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-02-25 at 23:55 +0100, The Orqwith Vagrant wrote:
> On Fri, 2005-02-25 at 17:39 -0500, Lee Revell wrote:
> > On Fri, 2005-02-25 at 16:58 -0500, Lee Revell wrote:
> > > On Fri, 2005-02-25 at 22:44 +0100, The Orqwith Vagrant wrote:
> > > > As someone who does have a 96 Khz capable reciever, I thought I might
> > > > add my own comments tho this. The 96khz setting works perfect, sounds
> > > > perfect with this patch; however, 48 & 44.1 are reversed now. Trying to
> > > > play 48khz samples when the setting is 44.1 causes ugly scratchy
> > > > distortion, but oddly, only on the right channel. Using the spdif raw
> > > > PCM device, which reverses left and right channels of a stereo file,
> > > > still has the distortion on the right channel.
> > > 
> > > OK I'll post a new patch.
> > > 
> > 
> > Please try the attached patch (revert the last patch first).
> > 
> > Lee
> > 
> 
> Done. Sample rates are correct with this patch. The distortion when
> playing 48khz samples with 44.1khz spdif rate is also gone.
> 

OK, great!  That means that both the OSS and the ALSA driver had it
wrong.

ALSA maintainers, please apply this patch to CVS.  Here it is again for
convenience.

Summary: Fix the Audigy SPDIF sample rate register definitions

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
 


--=-ixwwsUzSmGNCjrWswYRs
Content-Disposition: attachment; filename=emu10k1-96-fix2.patch
Content-Type: text/x-patch; name=emu10k1-96-fix2.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa-postv12/alsa-kernel/include/emu10k1.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/emu10k1.h,v
retrieving revision 1.57
diff -u -r1.57 emu10k1.h
--- alsa-postv12/alsa-kernel/include/emu10k1.h	17 Feb 2005 14:48:07 -0000	1.57
+++ alsa-postv12/alsa-kernel/include/emu10k1.h	25 Feb 2005 22:38:24 -0000
@@ -765,8 +765,8 @@
 #define A_SPDIF_SAMPLERATE	0x76		/* Set the sample rate of SPDIF output		*/
 #define A_SPDIF_RATE_MASK	0x000000c0
 #define A_SPDIF_48000		0x00000000
-#define A_SPDIF_44100		0x00000040
-#define A_SPDIF_96000		0x00000080
+#define A_SPDIF_44100		0x00000080
+#define A_SPDIF_96000		0x00000040
 
 /* 0x77,0x78,0x79 "something i2s-related" - default to 0x01080000 on my audigy 2 ZS --rlrevell	*/
 /* 0x7a, 0x7b - lookup tables */

--=-ixwwsUzSmGNCjrWswYRs--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
