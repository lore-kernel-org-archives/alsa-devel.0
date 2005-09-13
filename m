From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Simple suggestion for a make target
Date: Tue, 13 Sep 2005 15:37:34 -0400
Message-ID: <1126640254.13893.37.camel@mindpipe>
References: <20050913192422.73152.qmail@web60825.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050913192422.73152.qmail@web60825.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tsw@johana.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-09-13 at 12:24 -0700, Tom Watson wrote:
> Since it appears that frequently the kernel source has older versions of alsa
> when released, wouldn't it be wise to have a target in the alsa-driver-xx.yy.z
> directory that finds the kernel sources, and updates them.  Then one could
> re-compile the kernel and all would be well with the world.
> 
> For those who don't wish to do this, the "./configure;make;make install"
> sequence would work as well.
> 
> I suspect that the kernel configuration would pass thru, so one wouldn't need
> to configure before "transferring" sources, but not being an expert, I don't
> know.
> 
> Maybe this would encourage distrubutions that diddle with the kernel source to
> have an up-to-date alsa.

What would be the point?  It's already simpler than that.
Just ./configure && make && make install in alsa-driver directory to
install a newer ALSA.  It just overwrites the old ALSA modules that came
with the kernel with the newer ones.  You don't even need to reboot.

Lee



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
