From: d <dieb13@klingt.org>
Subject: Re: hdsp9652+alsamixer -> kernel panic
Date: Thu, 29 May 2003 19:22:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ED641E5.5020108@klingt.org>
References: <200305291709.h4TH9WqU004638@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200305291709.h4TH9WqU004638@klingt.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

ok, thanks for your patience with my case.

inbetween i have been able to
1) get another kernel panic with the new kernel+drivers
2) sometimes get some noise with a self-written testtone-prog on channel 
  3 and/or 6 of adat1 (*should* be a sinewave on all 26 channels).
could it be that the S32_LE noninterleaved is interpreted wrong?
4) once got jack+ardour to produce noise (*should* have been music), but 
couldn't repoduce this

seems i'll have to find some other hardware if i want a quick solution

regards
d13b

Paul Davis wrote:
>>sorry for all the noise on the list.
>>i am running a singleprocessor system, but forgot to turn off the smp 
>>support in the kernel config. now - after recompiling everything- the 
>>kernel doesn't panic any more when i adjust the output-levels, but i 
>>still get nothing but silence from my card.
> 
> 
> oh dear. now i realize that i didn't read your subject line carefully
> enough. 
> 
> the hdsp 9652 driver has one major issue at this time. i have been in
> lots of contact with RME to get the problem resolved, but they have
> not followed through on the most recent requests. the driver is not
> setting the card up so that you can hear anything, even though it does
> actually run quite normally. nobody (myself, thomas or anyone else)
> knows what might be wrong, and RME have told me that in theory nothing
> is necessary to make this work: by default, the hdsp9652 works just
> like the old hammerfall (i.e. playback stream N is routed at unity
> gain to output stream N). so, we are basically waiting for RME to
> respond in some way. it will probably turn out to be a one or two line
> change. i wish i could tell you when it will happen, but that would be
> dishonest.
> 
> --p



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
