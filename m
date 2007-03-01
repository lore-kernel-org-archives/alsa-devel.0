From: Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Jackit-devel] alsaseq reorders my events
Date: Thu, 01 Mar 2007 22:02:39 +0000
Message-ID: <45E74D7F.3010305@rncbc.org>
References: <70a871c80703010535p512ebabfke3c57d441a7fe2fb@mail.gmail.com>	<1172768362.11019.1177218661@webmail.messagingengine.com>
	<70a871c80703010923l1cd70240n4a993ef4a2a60c3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <jackit-devel-bounces@lists.sourceforge.net>
In-Reply-To: <70a871c80703010923l1cd70240n4a993ef4a2a60c3f@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: jackit-devel-bounces@lists.sourceforge.net
Errors-To: jackit-devel-bounces@lists.sourceforge.net
To: Dmitry Baikov <dsbaikov@gmail.com>
Cc: Jack Dev List <jackit-devel@lists.sourceforge.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dmitry Baikov wrote:
> On 3/1/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
>> Does this code really compute the time stamp _after_ setting it?
> 
> Gotcha! Very stupid....
> I copied this code from another place AND misread
> snd_seq_ev_schedule_real() body - I was sure it stores timeout's
> pointer, not value.
> 
> Thank you, gentlemen.
> 
> And since I already rewritten this code with snd_seq_ev_set_direct() +
> poll(), I have a question:
> Does queue + snd_seq_ev_schedule_real() offer better real resolution
> than poll (which gives 1 ms)?
> 

Dunno what really advantage you're after with poll(), but then I'll ask
you what are the actual problems you're trying to workaround by choosing
like so?

AFAICT using an alsa-seq queue and thus snd_seq_ev_schedule_...() are
pretty fitted to the job, or isn't? besides it is kindly assisted at
kernel (module) level that is.

hmm... but then again, if you think you've found something wrong with
alsa-seq queuing... it surely can be fixed, of course ;)

Clemens?
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
