From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: How to put 16bit none audio PCM data stream into
 a 32bit none audio S/P-DIF transport stream?
Date: Wed, 09 Apr 2003 08:59:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E93C4CA.4080604@cucumelo.org>
References: <20030408140230.GA1987@ulima.unil.ch> <E192u0x-0007pF-00@sc8-sf-list1.sourceforge.net> <s5hn0j1q97r.wl@alsa2.suse.de> <3E934193.6090605@cucumelo.org> <20030408205515.GB6940@ulima.unil.ch> <3E933EF6.5030601@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> A lot of audio cards can only do SPDIF non-audio data at 48khz.
> Your sample is requesting 44.1khz which could be the problem.
> I do not know if your audio card support 44.1khz non-audio spdif. My 
> SB Live definitely does not. My SB Live can output standard PCM data 
> at different SPDIF rates, but it does re-sampling in hardware. If I 
> wish to bypass the re-sampling hardware (bypass needed otherwise the 
> non-audio data gets mangled) in my SB Live I have to use 48khz. 


non-audio SPDIF on  44.1 khz with the cs46xx driver will definitely not 
work.
Theoretically SPDIF HW supports 32khz 48khz and 96khz (not 44.1khz) but 
32 khz and 96khz rates are not supported by the driver.

So, the SPDIF output is always 48khz, any other rate the DSP will do a 
sample rate conversion to 48 khz, which is fine while it's audio (PCM)
So, outputing sound with 48khz 16bit the DSP wont do any kind of 
procesing to the samples, which is the only case where pass-through can 
work.


>
> A good source of 48 khz non-audio AC3 sound is playing DVDs.
> I know xine handles SPDIF passthru of AC3 soundtracks on DVDs quite 
> easily.
> At least this will test if the problem is 48/44.1 khz or something else.

All tests I've done with xine it always output the AC3 data on 48khz, 
which should work fine.

/Benny



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
