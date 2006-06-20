From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: IO streams sync
Date: Tue, 20 Jun 2006 21:18:22 +0100
Message-ID: <4498580E.3010902@superbug.co.uk>
References: <mailman.4401.1150734905.2958.alsa-devel@lists.sourceforge.net>
	<4497D028.5060604@openstudionetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4497D028.5060604@openstudionetworks.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alejandro <alejandro@openstudionetworks.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

alejandro wrote:
>>
> 
> Lee and James,
> 
> It is not possible to sync two interfaces if we don't have timestamped
> frame numbering (UST/MSC pairs). That means that we need to know, from a
> common clock, the time at which a (numbered) frame will be output or was
> input from a jack. Current time is not usable, because obviously there
> is an unknown delay between function calls. If the system is not able to
> produce timestamp/frame count pairs, there is no possibility to sync
> audio streams or audio to video streams. I have looked at JACK, and the
> situation is the same as with the ALSA API.
> 
> There are cards in the market with such timestamped operations supported
> in the hardware and proprietary APIs, but is there a way to accessing
> these operations from ALSA or JACK?
> 
> Thank you,
> 
> Alejandro
> 
> 

I think you are wrong. Just take a look at xine playing a DVD. The audio
and video are in perfect sync. It can be done with the current API.

James
