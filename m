From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: wrong channel mappings for HDMI audio
Date: Sat, 13 Nov 2010 00:07:08 +0200
Message-ID: <4CDDBA8C.30600@iki.fi>
References: <87fwv8puuo.fsf@uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
	[83.102.40.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AFFB103943
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 23:07:12 +0100 (CET)
In-Reply-To: <87fwv8puuo.fsf@uwo.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Christensen <jdc@uwo.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11.11.2010 02:27, Dan Christensen wrote:
> [System specs at end.]
> 
> When I try to use 5.1 audio over HDMI, the front left and front right
> channels are correct, but the others are wrong:
> 
> - surround (rear) left and center are swapped
> - surround (rear) right and LFE are swapped
[...]
> James Courtier-Dutton suggested that I report this here, in the hopes
> that ALSA can be taught the correct mapping for my sound card.
> 
> I'm also interested in the best way to work around this in the meantime.
> 
> Thanks for any help!
> 
> Dan
> 
> System specs:
> 
> Motherboard: Gigabyte GA-E7AUM-DS2H
>   http://gigabyte.com/products/product-page.aspx?pid=2946#ov
[...]

This is a known issue, the NVIDIA MCP79/7A HDMI hardware has incorrect
channel mapping.

I reported this several months ago as "Wrong channel order with
multichannel HDMI on MCP7A":
http://www.spinics.net/lists/alsa-devel/msg35948.html
(there are some earlier reports from 2009 as well)

I'm using this workaround at the moment:
 pcm.!hdmi {
     type             route
     slave.pcm
"cards.HDA-Intel.pcm.hdmi.0:CARD=NVidia,AES0=0x4,AES1=0x82,AES2=0x0,AES3=0x2"
     ttable.0.0 1
     ttable.1.1 1
     ttable.2.4 1
     ttable.3.5 1
     ttable.4.2 1
     ttable.5.3 1
     ttable.6.6 1
     ttable.7.7 1
 }

(not a perfect workaround as I'm hardcoding AESx instead of using the
ones provided as arguments, but at least you get the idea)

As for the preferred solution to this problem, as far as I understand,
that would be for the driver to have some ioctl that would provide
alsa-lib information about the unusual channel mapping, and alsa-lib
could then remap the channels using a channel remapping plugin.

-- 
Anssi Hannula
