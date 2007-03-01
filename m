From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: Re: [Jackit-devel] alsaseq reorders my events
Date: Thu, 1 Mar 2007 20:23:46 +0300
Message-ID: <70a871c80703010923l1cd70240n4a993ef4a2a60c3f@mail.gmail.com>
References: <70a871c80703010535p512ebabfke3c57d441a7fe2fb@mail.gmail.com>
	<1172768362.11019.1177218661@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1172768362.11019.1177218661@webmail.messagingengine.com>
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
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: Jack Dev List <jackit-devel@lists.sourceforge.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 3/1/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
> Does this code really compute the time stamp _after_ setting it?

Gotcha! Very stupid....
I copied this code from another place AND misread
snd_seq_ev_schedule_real() body - I was sure it stores timeout's
pointer, not value.

Thank you, gentlemen.

And since I already rewritten this code with snd_seq_ev_set_direct() +
poll(), I have a question:
Does queue + snd_seq_ev_schedule_real() offer better real resolution
than poll (which gives 1 ms)?

Dmitry.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
