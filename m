From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: IO streams sync
Date: Mon, 19 Jun 2006 12:21:36 -0400
Message-ID: <1150734097.4428.179.camel@mindpipe>
References: <mailman.3908.1150727591.2958.alsa-devel@lists.sourceforge.net>
	<4496CE0A.2000109@openstudionetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4496CE0A.2000109@openstudionetworks.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alejandro <alejandro@openstudionetworks.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-06-19 at 18:17 +0200, alejandro wrote:
> Hello,
> 
> Is there any document describing the ALSA components and functions?
> Particularly the link between audio I/O and timers, in order to frame 
> accurate sync multiple audio cards and video.

You probably want to be using JACK for this.  ALSA is just a low level
HAL.  There are some patches floating around that add video capabilities
("videojack").

Lee
