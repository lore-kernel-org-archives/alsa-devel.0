From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question Regarding Simple ALSA Stereo Output
Date: Wed, 23 Jun 2004 17:18:11 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406231713580.16948-100000@studcom.urz.uni-halle.de>
References: <Pine.GSO.4.58.0406231057040.6839@blue.cs.yorku.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.GSO.4.58.0406231057040.6839@blue.cs.yorku.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bill Kapralos <billk@cs.yorku.ca>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Bill Kapralos wrote:
> The card does support stereo and I can successfully set the number
> of channels to two (using snd_pcm_hw_params_set_channels() ).
> After adding the code you suggested, the following was output:
> ...
>  channels     : 2

Looks as if there's nothing wrong with your program.

> I am using an SGI "box" wit dual Pentium III processors running
> SuSe Linux with a (VT82C686 ACER AC97 Audio Controller).

Probably the AC'97 codec is configured for mono output.  What codec do
you have?  (see second line at top of alsamixer screen)  What are the
mixer settings?  (see /etc/asound.state after running "alsactl store")


Regards,
Clemens




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
