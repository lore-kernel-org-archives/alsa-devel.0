From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: made the jump from 0.9.0rc1 (2.4.29) to 1.0.8
	(2.6.11.9)
Date: Mon, 16 May 2005 02:54:06 -0400
Message-ID: <1116226446.26508.2.camel@mindpipe>
References: <428836D1.6060603@covad.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <428836D1.6060603@covad.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: John O'Donnell <johnod@covad.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-05-16 at 01:59 -0400, John O'Donnell wrote:
> alsamixer: function snd_ctl_open failed for default: No such file or 
> directory
> 

It sounds like the /dev/snd/* entries do not exist.  Your distros
install scripts should create them.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
