From: Jaroslaw Sobierski <fycio@gucio.com>
Subject: Re: Re: dmix plugin
Date: Mon, 17 Feb 2003 14:28:58 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045520938.3e51622ad5e37@webmail2.namezero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: perex@suse.cz
Cc: T.Motylewski@bfad.de, abramo.bagnara@libero.it, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


>> On Mon, 17 Feb 2003, Jaroslav Kysela wrote:
>> 
>> > Note that your all nice ideas go to some blind alley. Who will silence the 
>> > sum buffer? Driver silences only hardware buffer which will not be used 
>> > for the calculation in your algorithm.
>> 
>> Silencing is not time critical, if buffer is big enough it does not matter
>> whether is it done 1 ms or 100 ms after the card has played the data. Therefore
>> it may be done by a separate thread/process/kernel task without any
>> interference with other processes writing to the buffer.
>
>It is time critical for the dmix plugin, because other processes might 
>write new samples to "empty" areas.
>

Clearing the sum buffer would be a task analogous, or I should probably say
reverse, to the saturation operation. You see, before you take the value in
the sum buffer and add your sample and so forth, you can check if the 
destination sample in the DMA buffer is zero. If it is, you disregard the
value in the sum (it is now considered stale), overwrite it with your sample
and proceed to saturate it normally. If another thread has already written
something there - the final buffer will be non-zero, and you proceed as
discussed before, if another thread has written zeroes,or the result has
summed up to zero - it still doesn't matter, because then the sum buffer 
would also have to contain a zero so it is right to disregard it's value. 
And that's it. OK, some synchronization would be in order so that you don't 
kill a sample just written by some other thread as in:

A                         B
check hw buff 0? yes
                          check hw buff 0? yes
                          write B sample to sum/hw
write A sample to sum/hw

A re-read after the write does not solve a problem this time, because
thread B could (though it is very unlikely) have the same sample value.
But I'm sure we can come up with something for this.

That said, I still think it would be a better solution altogether to have
a buffer in an alsa-native not hardware-native format and have the driver
do the translation / saturation and the like. Yeah, I know that's not what
you want, I got it ;-).

--------------
Fycio (J.Sobierski)
 fycio@gucio.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
