From: =?gb2312?q?Roc=20Wu?= <cooloney@yahoo.com.cn>
Subject: how to cross compile the alsa util?
Date: Mon, 31 May 2004 10:28:39 +0800 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040531022839.56401.qmail@web15201.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello alls:

Sorry for post the mail again. I posted it several
days ago, but no response. Anybody can give me some
hints?

I cross compiled the alsa-lib-1.04 to arm platform.
The 2.6.6 kernel including alsa driver is ok on our
ARM board, so I want to test the driver. how to do it?

I think maybe the first step is to crosscompile the
alsa utils to play a wave audio file.

CC=arm-linux-gcc ./configure --host=i686-linux
--target=arm-linux
make
make install

then compiled and installed the libasound.*/ asound.h
to /usr/lib and /usr/include/sys.
Then I try to cross compile the alsa-utils:

CC=arm-linux-gcc ./configure --host=arm-linux
--target=arm-linux

checking for libasound headers version >= 0.9.0... not
present.
configure: error: Sufficiently new version of
libasound not found.

So how to make it and is there any simple method to
test the alsa?

Thanks a lot
Best Regards

Bryan Wu


_________________________________________________________
Do You Yahoo!? 
œ”” œ‰Ã´–°£ø—≈ª¢µÁ” ◊‘÷˙¿©»›£°
http://cn.rd.yahoo.com/mail_cn/tag/10m/*http://cn.mail.yahoo.com/event/10m.html


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
