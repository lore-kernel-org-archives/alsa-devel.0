From: Stas Sergeev <stsp@aknet.ru>
Subject: [announce] PC-Speaker driver
Date: Thu, 19 Aug 2004 14:56:55 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <41248777.4010408@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello.

I have made a PC-Speaker driver for ALSA.
It can be downloaded here:

http://www.geocities.com/stssppnn/pcsp.html

You need to apply 2 patches from that page:
"Kernel patch" and "ALSA driver patch".
That driver makes it possible to use the
internal PC-Speaker as the sound card, and
it produces the sound of a reasonable quality.

That driver still has a few problems which
I wasn't able to resolve yet. Actually it
works very bad with alsa-lib-1.0.3a-2 from
FC2 distro, but with alsa-lib-1.0.6 it works
almost flawlessly here. No problems with ogg123,
mpg123 and some other players I have tested.
Well, a few problems to mention:
- pcm.c test from alsa-lib does't work:
---
ALSA lib pcm.c:824:(snd_pcm_sw_params) snd_pcm_sw_params: params->avail_min problem for start_threshold
pcm: pcm.c:2094: snd_pcm_wait: Assertion `err == 1' failed.
---
Almost certainly an alsa-lib bug. Any
hints about that one?

- dmix doesn't seem to work because it
doesn't seem to support U8 and connecting
dmix->plug causes segmentation fault (I
filled a bug-report for that already).
Is there anything that can be done about
that?

I was trying to keep that driver as simple
as possible, hoping the alsa-lib will do
all the work for me. So now it accepts only
one fixed frequency, one channel and one
format (U8). But I can re-add the mixing/resampling
code that was in the OSS version of that driver
if the alsa-lib can't handle that itself.

My question now is: are there any chances to
get that driver integrated into an ALSA tree,
when all its problems are resolved? The main
problem with it is that it requires adding some
kernel hooks, which is why the driver goes in
2 patches. I expect integrating that hooks
into an official kernel to be very difficult,
but if the ALSA developers to like that driver,
then there are the chances also with the kernel
part, I suppose.

Any suggestions on improving the driver are
appreciated.
Thanks.



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
