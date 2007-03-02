From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [Jackit-devel] alsaseq reorders my events
Date: Fri, 02 Mar 2007 11:35:47 +0100
Message-ID: <1172831747.32165.1177353549@webmail.messagingengine.com>
References: <70a871c80703010535p512ebabfke3c57d441a7fe2fb@mail.gmail.com>
	<1172768362.11019.1177218661@webmail.messagingengine.com>
	<70a871c80703010923l1cd70240n4a993ef4a2a60c3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <70a871c80703010923l1cd70240n4a993ef4a2a60c3f@mail.gmail.com>
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

Dmitry Baikov wrote:
> Does queue + snd_seq_ev_schedule_real() offer better real resolution
> than poll (which gives 1 ms)?

The default timer used by sequencer timers is the RTC timer at 1024 Hz,
i.e., 0.98 ms.  hrtimers are not yet supported.


HTH
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
