From: "Maen Suleiman" <maen.suleiman@gmail.com>
Subject: Re: Bridging captured stream to playback stream
Date: Fri, 2 Mar 2007 23:12:16 +0200
Message-ID: <9c1cad6e0703021312n2fe8b370ibb2aec1c607e8971@mail.gmail.com>
References: <9c1cad6e0703020822g88eae6bq4a2943db42101b2@mail.gmail.com>
	<75b66ecd0703020844v1bba0dbax4dbf6a4273e792aa@mail.gmail.com>
	<f2b55d220703021259h2b96dc2em822047902e836cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <f2b55d220703021259h2b96dc2em822047902e836cd@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Michael K. Edwards" <medwards.linux@gmail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Where can I get this patch please , and talking realtime priorities ,
is there another recommonded realtime patches for ALSA .

Thanks in advance

On 3/2/07, Michael K. Edwards <medwards.linux@gmail.com> wrote:
> On 3/2/07, Lee Revell <rlrevell@joe-job.com> wrote:
> > arecord | aplay
>
> And if you do this, you may want the patch I posted to route
> diagnostics and progress messages to stderr instead of stdout.  It
> also sets real-time priorities in such a way that you will not have
> nearly as many overrun/underrun conditions on audio devices with
> little buffering capacity.
>
> Cheers,
> - Michael
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
