From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: emu10k1 bug and patch (0.9.0rc7)
Date: Fri, 14 Feb 2003 12:31:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E4CD381.6C7B0D40@libero.it>
References: <Pine.LNX.4.21.0302141155420.8732-100000@mailserver.intern.bfad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tomasz motylewski <T.Motylewski@bfad.de>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

tomasz motylewski wrote:
> 
> On Fri, 14 Feb 2003, Takashi Iwai wrote:
> 
> > and since boundary = buffer_size as default, the above condition will
> > be not satisfied (i.e. diff is equal with -(runtime->boundary/2) and
> 
> Is not boundary much bigger than buffer size? At least I have seen it in cs4281
> driver some time ago. Is there any ALSA recommendation what value should be
> used for boundary?

        runtime->boundary = runtime->buffer_size;
        while (runtime->boundary * 2 <= LONG_MAX - runtime->buffer_size)
                runtime->boundary *= 2;

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
