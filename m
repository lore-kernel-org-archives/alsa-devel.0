From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Frequency Problems with 0d8c:0201 and snd-usb-audio
Date: Fri, 17 Nov 2006 18:26:21 +0100
Message-ID: <1163784381.27992.276274101@webmail.messagingengine.com>
References: <1163613613.3406.14.camel@richip.dhs.org>
	<1163668222.21027.276016817@webmail.messagingengine.com>
	<1163696903.3406.29.camel@richip.dhs.org>
	<1163697994.10962.276090935@webmail.messagingengine.com>
	<1163701408.3406.41.camel@richip.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1163701408.3406.41.camel@richip.dhs.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Richi Plana <richip@richip.dhs.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Richi Plana wrote:
> On Thu, 2006-11-16 at 18:26 +0100, Clemens Ladisch wrote:
> > What kind of distortion?
> 
> As objectively as I can describe it: the audio played at 48 kHz seems to
> be coming out at the right speed, but the sound itself is played at a
> higher pitch.
> 
> Playback:
>   Status: Running
>     Packet Size = 392
>     Momentary freq = 48000 Hz (0x30.0000)

This device has two configuration that are supposed to support 48 kHz,
but the second one (that is used by the driver) has a packet size that
would be about right for 96 kHz.

Please try the patch below.


HTH
Clemens


--- alsa.orig/alsa-kernel/usb/usbaudio.c	2006-11-14 21:02:42.000000000 +0100
+++ alsa/alsa-kernel/usb/usbaudio.c	2006-11-16 23:04:29.000000000 +0100
@@ -2478,7 +2478,13 @@ static int parse_audio_format_rates(stru
 		fp->nr_rates = nr_rates;
 		fp->rate_min = fp->rate_max = combine_triple(&fmt[8]);
 		for (r = 0, idx = offset + 1; r < nr_rates; r++, idx += 3) {
-			unsigned int rate = fp->rate_table[r] = combine_triple(&fmt[idx]);
+			unsigned int rate = combine_triple(&fmt[idx]);
+			/* C-Media CM6501 mislabels its 96 kHz altsetting */
+			if (rate == 48000 && nr_rates == 1 &&
+			    chip->usb_id == USB_ID(0x0d8c, 0x0201) &&
+			    fp->altsetting == 5 && fp->maxpacksize == 392)
+				rate = 96000;
+			fp->rate_table[r] = rate;
 			if (rate < fp->rate_min)
 				fp->rate_min = rate;
 			else if (rate > fp->rate_max)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
