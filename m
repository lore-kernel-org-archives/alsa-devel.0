From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: problems with Maestro3 / NEC LM800J/7
Date: 28 Mar 2003 16:58:29 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048899509.2386.76.camel@cmn37.Stanford.EDU>
References: <1048897747.2386.64.camel@cmn37.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1048897747.2386.64.camel@cmn37.Stanford.EDU>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: alsa-devel@lists.sourceforge.net, rsegnini@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

> Hi gurus... I'm having problems getting sound out of this laptop:
>   NEC LM800J/7
> I'm using 2.4.20-pre6 + current alsa cvs (post 0.9.2)... After
> installing everything is fine, drivers load perfectly, I unmute all
> controls, raise all volumes and aplay seems happy playing a soundfile,
> except I get no sound (from the speakers or the headphone connection). I
> tried tweaking all controls in gamix with no success...

For future reference: I started playing with the module options and got
it to work when loading with:

  amp_gpio=3

-- Fernando




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
