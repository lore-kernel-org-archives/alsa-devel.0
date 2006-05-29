From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: dB gain
Date: Mon, 29 May 2006 16:12:34 +0100
Message-ID: <447B0F62.6010802@superbug.co.uk>
References: <4478A290.80702@superbug.co.uk> <s5hverp7zcr.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0605291540430.11164@tm8103-a.perex-int.cz>
	<Pine.LNX.4.61.0605291601230.11164@tm8103-a.perex-int.cz>
	<s5hbqtg9a8a.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0605291630000.11164@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net
	[194.217.242.85])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6C8D6159
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 17:12:35 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0605291630000.11164@tm8103-a.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Mon, 29 May 2006, Takashi Iwai wrote:
> 
>> What we'll get by this compression is only the reduction of ioctl
>> size.  But, these ioctls are called not so often and no time-critical
>> task.
> 
> Nope. I'm talking about saving code in alsa-lib. Having a special case in 
> alsa-lib for all hints is not really good. If you can store all necessary 
> ranges to 32-bit value (which is allocated anyway) is a win. Of course, 
> all mechanisms as James proposed will not be changed. I see only one 
> problem why my proposal is not acceptable - we must store also the 
> identifier type to the 32-bit value in the kernel side. Also, having both 
> min and max values is not necessary (it can be evaluated from step).
> 
I don't understand where you think you are making a win with these
32-bit values? None of the information is stored in alsa-lib after the
function has returned to the user app. It is all temporary use.

I don't have min and max values.
I have:
int32_t db_per_devision; /* Use db per devision * 100 */
int32_t db_offset; /* Use dB offset * 100. This identifies the 0dB point */
int32_t db_mute; /* The value, before conversion, that is equivalent to
MUTE */

Now, not all controls have a mute at the minimum value.
If the minimum % is a mute, then the db_mute == this minimum % value.
If the minimum % is not mute, then the db_mute equals a value outside
the % range, so the comparison to db_mute is always false for that control.

The current type implemented is:
For simple  dB*100 = (X * db_per_devision) - db_offset
with a special case for detecting the mute value.

More complex conversion functions will have a different equation, and
therefore possibly a different amount of parameters, so one would just
implement a new type, and parse as many parameters from it as we need.

James
