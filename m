From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: One more cross compile issue: alsa-utils
Date: Tue, 06 Jun 2006 19:19:11 -0400
Message-ID: <1149635951.4072.108.camel@mindpipe>
References: <1149630378.4072.89.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1149630378.4072.89.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-06-06 at 17:46 -0400, Lee Revell wrote:
> But, /home/rlrevell/cross-compile/usr/local/include/alsa/asoundlib.h
> exists!!!  Why does ./configure insist that it does not?

Argh, I am an idiot.  --includedir sets the install destination for
include files, not the place to look for them.  I fixed it by setting
CPPFLAGS correctly.

Sorry for the noise.

Lee
