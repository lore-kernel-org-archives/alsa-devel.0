From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: .asoundrc file
Date: Fri, 16 Aug 2002 12:56:25 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D5C77E9.1040807@boosthardware.com>
References: <3D5C6ECE.721D748C@anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: u9514439@anu.edu.au
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Kris Modrak wrote:
> The start of my .asoundrc file is as follows:
> 
> pcm.rme9652 {
> type hw
> card 0
> device 0
> }
> 
> ctl.rme9652 {
> type hw
> card 0
> }
> 
> What is the purpose of the ctl.rme9652 declaration? My plugin devices
> seem to work without it.
> 

It is a configuration for the onboard mixer. Very little is known about 
why we use it. Some programs (JACK) won't work without it.


> Regards
> Kris Modrak
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: OSDN - Tired of that same old
> cell phone?  Get a new here for FREE!
> https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> 



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
