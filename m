From: knuarv@nith.no
Subject: Re: Need help with RME Hammerfall Lite (DIGI 9636) and Alsa 0.9.2
Date: Sat,  5 Apr 2003 21:35:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049571329.3e8f3001021fb@webmail.nith.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Quoting Paul Davis <paul@linuxaudiosystems.com>:

> >I'm interested in developing audio applications in Linux, using Alsa for 
> >output. However, I still haven't figured out how to access the various 
> >channels of my RME DIGI 9636, or even playing back stereo tracks. I gather 
> >from earlier posts on this list I'm not the only one with this problem, but
> 
> >I've yet to see a real solution? I thought Alsa was a good match for this 
> >card, but so far its involved more hassle than I expected :\ The conf system
> 
> >remains a mystery to me, can I make use of the 
> >/usr/share/alsa/cards/RME9636.conf file in any way? I have set up an 
> >.asoundrc file according to examples.
> 
> you haven't really describe what you want to do in enough detail for
> me to be able to help. please be more specific.
> 
Basically, as I said, I would like to know how to access the various channels 
through Alsa-lib. Querying the number of devices/subdevices returns one, as does 
aplay (with the -l option). Different channels are normally represented as 
different subdevices in Alsa? 
Most of the time I simply need stereo out, through the s/pdif port, only mono 
sound works for me at the moment.
Thanks for the quick reply.


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
