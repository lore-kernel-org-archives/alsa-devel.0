From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: Re: dmix plugin
Date: Mon, 17 Feb 2003 11:32:52 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0302171120240.30013-100000@mailserver.intern.bfad.de>
References: <1045476241.3e50b391808f8@webmail2.namezero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1045476241.3e50b391808f8@webmail2.namezero.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslaw Sobierski <fycio@gucio.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Feb 2003, Jaroslaw Sobierski wrote:

> > Here I don't understand you. Suppose we have 3 samples to mix:
> > a = 0x7500
> > b = 0x7400
> > c = 0x8300
> > 
> > If you do a + b + c (in this order) you obtain:
> > d=0
> > d += a -> 7500
> > d += b -> 0xe900 -> 0x7fff
> > d += c -> 0x02ff
> > 
> > while the correct result is 0x6c00. You see?

Well, but when adding a+b we have no idea that that overlow will be compensated
by next very big negative sample. Also mixing signals which already fill 90% of
dynamic range is not a good idea. My "fix" is heuristic - it works for
occasional _small_ overflows like 0x4100+0x4000 -> 0x7fff is much better than
0x8100. 

The idea of dmix as I understand it is that buffer is already in the native
format for the sound card. So if sound card supports 24 bit, OK. But then
people will start mixing 24 bit samples :-)

> AFAIK most hardware does not mix by reducing volume before the sum. On the
> contrary, it is usually summed "as is" to a wider register, and often even so

And here our "wider register" is 16bit. That means end users should not expect
too much if thay mix full power signals on it.

BTW. If you have uncorrelated signals, then to mix 4 signals it may be good
enough to reduce the amplitude of them just factor 2, because power will drop
factor 4. Ocassionally there will be overrruns, but 0x7fff limit will make it
almost not hearable. Not a correct fix, but I can assure you that it works in
standard cases :-)

Best regards,
--
Tomasz Motylewski
BFAD GmbH & Co. KG



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
