From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: 1.0.0 Requirements, Integration of sound deamon
 (JACK)
Date: Sat, 12 Oct 2002 00:03:11 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA6E82F.4070302@boosthardware.com>
References: <20021011131309.46309.qmail@web40613.mail.yahoo.com>
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
> Hello ALSA developers,
> 
>   I was wondering if there is a requirement list for
> 1.0.0 release of ALSA.  If not, what would be expected
> in a 1.0.0 release?  (I've got a few brain/cpu cycles
> to spare towards a 1.0.0 release)
> 
>   I know the topic of sound deamons has really been
> stomped in the ground, but I haven't found any
> information about the possible inclusion of the JACK
> sound deamon into an alsa release.  Since running JACK
> does not lock up any of the sound device files, all
> non-JACK-aware programs will act normally while the
> deamon is running.
> 


Have you used JACK?

AFAIK it definitely requires a pcm. You may have used it on hardware 
that supports multiopen which would explain what you have observed.


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
