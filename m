From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: 64 soundcards
Date: Fri, 04 Aug 2006 12:23:18 +0100
Message-ID: <44D32E26.10106@superbug.co.uk>
References: <44D327C2.1060600@riccardotempesta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-30.mail.demon.net (anchor-post-30.mail.demon.net
	[194.217.242.88])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1377C16E
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Aug 2006 13:23:20 +0200 (MEST)
In-Reply-To: <44D327C2.1060600@riccardotempesta.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Riccardo Tempesta <info@riccardotempesta.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Riccardo Tempesta wrote:
> I need to use up to 64 soundcards with ALSA in a single system.
> I know I can reach 32 with dynamic minors... any idea for 64?
>
> Thank you in advantage.
>
>   
What application is this? How many playback and capture channels are you 
using?
Do you need low latency for the application?
What sort of PCI bus arrangement does this machine with 64 PCI slots have?

I ask, because I think it is unlikely to work, due to PCI bus 
arbitration latency.

James


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
