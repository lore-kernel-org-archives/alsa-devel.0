From: Jaakko =?iso-8859-15?q?Pr=E4tt=E4l=E4?=
	<Jaakko.Prattala@Helsinki.FI>
Subject: Re: Problems with HDSP Multiface+CardBus
Date: Thu, 12 Jun 2003 19:15:31 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306121915.31285.Jaakko.Prattala@Helsinki.FI>
References: <f5fb8f1ddf2fd896fea87cf2331a64c2@essej.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <f5fb8f1ddf2fd896fea87cf2331a64c2@essej.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jesse Chappell <jesse@essej.net>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thursday 12 June 2003 18:14, Jesse Chappell wrote:
> If you're still getting the I/O error on the hdsploader then its
> hard to know what state the thing is really in.
>
> The current drivers only work for me if I boot to windows, (red
> light goes out), reboot to linux (red light flashing until modules
> load).  I see no errors of any kind if I do that.  Is this what you
> are doing?  I have rev 11, BTW.
>
> jlc

No. I use hdsploader. With rev 10 fw the led goes off, with 11 it
stays on (iirc, it's been a while since I tried 0x0b). After that I can
play stuff with aplay -D plughw:0,0, as suggested
by Jaroslav (thank you :-), but I get no sound. The files are read though=
,
judging by how aplay's running time correlates with file length.

Maybe this is just because I don't know how to use the
mixer... What I did was
 # /sbin/modprobe snd-hdsp line_outs_monitor=3D1; hdsploader
 # for i in $(seq 18); do amixer cset name=3DChn,index=3D$i 32768; done;
 # amixer cset numid=3D5 26,26,32768
 # amixer cset numid=3D5 27,27,32768
 # aplay ...
Isn't this supposed to give me something through the
headphones?

As with Jochem's hdsp9652,
cat /proc/asound/card0/pcm0p/sub0/status
shows signs of life (state: RUNNING etc.)

--=20
Jaakko Pr=E4tt=E4l=E4
Jaakko.Prattala@Helsinki.FI



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
