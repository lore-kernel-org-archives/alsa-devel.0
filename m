From: =?gb2312?q?Roc=20Wu?= <cooloney@yahoo.com.cn>
Subject: Re: An driver error when I using aplay!
Date: Tue, 8 Jun 2004 12:01:51 +0800 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040608040151.63017.qmail@web15207.mail.bjs.yahoo.com>
References: <20040607140817.A28526@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040607140817.A28526@flint.arm.linux.org.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Russell King <rmk+alsa@arm.linux.org.uk>
Cc: perex@suse.cz, clemens@ladisch.de, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Russell King <rmk+alsa@arm.linux.org.uk>
的正文：> On Mon, Jun 07, 2004 at 02:45:20PM +0200,
Takashi
> Iwai wrote:
> > i guess so, too.  as you can see in the original
> post, the error
> > returned from hw_params callback (sample not
> available), thus it
> > doesn't call trigger(START) callback yet at all.
> 
> If we never got past hw_params() then we didn't
> enable the IO,
> and it must be that something else in the system
> fiddled with
> the chip and set it incorrectly.
> 
> > unfurtunately i can't tell any more unless i read
> the driver code.
> > where can i find the code?
> 
> I never officially released the driver, though it
> was part of the
> old -rmk patches back in the 2.6.0-test era.  Where
> Roc has got
> the source from, and what modifications have been
> made is anyones
> guess.

Oh, the code is not officially version. It's from the
ARM Ltd for the Versatile Platform Board. 

So please forgive me for making Russell confused.

Because I am not familar with the ALSA internal code,
I send the error here.

Thanks a lot
Best Regards.


_________________________________________________________
Do You Yahoo!? 
嫌邮箱太小？雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/10m/*http://cn.mail.yahoo.com/event/10m.html


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
