From: holborn <holborn@telefonica.net>
Subject: Re: questions about card detection
Date: Fri, 29 Aug 2003 11:31:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308291131.35068.holborn@telefonica.net>
References: <1062147863.5596.15.camel@trimble1dhcp30.ups.edu> <s5hk78wyfc6.wl@alsa2.suse.de>
Reply-To: holborn@telefonica.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk78wyfc6.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Viernes, 29 de Agosto de 2003 10:37, Takashi Iwai wrote:

Hi!


> "sub-device" is the lowest level of PCM abstration.
> an actual PCM stream is always assigned to a sub-stream.
>
> the sub-device is introduced to represent the cases like
> multi-playback function.  for example, SB Live can play 32 stereo
> streams at the same time.  in the ALSA, the driver assigns 32
> sub-devices (sub-streams) to a playback device.

Are this sub-devices used by the internal SB Live synthesizer?  
Or if that is not true, anyway to assign the sound of the different Midi 
Channels to that sub-devices in a way to apply LADSPA effects?

Thanks

Josep
 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
