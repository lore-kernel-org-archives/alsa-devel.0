From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: symbol _snd_seq_hw_open is not
	defined	inside	(null)
Date: Sun, 08 Oct 2006 13:03:01 -0400
Message-ID: <1160326981.17615.112.camel@mindpipe>
References: <871wpjgthv.fsf@mixandgo.ro>
	<1160323113.17615.97.camel@mindpipe> <87ejtig2wt.fsf@cezar@mixandgo.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <87ejtig2wt.fsf@cezar@mixandgo.ro>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Cezar <cezar@mixandgo.ro>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-10-08 at 19:58 +0300, Cezar wrote:
> aplaymidi file.mid requires a port
> 
> aplaymidi -p 0:0 file.mid says : 
> 
> Cannot connect to port 0:0 - Operation not permited
> 

Where did you get 0:0?

Use aplaymidi -l to list available ports.

Lee


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
