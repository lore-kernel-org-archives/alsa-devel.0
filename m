From: Marcus Andersson <054185595@telia.com>
Subject: Re: HDSP Line Out Volume Control?
Date: Thu, 21 Nov 2002 23:38:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DDD6074.F3D6C0E0@telia.com>
References: <20021120151934.GA4999@dogsolitude.org>
		<3DDBFAA0.7CB10A5C@telia.com> <1037885686.7938.33.camel@satellite.undata.org>
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
To: Thomas Charbonnel <thomas@undata.org>
Cc: drclaw@dogsolitude.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thomas Charbonnel wrote:
> As Michael is stating, full volume (100% in alsamixer, or full 65536
> value in the matrix mixer) causes distortion. 50%, or 32786, seems to be
> the highest distortion-free value. I already mentioned this on the list
> but got no answer.

32768 is 0dB
65535 is +6dB

It distorts at 100% if you output a signal louder than -6dBFS.

Marcus


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
