From: Martin Langer <martin-langer@gmx.de>
Subject: Re: hdsp/firmware problem
Date: Fri, 14 Feb 2003 15:09:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030214140924.GC3246@tuba.home>
References: <20030214131848.GA1586@finnendahl.de> <E18jfvD-0006MO-00@sc8-sf-list1.sourceforge.net>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E18jfvD-0006MO-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: finnendahl@folkwang-hochschule.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 14, 2003 at 08:30:24AM -0500, Paul Davis wrote:
> >the driver/interface works. The guy in Rotterdam tried the line
> >outputs on the front (I realized that this might have been the reason
> >5 minutes after I posted my previous mail).
> 
> can you clarify what you mean by this?
> 
> >Since the hdsp code reports firmware load failure there still might be
> >something wrong, but the Multiface plays sound as it should :-).
> 
> so it looks like it may just a need for a more lenient timeout check
> on the FIFO?
> 

There is also a bugreport on sourceforge about latest hdsp firmware problems:
http://sourceforge.net/tracker/index.php?func=detail&aid=685001&group_id=27464&atid=390601

Date: 2003-02-11 15:59 
Priority: 5 
Submitted By: Nobody/Anonymous (nobody) 
Assigned To: Jaroslav Kysela (perex) 
Category: driver 
Status: Open 

Summary:
hdsp driver is not compatible with latest firmware
In order to make alsa-hdsp recognize the hdsp I had to
downgrade the firmware of the card(bus) to revision 10.
There is an utility available to downgrade the firmware
here:
http://www.rme-audio.de/english/download/drivers_archive.htm
-- johannes.taelman(a)rug.ac.be 



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
