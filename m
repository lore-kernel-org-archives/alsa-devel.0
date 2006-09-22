From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: In alloc and free of snd_pcm_hw_params_t,
 segmentation   happens
Date: Fri, 22 Sep 2006 10:26:07 +0200
Message-ID: <1158913567.12289.271560581@webmail.messagingengine.com>
References: <20060922144235.04e61757@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060922144235.04e61757@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Junji Umeno <umeno@elwsc.co.jp>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Junji Umeno wrote:
> After an allocation with snd_pcm_hw_params_alloca,
> snd_pcm_hw_params_free stops by segmentation fault error.

There are two ways of allocating such structures:
1) Use snd_xxx_malloc() and snd_xxx_free() to allocate memory from the
   heap, or
2) use snd_xxx_alloca() to allocate memory from the stack.

The snd_xxx_alloca() functions behave just like alloca(): their memory
is automatically freed when the function returns.


HTH
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
