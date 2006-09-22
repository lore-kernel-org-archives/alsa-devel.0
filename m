From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Rawmidi device naming
Date: Fri, 22 Sep 2006 14:13:37 -0400
Message-ID: <1158948818.1097.99.camel@mindpipe>
References: <1158946723.1097.90.camel@mindpipe>
	<1158948259.1036.271601876@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1158948259.1036.271601876@webmail.messagingengine.com>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-09-22 at 20:04 +0200, Clemens Ladisch wrote:
> Lee Revell wrote:
> >  # aplaymidi -l
> >  Port    Client name                      Port name
> >  64:0    Dreamchip MPU interface 1        Dreamchip MPU interface 1
> >  64:32   Dreamchip MPU interface 1        Dreamchip MPU interface 2
> > 
> > Why do both ports get "Dreamchip MPU interface 1" for the client name? 
> 
> Because there is only one client.
> 
> The client name comes from the card's shortname.

I don't think so.  The card's shortname is just "Dream".  The only place
I use "Dreamchip MPU interface %i" is in the code I posted.

Lee


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
