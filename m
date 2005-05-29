From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] emu10k1 cleanups
Date: Sun, 29 May 2005 11:07:55 +0100
Message-ID: <4299947B.30202@superbug.co.uk>
References: <1117339570.19303.4.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1117339570.19303.4.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> I hacked this up quickly, please review.
> 
> Some of these should probably be macros, like 
> 
>     IS_AUDIGY2(emu) 
> 
> for 
> 
>     emu->card_capabilities->ca0108_chip || emu->card_capabilities->ca0151_chip
> 
> etc.
> 
> This will break binary compatibility as some redundant struct members have been removed.
> 
> Lee
> 

Sorry, I can't accept this patch.
Different chips have different capabilities, and the ca0108(Audigy 2
Value) certainly does not have a ca0151 (P16V) chip.
The ca0102 is the DSP chip on Audigy 2 cards (and possibly Audigy 1, I
don't know for sure).
emu10k2 is to indicate that the card has all the same features of the
DSP chip found on Audigy 1 and Audigy 2 and Audigy 2 Value cards.
So, the information is not redundent.


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
