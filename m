From: Kevin F.Quinn <co@kevquinn.com>
Subject: Re: Re: alsa-lib patches
Date: Mon, 16 May 2005 0:15:33 +0200
Message-ID: <MJYDXX111E5W3.18076434643TADVE@kevquinn.com>
References: <1116189290.10653.5.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
References: <1116189290.10653.5.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 15/5/2005 22:34:50, Lee Revell (rlrevell@joe-job=2Ecom) wrote:
> On Sun, 2005-05-15 at 22:24 +0200, Kevin F=2EQuinn wrote:
> > You also need to make it thread-safe, as Clements mentioned
> 
> Why?  The rest of alsa-lib is not thread-safe=2E

Only by comparison with control/hcontrol=2Ec, which has a similar situatio=
n already in that style (see snd_hctl_sort()); also conf=2Ec, pcm/pcm_mete=
r=2Ec and pcm/pcm_share=2Ec go to the trouble of pthread mutexes=2E  If it=
's overkill there, then fair enough=2E




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
