From: Anders Torger <torger@ludd.luth.se>
Subject: Re: problems with rme digi96/8
Date: Wed, 11 Jun 2003 16:15:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306111615.56664.torger@ludd.luth.se>
References: <1054808252.7022.8.camel@duff> <200306111548.19324.torger@ludd.luth.se> <1055340198.1390.58.camel@duff>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1055340198.1390.58.camel@duff>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gorm David Lai <lai@daimi.au.dk>
Cc: Martin Langer <martin-langer@gmx.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 11 June 2003 16.03, Gorm David Lai wrote:
> Thanks for the advice, though it still doesn't work.
> It seems to play, and sets the right sync on the mixing console. The
> console just doesn't get any input.
> Do I have to unmute the card anywhere?

Note that my example uses /dev/zero (zero input) so it should be silent. 
Put something with sound in it instead of /dev/zero.

No, you shouldn't need to unmute the card (if you are not using analog 
output), the digital output is just digital, no volume control for it 
exists. A classical mistake is of course to connect ADAT input to ADAT 
input, but I suppose you have checked that.

/Anders



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
