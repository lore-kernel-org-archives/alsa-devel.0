From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: How to put 16bit none audio PCM data stream into
 a 32bit none audio S/P-DIF transport stream?
Date: Tue, 08 Apr 2003 23:39:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E934193.6090605@cucumelo.org>
References: <20030408140230.GA1987@ulima.unil.ch>	<E192u0x-0007pF-00@sc8-sf-list1.sourceforge.net> <s5hn0j1q97r.wl@alsa2.suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Gregoire Favre <greg@ulima.unil.ch>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>i'm afraid that it's not so easy as it sounds.  it strongly depends
>on the hardware driver implementation...
>
>about AC3, 32bit spdif is likely irrelevant.  A52 (AC3) is usally
>packed into normal 16bit frames.
>
>does the click happen even if you use alsa-tool's ac3dec?
>  
>
Exaclty what do you mean with 32bit spdif ? Sorry, I feel a little bit 
newbie about
the SPDIF protocol specific details.

 From the cs46xx driver point of view, 48khz 16bit audio or AC3 
(non-audio) is the
same thing, 16bit left, 16bit right.
I think the cs46xx HW supports 20 bits resolution, but that's not 
implemented
in the DSP firmware, therefor not supported by the driver (only 16bit 
stereo).

/Benny



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
