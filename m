From: Raymond <rayau@netvigator.com>
Subject: Re: ac97_codec.c - unresolved symbol msecs_to_jiffies   on Kernel
 2.4
Date: Tue, 12 Jul 2005 21:07:17 +0800
Message-ID: <42D3C085.9090600@netvigator.com>
References: <42D38196.6020106@netvigator.com> <Pine.HPX.4.33n.0507121253250.2200-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0507121253250.2200-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

ac97_codec.c can be compiled and snd-ac97-codec.o can be loaded.

http://cvs.sourceforge.net/viewcvs.py/*checkout*/alsa/alsa-driver/include/adriver.h?rev=1.128

http://cvs.sourceforge.net/viewcvs.py/*checkout*/alsa/alsa-driver/configure.in?rev=1.318

./cvscompile --with-cards

/root/alsa/alsa-driver/include/adriver.h: In function `jiffies_to_msecs':
/root/alsa/alsa-driver/include/adriver.h:639: warning: division by zero



Clemens Ladisch wrote:
> Raymond wrote:
> 
>>ac97_codec.c:2252: warning: implicit declaration of function
>>`msecs_to_jiffies'
>>
>>http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/ac97/ac97_codec.c?r1=1.188&r2=1.189
> 
> 
> This was caused by a bug in the configure script which has been fixed
> now.
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
