From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Audigy 2  support for the P16V HQ chip.
Date: Thu, 01 Jul 2004 21:59:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40E47B35.2090208@superbug.demon.co.uk>
References: <40E1BC8E.4030702@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40E1BC8E.4030702@superbug.demon.co.uk>
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

James Courtier-Dutton wrote:
> This is just a quick update to say that I have managed to get sound 
> output at 96khz and 24bit from the Audigy 2 card using the P16V chip.
> 
> I will post some details later.
> 
> Cheers
> James
> 

For those interested, the alsa p16v driver is at 
http://www.superbug.demon.co.uk/alsa/p16v

It currently supports playback to 5.1 channels, output at rates 44100, 
48000, 96000, 192000. 24bit.

I will be adding capture support next, so we should finally be able to 
capture AC3 input via the spdif inputs of the Audigy2.

The driver uses DMA for direct CPU to P16V chip data path, bypassing the 
EMU10K2 entirely.

I will keep the p16v driver separate from the emu10k1 driver until I 
have found out enough about the P16V chip.

Cheers
James


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
