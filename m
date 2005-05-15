From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: alsa-lib patches
Date: Sun, 15 May 2005 18:33:31 -0400
Message-ID: <1116196411.25898.1.camel@mindpipe>
References: <1116189290.10653.5.camel@mindpipe>
	 <MJYDXX111E5W3.18076434643TADVE@kevquinn.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <MJYDXX111E5W3.18076434643TADVE@kevquinn.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Kevin F.Quinn" <co@kevquinn.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-05-16 at 00:15 +0200, Kevin F.Quinn wrote:
> On 15/5/2005 22:34:50, Lee Revell (rlrevell@joe-job.com) wrote:
> > On Sun, 2005-05-15 at 22:24 +0200, Kevin F.Quinn wrote:
> > > You also need to make it thread-safe, as Clements mentioned
> > 
> > Why?  The rest of alsa-lib is not thread-safe.
> 
> Only by comparison with control/hcontrol.c, which has a similar situation already in that style (see snd_hctl_sort()); also conf.c, pcm/pcm_meter.c and pcm/pcm_share.c go to the trouble of pthread mutexes.  If it's overkill there, then fair enough.
> 

OK, makes sense.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
