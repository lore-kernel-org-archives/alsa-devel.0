From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: [Jackit-devel] alsaseq reorders my events
Date: Thu, 1 Mar 2007 17:17:39 -0500
Message-ID: <75b66ecd0703011417p66637a9duaa59a3f19251ba68@mail.gmail.com>
References: <70a871c80703010535p512ebabfke3c57d441a7fe2fb@mail.gmail.com>
	<1172768362.11019.1177218661@webmail.messagingengine.com>
	<70a871c80703010923l1cd70240n4a993ef4a2a60c3f@mail.gmail.com>
	<75b66ecd0703011412l513be986l5ea67d8c8e47e66b@mail.gmail.com>
	<70a871c80703011414u4f084a13o563184458382fcba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <70a871c80703011414u4f084a13o563184458382fcba@mail.gmail.com>
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
To: Dmitry Baikov <dsbaikov@gmail.com>
Cc: Jack Dev List <jackit-devel@lists.sourceforge.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 3/1/07, Dmitry Baikov <dsbaikov@gmail.com> wrote:
> On 3/2/07, Lee Revell <rlrevell@joe-job.com> wrote:
> > On older kernels it depends on whether ALSA sequencer is configured to
> > use RTC or regular kernel timers.  And poll() resolution is 4ms by
> > default (HZ=250) not 1ms.
> HZ=1000 here :)
>
> > Anyway mainline Linux kernel has hrtimers now.  So shouldn't the
> > resolution of all timeouts be much better than 1ms?
>
> poll() has 1ms resolution by design (API) :(
>

Hmm then I would consider using whatever userspace API hrtimers expose
if it's acceptable to require a recent kernel (or you don't mind
implementing lower resolution for legacy systems).

Lee

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
