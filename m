From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: 1.0.0 Requirements, Integration of sound deamon
 (JACK)
Date: Sun, 13 Oct 2002 15:05:15 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA90D1B.2030406@boosthardware.com>
References: <20021013025239.17302.qmail@web40603.mail.yahoo.com>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: David Sankel <camio@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

David Sankel wrote:
>>Have you used JACK?
>>
>>AFAIK it definitely requires a pcm. You may have
>>used it on hardware 
>>that supports multiopen which would explain what you
>>have observed.
> 
> 
> Yes, I have used jack.  I meant that it doesn't open
> the sound device when it is not being used by a host application.
> 

I'm pretty sure it does. In order to run it needs to claim a pcm device 
(or multiple devices as specified in an .asoundrc). I just tested that 
by starting jackd and then trying to start alsaplayer on the same device 
and jackd blocks alsaplayer until it is shutdown then alsaplayer will start.




-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
