From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 16-channel recording w/ LAYLA, ALSA, JACK, ARDOUR
Date: Wed, 12 Apr 2006 17:40:00 -0400
Message-ID: <1144878001.27496.33.camel@mindpipe>
References: <20060412200957.GA4090@hurl.ugcs.caltech.edu>
	 <1144873089.27496.22.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1144873089.27496.22.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lance Blisters <geoff@hurl.ugcs.caltech.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-04-12 at 16:18 -0400, Lee Revell wrote:
> pcm.multi_capture {
> 	type multi
> 	slaves.a.pcm hw:0,0
> 	slaves.a.channels 8
> 	slaves.b.pcm hw:0,1
> 	slaves.b.channels 8

Please disregard last message - try simply surrounding hw:0,0 and hw:0,1
with quotes.

pcm.multi_capture {
	type multi
	slaves.a.pcm "hw:0,0"
	slaves.a.channels 8
	slaves.b.pcm "hw:0,1"
	slaves.b.channels 8

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
