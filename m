From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: multiple devices per card?
Date: Sat, 05 Oct 2002 05:22:51 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D9DF89B.8090604@boosthardware.com>
References: <20021004193614.30552.qmail@web11503.mail.yahoo.com>
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
To: Guilhem Tardy <guilhem_tardy@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Guilhem Tardy wrote:
> Hi,
> 
> I am unsure what makes the most sense for multiple pcm channels on the same
> card:
>  a) N devices, 1 pcm channel each
>  b) 1 device, N pcm channels each
> 
> In the same vein, is the mixer always one per card?
> 

well if we have hw:0,0 hw:0,1 hw:0,2

Then it looks like option b to me. But Jaroslav confused me recently by 
saying something that sounded like a is the case.



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
