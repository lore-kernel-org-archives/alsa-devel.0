From: holborn <holborn@telefonica.net>
Subject: Re: emu10k1 Music gain
Date: Mon, 19 Jan 2004 12:12:32 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401191212.33035.holborn@telefonica.net>
References: <200401181949.17285.holborn@telefonica.net> <s5h8yk45h5f.wl@alsa2.suse.de>
Reply-To: holborn@telefonica.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8yk45h5f.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Lunes 19 Enero 2004 11:09, Takashi Iwai wrote:

Hi!

> > Any way to increase the gain in the Music channel of an emu10k1 device?
>
> 	% amixer set "Music" 100%

Yes ... but with PCM and Music in 100% and with MIDI volumes and velocity to 
85% (more or less) ... recording with aplay or whatever ... the gain are -40 
Db ... (more or less). 

> or do you mean amplitude more?  then you'll need to change the DSP
> code.

Umhh sorry ... can you explain me a little bit?  No way changing the driver? 

Thanks


Josep




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
