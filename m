From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Sound Driver Querry
Date: Fri, 29 Dec 2006 11:57:42 +0000
Message-ID: <1167393462.11374.25.camel@localhost.localdomain>
References: <b92b327b0612272310r142092e5nc7ca9b4d50c7460e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <b92b327b0612272310r142092e5nc7ca9b4d50c7460e@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Ajay Jain <ajay050@gmail.com>
Cc: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-12-28 at 12:40 +0530, Ajay Jain wrote:

> 
> We have two different ARM based proprietary boards, one with a
> "WM8751" audio codec and the other with a "WM9712" codec. 

What arm cpu are you using ?

> The first
> one supports only the "AIL" (specifically I2S) format, whereas the
> second one supports both "AC97". We have an existing "OSS" audio
> driver for the second one, based on the "AC97" and we use the
> "AC97_codec.c" for the same. Now we also want to support the first
> one, but since it does not have an AC97 support, I was looking for an
> "AIL-I2S" support in the oss directory of the kernel. I do not seem to
> find any mention of AIL/I2S/WM8751.
> 

You may be interested in the ASoC code here:-

http://opensource.wolfsonmicro.com/~lg/asoc/

ASoC basically abstracts out SoC cpu digital audio interfaces and has
architecture independent codec drivers. It also has very aggressive
dynamic audio power management.

Currently, we have platform support for pxa2xx, AT91xxx and S3C24xx
(alpha atm). Work is in progress for i.MX21/31.

> 1. Is this chip/format supported in OSS?
> 2. Is this chip/format supported in the new ALSA?

The WM8751 is currently not supported in ASoC, although it would take
about 2 days effort to add it.

> 3. Can somebody tell me about an OSS mailing list for developers. I
> was on their website, but it does not have any such mention.
> 

OSS audio is deprecated in the Linux 2.6 kernel.

> Does it effectively mean that I will have to shift to the new ALSA (Is
> this chip/format supported ??) ?
> 

Yes.


Liam



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
