From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: HDSP Line Out Volume Control?
Date: 22 Nov 2002 01:14:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1037924094.8962.32.camel@satellite.undata.org>
References: <20021120151934.GA4999@dogsolitude.org>
	<3DDBFAA0.7CB10A5C@telia.com>
	<1037885686.7938.33.camel@satellite.undata.org>
	<3DDD6074.F3D6C0E0@telia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DDD6074.F3D6C0E0@telia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Marcus Andersson <054185595@telia.com>
Cc: drclaw@dogsolitude.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2002-11-21 at 23:38, Marcus Andersson wrote:
> 32768 is 0dB
> 65535 is +6dB
> 
> It distorts at 100% if you output a signal louder than -6dBFS.

I came across this point outputing OdB sine waves with pd that sounded
like square with channel volume at 100%.
Things get much clearer now, thanks a lot.
You should post an addendum on the alsa-project.org hdsp page,
correcting my double (as 2^15 != 32786) mistake concerning the range of
the gain parameter of the matrix mixer.

Thomas




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
